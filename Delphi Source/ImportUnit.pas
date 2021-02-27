unit ImportUnit;

interface

uses
  Winapi.Windows,Winapi.Messages,System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics,Vcl.Controls,Vcl.Forms,Vcl.Dialogs,Global, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TStringArray = array of String;
  TImportForm = class(TForm)
    Panel1: TPanel;
    sg_Columns: TStringGrid;
    Label1: TLabel;
    cb_ColContents: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    cb_Headers: TCheckBox;
    procedure sg_ColumnsFixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure cb_ColContentsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function LoadCSV(filename: String;DDList: array of String): Integer;
    function ExplodeCSVLine(S: String): TStringArray;
    procedure cb_HeadersClick(Sender: TObject);
  private
    firstRow: array of String;
  public
    counter: Integer;
  end;

var
  ImportForm: TImportForm;

implementation

{$R *.dfm}

{-------------------------------------------------------------------------------
User has changed the drop down item
-------------------------------------------------------------------------------}
procedure TImportForm.cb_ColContentsChange(Sender: TObject);
var
 i: Integer;
begin
 //Change the header text to the newly selected
 sg_Columns.Cells[sg_Columns.Selection.Left,0]:=
                                 cb_ColContents.Items[cb_ColContents.ItemIndex];
 //Iterate through the other columns to make sure there are no duplicates
 //changing them to "Don't Import" - which is the only duplicate allowed
 for i:=0 to sg_Columns.ColCount-1 do
  if  (i<>sg_Columns.Selection.Left)
  and (sg_Columns.Cells[i,0]=sg_Columns.Cells[sg_Columns.Selection.Left,0]) then
   sg_Columns.Cells[i,0]:=cb_ColContents.Items[0];
end;

{-------------------------------------------------------------------------------
Form is showing, so reset the controls
-------------------------------------------------------------------------------}
procedure TImportForm.FormShow(Sender: TObject);
begin
 cb_ColContents.Enabled:=False;
 cb_ColContents.ItemIndex:=0;
 cb_Headers.Checked:=False;
end;

{-------------------------------------------------------------------------------
User has clicked on the header row of the grid
-------------------------------------------------------------------------------}
procedure TImportForm.sg_ColumnsFixedCellClick(Sender: TObject; ACol,
  ARow: Integer);
var
 S: TGridRect;
begin
 //Set up the selection area - ie. the column, except for the header
 S.Top:=1;
 S.Bottom:=sg_Columns.RowCount-1;
 S.Left:=ACol;
 S.Right:=ACol;
 //Select it
 sg_Columns.Selection:=S;
 //Change the drop down list to match the column header
 cb_ColContents.ItemIndex:=
                         cb_ColContents.Items.IndexOf(sg_Columns.Cells[ACol,0]);
 //Enable the drop down list
 cb_ColContents.Enabled:=True;
end;

{-------------------------------------------------------------------------------
OK
-------------------------------------------------------------------------------}
procedure TImportForm.SpeedButton1Click(Sender: TObject);
var
 i: Integer;
begin
 //Check that there are columns to import
 counter:=0;
 for i:=0 to sg_Columns.ColCount-1 do
  counter:=counter+cb_ColContents.Items.IndexOf(sg_Columns.Cells[i,0]);
 //Only return an 'OK' if there are columns to import, otherwise Cancel
 if counter>0 then ModalResult:=mrOK else ModalResult:=mrCancel;
end;

{-------------------------------------------------------------------------------
Cancel
-------------------------------------------------------------------------------}
procedure TImportForm.SpeedButton2Click(Sender: TObject);
begin
 ModalResult:=mrCancel;
end;

{-------------------------------------------------------------------------------
Function to load a CSV file into the form - returns number of columns
-------------------------------------------------------------------------------}
function TImportForm.LoadCSV(filename: String;DDList: array of String): Integer;
var
 F: TFileStream;
 S: String;
 X,maxX,i: Integer;
 CSVLine: TStringArray;
begin
 cb_Headers.Checked:=False;
 SetLength(firstRow,0);
 //Setup Import Dialogue box
 cb_ColContents.Items.Clear;
 cb_ColContents.Items.Add('Don''t Import');
 for i:=Low(DDList) to High(DDList) do
  cb_ColContents.Items.Add(DDList[i]);
 cb_ColContents.ItemIndex:=0;
 sg_Columns.RowCount:=1;
 //Load the file into the StringGrid
 F:=TFileStream.Create(filename,fmOpenRead);
 //Move to the beginning of the file
 F.Seek(0,soFromBeginning);
 //Read it in, line by line
 maxX:=0;
 repeat
  ReadLine(F,S);
  //Explode the line
  CSVLine:=ExplodeCSVLine(S);
  //Get the number of columns
  X:=Length(CSVLine);
  if X>maxX then
  begin
   maxX:=X;
   //Expand the grid to suit
   sg_Columns.ColCount:=maxX;
  end;
  //Add a new line
  sg_Columns.RowCount:=sg_Columns.RowCount+1;
  //Populate the line
  for i:=0 to X-1 do
   sg_Columns.Cells[i,sg_Columns.RowCount-1]:=CSVLine[i];
 until F.Position>=F.Size;
 //Close the file
 F.Free;
 //Set the number of fixed rows
 sg_Columns.FixedRows:=1;
 //Save the first row
 SetLength(firstRow,maxX);
 for i:=0 to maxX-1 do
  firstRow[i]:=sg_Columns.Cells[i,1];
 //Return the max number of columns
 Result:=maxX;
end;

{-------------------------------------------------------------------------------
Toggles whether the first line in CSV contains the headers
-------------------------------------------------------------------------------}
procedure TImportForm.cb_HeadersClick(Sender: TObject);
var
 rows,cols: Integer;
begin
 if cb_Headers.Checked then //User has ticked the box
 begin
  //Move everything up one row
  for rows:=1 to sg_Columns.RowCount-2 do
   for cols:=0 to sg_Columns.ColCount-1 do
    sg_Columns.Cells[cols,rows]:=sg_Columns.Cells[cols,rows+1];
  //Remove the last row
  sg_Columns.RowCount:=sg_Columns.RowCount-1;
  //Take the saved first row and see if it matches the defined headers
  for cols:=0 to sg_Columns.ColCount-1 do
   if cols<Length(firstrow) then
   begin
    rows:=cb_ColContents.Items.IndexOf(firstrow[cols]);
    if rows<0 then rows:=0;
    sg_Columns.Cells[cols,0]:=cb_ColContents.Items[rows];
   end;
 end
 else                       //User has unticked the box
 begin
  //Add a new row
  sg_Columns.RowCount:=sg_Columns.RowCount+1;
  //Move everything down one row
  for rows:=sg_Columns.RowCount-1 downto 2 do
   for cols:=0 to sg_Columns.ColCount-1 do
    sg_Columns.Cells[cols,rows]:=sg_Columns.Cells[cols,rows-1];
  //Restore the original first row, from the saved row
  for cols:=0 to Length(firstrow)-1 do
   sg_Columns.Cells[cols,1]:=firstrow[cols];
 end;
end;

{-------------------------------------------------------------------------------
Explode a CSV line into an array of Strings
-------------------------------------------------------------------------------}
function TImportForm.ExplodeCSVLine(S: String) : TStringArray;
 //Function to remove the surrounding quotes
 function removeQuotes(S: String): String;
 begin
  if  (Copy(S,1,1)='"')
  and (Copy(S,Length(S),1)='"') then
   Result:=Copy(S,2,Length(S)-2)
  else Result:=S;
 end;
//Main function starts here
var
 I,numCols,n,p,e: Integer;
 quote: Boolean;
begin
 //First, work out the number of columns
 numCols:=1;
 quote:=False;
 for i:=0 to Length(S) do
 begin
  if S[i]='"' then quote:=not quote;
  if (S[i]=',') and (not quote) then inc(numCols);
 end;
 SetLength(Result,numCols);
 //Now separate the columns
 p:=1;
 for I:=0 to numCols-1 do
 begin
  n:=p-1;
  quote:=false;
  //Find the next comma, but ignore if it is between quotes
  repeat
   inc(n);
   if n>Length(S) then n:=Length(S);
   if S[n]='"' then quote:=not quote;
  until ((S[n]=',') and (not quote)) or (n=Length(S));
  if I=numCols-1 then e:=n else e:=n-p;
  Result[I]:=removeQuotes(Copy(S,p,e));
  p:=n+1;
 end;
 //This could be improved on by only going through the string once, instead of
 //twice - first getting the number of columns, then second extracting them.
end;

end.
