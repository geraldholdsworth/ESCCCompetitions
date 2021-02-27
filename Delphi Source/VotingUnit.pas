unit VotingUnit;

interface

uses
  SysUtils,Controls,Forms,Dialogs,StdCtrls,Buttons,ExtCtrls,StrUtils,Global,
  Classes,UITypes,Graphics;

type
  TVotingForm = class(TForm)
    CancelBtn: TBitBtn;
    OKbtn: TBitBtn;
    pnl_slipnum: TPanel;
    procedure OKbtnClick(Sender: TObject);
    procedure Pos_1_1Change(Sender: TObject);
    procedure FreeControls;
    procedure FormShow(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
  public
    Positions: array of array of TEdit;
    panels: array of TPanel;
  end;

var
  VotingForm: TVotingForm;

implementation

{$R *.dfm}

uses MainUnit;

{-------------------------------------------------------------------------------
OK clicked
-------------------------------------------------------------------------------}
procedure TVotingForm.OKbtnClick(Sender: TObject);
var
 Valid: Boolean;
 cat,pos: Integer;
 reason: String;
begin
 Valid:=False;
 reason:='At least one vote must be entered.';
 //Check is in the range A-Z
 for cat:=0 to MainForm.season.Num_categories-1 do
  for pos:=0 to MainForm.season.m_Places_to_score-1 do
   if Positions[cat,pos].Text<>'' then
    if (Copy(Positions[cat,pos].Text,1,1)>'A')
    and (Copy(Positions[cat,pos].Text,1,1)<'Z') then Valid:=True;
 //Check that entry is not above max ID
 for cat:=0 to MainForm.season.Num_categories-1 do
  for pos:=0 to MainForm.season.m_Places_to_score-1 do
   if ConvertFromID(Positions[cat,pos].Text)>
      ConvertFromID(MainForm.edit_maxphotoID[cat].Text) then
   begin
    Positions[cat,pos].Color:=clRed;
    Valid:=False;
    reason:='At least one vote is beyond specified maximum ID.';
   end;
 if Valid then
 begin
  //FreeControls;
  ModalResult:=mrOK;
 end
 else MessageDlg('Invalid Voting Slip.'+#13#10+
                 reason+#13#10+
                 'Please recheck.',mtError,[mbOK],0);
end;

{-------------------------------------------------------------------------------
Free the controls created in FormShow
-------------------------------------------------------------------------------}
procedure TVotingForm.FreeControls;
var
 cat,pos: Integer;
begin
 for cat:=0 to Length(panels)-1 do
  panels[cat].Free;
 for cat:=0 to MainForm.season.Num_categories-1 do
  for pos:=0 to MainForm.season.m_Places_to_score-1 do
   Positions[cat,pos].Free;
 SetLength(panels,0);
 SetLength(Positions,0);
end;

{-------------------------------------------------------------------------------
Cancel is clicked
-------------------------------------------------------------------------------}
procedure TVotingForm.CancelBtnClick(Sender: TObject);
begin
 FreeControls;
end;

{-------------------------------------------------------------------------------
Form is showing
-------------------------------------------------------------------------------}
procedure TVotingForm.FormShow(Sender: TObject);
var
 i,j,k: Integer;
begin
 //Make room for the edit boxes
 SetLength(Positions,
           MainForm.season.Num_categories,
           MainForm.season.m_Places_to_score);
 SetLength(panels,
      MainForm.season.Num_categories*(4+(2*MainForm.season.m_Places_to_score)));
 //Create all the controls for the form
 k:=0;
 for i:=0 to MainForm.season.Num_categories-1 do
 begin
  //First, category headers
  panels[k]:=CreatePanel(MainForm.categories[i]+' Competition',8+(165*i),
                         4,159,self);
  inc(k);
  //Second, column headers
  panels[k]:=CreatePanel('Place',   8+(165*i),26,49,self);
  inc(k);
  panels[k]:=CreatePanel('Image',  63+(165*i),26,49,self);
  inc(k);
  panels[k]:=CreatePanel('Points',118+(165*i),26,49,self);
  inc(k);
  //And finally, the cells themselves
  for j:=0 to MainForm.season.m_places_to_score-1 do
  begin
   //Places
   panels[k]:=CreatePanel(IntToPos(j+1),8+(165*i),48+(22*j),49,self);
   inc(k);
   //Edit boxes used for entering the votes
   Positions[i,j]:=CreateEdit(63+(165*i),48+(22*j),49,false,self);
   Positions[i,j].OnChange:=Pos_1_1Change;
   Positions[i,j].MaxLength:=MainForm.photo_maxlength;
   Positions[i,j].CharCase:=ecUpperCase;
   Positions[i,j].Alignment:=taCenter;
   //And points received per place
   panels[k]:=CreatePanel(IntToStr(MainForm.m_scoring[j]),
                          118+(165*i),48+(22*j),49,self);
   inc(k);
  end;
 end;
 //Resize the form to accomodate everything
 VotingForm.Width:=16+(165*MainForm.season.Num_categories);
 VotingForm.ClientHeight:=48+8+
                          (22*MainForm.season.m_Places_to_score)+OKBtn.Height;
 //And move the OK and Cancel buttons
 OKBtn.Left:=8;
 OKBtn.Top:=48+(22*MainForm.season.m_Places_to_score);
 CancelBtn.Left:=OKBtn.Left+OKBtn.Width;
 CancelBtn.Top:=OKBtn.Top;
 //Move the Voting Slip number box
 pnl_slipnum.Left:=CancelBtn.Left+CancelBtn.Width;
 pnl_slipnum.Top:=OKBtn.Top;
 //Now give the first edit box focus
 Positions[0,0].SetFocus;
end;

{-------------------------------------------------------------------------------
One of the edit fields has changed - validate entry
-------------------------------------------------------------------------------}
procedure TVotingForm.Pos_1_1Change(Sender: TObject);
var
 e: TEdit;
 s: String;
 i: Integer;
begin
 With Sender as TEdit do e:=Sender as TEdit;
 s:=e.Text;
 i:=Length(s);
 if i>1 then
 begin
  e.Text:=DupeString(Copy(s,1,1),i);
  e.SelStart:=i;
 end;
end;

end.
