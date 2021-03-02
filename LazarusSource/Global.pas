unit Global;

{$MODE objfpc}{$H+}

interface

uses
 StdCtrls,Controls,Classes,ExtCtrls,Forms,Buttons,ComCtrls,SysUtils,Registry,
 Dialogs;

type
  TSeason       = Record //Season details
   Filename,                           //Filename of season file
   Title            : String;          //Title of season [e.g. 2016/17]
   Num_categories,                     //Number of categories [e.g. 3 for Colour, Monochrome and Creative]
   Num_competitions,                   //Number of competitions in season [usually 6]
   a_Places_to_score,                  //Number of places to score for annual competition
   m_Places_to_score,                  //Number of places to score for monthly competition
   Start_Month,                        //Month when the season starts
   IncEntries,                         //Number of entries to include in the annual competition
   ScoreEntries,                       //Number of best entries per member to include towards POY
   MaxEntries       : Integer;         //Maximum number of entries per person per category (monthly)
   ScoreTotalm,                        //Whether the scores are total or average (monthly)
   ScoreTotala,                        //Whether the scores are total or average (POY)
   SplitEqual       : Boolean;         //Whether to split equal places or not
  end;
  TCompetitions = Record //Competition Details
   Month            : Integer;         //Month number of competition - index into MonthList array
   Title            : String;          //Title of competition [e.g. Open]
   Deleted,                            //Whether is deleted or not
   Ext_judge        : Boolean;         //Is competition judged externally [TRUE] or internally [FALSE]
  end;
  TPhotographs  = Record //Photograph Details
   Competition,                        //Index into Competition array for competition entered
   Category,                           //Index into Category array for category entered
   Author,                             //Index into Members array for author of photograph
   Score            : Integer;         //Final score in competition for photograph
   Title,                              //Title of photograph
   ID,                                 //ID given to photograph at competition
   Voting,                             //String of votes received or ext judged position
   Position,                           //Final position in competition for photograph
   Tally            : String;          //Number of firsts, seconds, etc. awarded, as a string (2 characters per place)
   Counted,                            //Switch used for various checks
   Ignore           : Boolean;         //Switch used to ignore photographs
  end;
  TMembers      = Record //Member Details
   Forename,                           //Forename of member
   Surname          : String;          //Surname of member
   Score            : array of Integer;//Scores acheived towards the annual competition - per category
   Tally            : array of String; //Number of firsts, seconds, etc. awarded, as a string
   Num_photos       : Integer;         //Total number of photographs
{  Num_photos       : array of array of Integer //Number of photographs, per category per competition }
  end;
  TVoting       = Record //Voting Slip Details
   Competition,                        //Index into Competition array for competition
   Category         : Integer;         //Index into Category array for category
   Places           : array of String; //Photographs voted for, in order [length should be same as TSeason.M_places_to_score]
   Used             : Boolean;         //Delete/Undelete flag
  end;

function CreateLabel(name: String; l,t: Integer; parent: TComponent): TLabel;
function CreateEdit(l,t,w: Integer; readonly: Boolean;parent: TComponent): TEdit;
function CreatePanel(title: String; l,t,w: Integer;parent: TComponent): TPanel;
function CreateComboBox(l,t,w: Integer;parent: TComponent): TComboBox;
function CreateCheckBox(l,t: Integer;parent: TComponent): TCheckBox;
function CreateScrollBox(parent: TComponent): TScrollBox;
function CreateSpeedButton(t,tag: Integer; parent: TComponent): TSpeedButton;
function CreatePage(parent: TPageControl; text: String): TTabSheet;
function CreateImage(l,t,tag: Integer; parent: TComponent): TImage;
function ConvertFromID(ID: String): Integer;
function ConvertToID(X: Integer): String;
function IntToPos(i: Integer): String;
function IntToPadStr(S: Integer; P: Char;L: Integer): String;
//function AppVersion: String;
function CompareVersion(current,minimum: String):Boolean;
function extractExtension(filename: String): String;
function SeekLn(var F: TFileStream; tofind: String): Boolean;
function MakeFilenameValid(S: String): String;
procedure Swap(var a,b: Integer); overload;
procedure Swap(var a,b: String); overload;
procedure ArraySort(var p: array of Integer); overload;
procedure ArraySort(var p: array of String); overload;
procedure ArraySortA(var p: array of String);
function FillString(s: Char;l: Integer): String;
procedure OpenReg(key: String);
function DeleteKey(key: String): Boolean;
function GetRegValS(V: String;D: String): String;
procedure GetRegValA(V: String;var D: array of Byte);
function GetRegValI(V: String;D: Cardinal): Cardinal;
function GetRegValB(V: String;D: Boolean): Boolean;
procedure SetRegValS(V: String;D: String);
procedure SetRegValA(V: String;var D: array of Byte);
procedure SetRegValI(V: String;D: Cardinal);
procedure SetRegValB(V: String;D: Boolean);
function ExtractKey(var V: String):String;
function ReadLine(var Stream: TFileStream;var Line: string): boolean;
function CustomMessageDlg(const Msg: string;DlgTypt: TmsgDlgType;button: TMsgDlgButtons;
  Caption: array of string;dlgcaption: string;default: TMsgDlgBtn): Integer;
function GetMonthNumber(i: Integer): Integer;
function WriteLine(var Stream: TFileStream;Line: string): boolean;
function Colour(c: Integer): Integer;
function BoolToStr(X: Boolean): String;

var
 ESCCReg              : TRegistry;
 //Variables used for default settings, read from the registry
 def_categories       : array of String; //Category list
 def_a_scores,                           //Scores towards POY
 def_m_scores         : array of Byte;   //Scores for monthly
 def_num_categories,                     //Number of categories
 def_a_places_to_score,                  //Number of places to score towards POY
 def_m_places_to_score,                  //Number of places to score at monthly
 def_num_competitions,                   //Number of competitions
 def_start_month,                        //Month season starts
 def_inc_entries,                        //Entries to include in annual
 def_score_entries,                      //Best scores to use towards POY
 def_maxentries       : Integer;         //Max entries per person per category
 def_scoretotalm,                        //Score monthly by total or average
 def_scoretotala,                        //Score POY by total or average
 def_splitequal       : Boolean;         //Whether to split equal places
 //Default settings for printing/saving results
 def_ID,                                 //Print ID?
 def_title,                              //Print title?
 def_author,                             //Print author?
 def_position,                           //Print position?
 def_tally_monthly,                      //Print tally on monthly comps?
 def_tally_annual,                       //Print tally on POY comp?
 def_tabulate_m,                         //Tabulate results - manual?
 def_tabulate_a       : Boolean;         //Tabulate results - POY?
 def_sortby,                             //Field to sort by
 def_topPOY           : Integer;         //Print a top xxx in POY

const
 //Date application was last updated
 AppDate                                 = '2nd March 2021';
 AppVersion                              = '0.22';
 //List of months
 MonthList: array[1..13] of String       = ('January',
                                            'February',
                                            'March',
                                            'April',
                                            'May',
                                            'June',
                                            'July',
                                            'August',
                                            'September',
                                            'October',
                                            'November',
                                            'December',
                                            'Annual');
 //Default settings for blank season, if the registry is empty
 c_def_num_categories                    = 3;
 c_def_categories: array[1..6] of String = ('Colour',
                                            'Monochrome',
                                            'Creative',
                                            'Colour Prints',
                                            'Monochrome Prints',
                                            'Creative Prints');
 c_def_a_places_to_score = 20;
 c_def_a_scores: array[1..20] of Byte    = (20,19,18,17,16,15,14,13,12,11,
                                            10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
 c_def_m_places_to_score                 = 4;
 c_def_m_scores: array[1..4] of Integer  = (4,3,2,1);
 c_def_num_competitions                  = 6;
 c_def_start_month                       = 9;
 c_def_inc_entries                       = 2;
 c_def_score_entries                     = 100;
 c_def_splitequal                        = True;
 c_def_scoretotalm                       = True;
 c_def_scoretotala                       = True;
 c_def_maxentries                        = 2;
 //Default settings for printing/saving results
 c_def_ID                                = True;
 c_def_title                             = True;
 c_def_author                            = True;
 c_def_position                          = True;
 c_def_tally_monthly                     = True;
 c_def_tally_annual                      = True;
 c_def_tabulate_a                        = False;
 c_def_tabulate_m                        = False;
 //Sort by options: 0: Position; 1: Title; 2: Author
 c_def_sortby                            = 0;
 c_def_topPOY                            = 10;
 //Other Constants
 ec_AllOff                               = 0;
 ec_OpenSeason                           = 1;
 ec_OpenComp                             = 2;
 //Registry Key to use
 RegKey                                  = '\Software\GJH Software\ESCC Competitions';

implementation

uses MainUnit;

{-------------------------------------------------------------------------------
Function to create a label
-------------------------------------------------------------------------------}
function CreateLabel(name: String; l,t: Integer; parent: TComponent): TLabel;
begin
 Result:=TLabel.Create(parent as TComponent);
 Result.Parent:=parent as TWinControl;
 Result.Caption:=name;
 Result.Top:=t;
 Result.Left:=l;
end;

{-------------------------------------------------------------------------------
Function to create an edit box
-------------------------------------------------------------------------------}
function CreateEdit(l,t,w: Integer;readonly: Boolean;parent: TComponent): TEdit;
begin
 Result:=TEdit.Create(parent as TComponent);
 Result.Parent:=parent as TWinControl;
 Result.Text:='';
 Result.Top:=t;
 Result.Left:=l;
 Result.Width:=w;
 Result.Height:=MainForm.controlheight;
 Result.ReadOnly:=readonly;
 Result.OnEnter:=@MainForm.comp_titleEnter;
 Result.OnClick:=@MainForm.comp_titleEnter;
end;

{-------------------------------------------------------------------------------
Function to create a panel
-------------------------------------------------------------------------------}
function CreatePanel(title: String; l,t,w: Integer;parent: TComponent): TPanel;
begin
 Result:=TPanel.Create(parent as TComponent);
 Result.Parent:=parent as TWinControl;
 Result.Caption:=title;
 Result.Top:=t;
 Result.Left:=l;
 Result.Width:=w;
 Result.Height:=MainForm.controlheight;
 Result.ParentBackground:=False;
end;

{-------------------------------------------------------------------------------
Function to create a combo box
-------------------------------------------------------------------------------}
function CreateComboBox(l,t,w: Integer;parent: TComponent): TComboBox;
begin
 Result:=TComboBox.Create(parent as TComponent);
 Result.Parent:=parent as TWinControl;
 Result.Top:=t;
 Result.Left:=l;
 Result.Width:=w;
 Result.Height:=MainForm.controlheight;
 Result.Style:=csDropDownList;
 {Result.Items}
end;

{-------------------------------------------------------------------------------
Function to create a check box
-------------------------------------------------------------------------------}
function CreateCheckBox(l,t: Integer;parent: TComponent): TCheckBox;
begin
 Result:=TCheckBox.Create(parent as TComponent);
 Result.Parent:=parent as TWinControl;
 Result.Top:=t;
 Result.Left:=l;
 Result.Width:=17;
 Result.Checked:=false;
end;

{-------------------------------------------------------------------------------
Create a Page Control Sheet
-------------------------------------------------------------------------------}
function CreatePage(parent: TPageControl; text: String): TTabSheet;
begin
  Result:=TTabSheet.Create(parent);
  Result.PageControl:=parent;
  Result.Caption:=text;
end;

{-------------------------------------------------------------------------------
Create a ScrollBox
-------------------------------------------------------------------------------}
function CreateScrollBox(parent: TComponent): TScrollBox;
begin
  Result:=TScrollBox.Create(parent as TComponent);
  Result.Parent:=parent as TWinControl;
  Result.Align:=alClient;
end;

{-------------------------------------------------------------------------------
Create a Speed Button
-------------------------------------------------------------------------------}
function CreateSpeedButton(t,tag: Integer; parent: TComponent): TSpeedButton;
begin
  Result:=TSpeedButton.Create(parent as TComponent);
  Result.Parent:=parent as TWinControl;
  Result.Top:=t;
  Result.Left:=0;
  Result.Tag:=tag;
  Result.Width:=20;
  Result.Height:=20;
  Result.Glyph:=MainForm.add_btn_src.Glyph;
  Result.OnClick:=MainForm.add_btn_src.OnClick;
  Result.Visible:=true;
  Result.Flat:=true;
end;

{-------------------------------------------------------------------------------
Create an Image
-------------------------------------------------------------------------------}
function CreateImage(l,t,tag: Integer; parent: TComponent): TImage;
begin
  Result:=TImage.Create(parent as TComponent);
  Result.Parent:=parent as TWinControl;
  Result.Top:=t;
  Result.Left:=l;
  Result.Tag:=tag;
  Result.Width:=16;
  Result.Height:=16;
  Result.Picture:=MainForm.pic_judge.Picture;
  Result.Transparent:=True;
  Result.OnClick:=@MainForm.pic_judgeClick;
  Result.Visible:=true;
  Result.Hint:='Change to External Judging';
end;

{-------------------------------------------------------------------------------
Function to convert a photo ID into a number
-------------------------------------------------------------------------------}
function ConvertFromID(ID: String): Integer;
begin
 Result:=0;
 if Length(ID)>0 then
   Result:=(ord(ID[1])-64)+(26*(Length(ID)-1));
end;

{-------------------------------------------------------------------------------
Convert from number to ID
-------------------------------------------------------------------------------}
function ConvertToID(X: Integer): String;
var
 len,i: Integer;
 id : Char;
begin
 Result:='';
 len:=((X-1) div 26)+1;
 id :=chr(65+((X-1) mod 26));
 for i:=1 to len do
  Result:=Result+id;
end;

{-------------------------------------------------------------------------------
Add a 'st', 'nd', 'rd' or 'th' to the end of the number
-------------------------------------------------------------------------------}
function IntToPos(i: Integer): String;
var
 x: String;
begin
 Result:=IntToStr(i);
 x:='th';
 if (i<11) or (i>13) then
 begin
  if Copy(Result,Length(Result),1)='1' then x:='st';
  if Copy(Result,Length(Result),1)='2' then x:='nd';
  if Copy(Result,Length(Result),1)='3' then x:='rd';
 end;
 Result:=Result+x;
end;

{-------------------------------------------------------------------------------
Converts an Integer to a string and pads it with L copies of P
-------------------------------------------------------------------------------}
function IntToPadStr(S: Integer; P: Char;L: Integer): String;
var
 i: Integer;
 X: String;
begin
 X:=IntToStr(S);
 for i:=1 to L do
  X:=P+X;
 Result:=Copy(X,(Length(X)-L)+1);
end;

{-------------------------------------------------------------------------------
Get the application version
-------------------------------------------------------------------------------}
{function AppVersion: String;
var
  sFileName  : String;
  iBufferSize: DWORD;
  iDummy     : DWORD;
  pBuffer    : Pointer;
  pFileInfo  : Pointer;
  iVer       : array[1..4] of Word;
begin
 Result:='';
 SetLength(sFileName, MAX_PATH+1);
 SetLength(sFileName,GetModuleFileName(hInstance,PChar(sFileName),MAX_PATH+1));
 iBufferSize:=GetFileVersionInfoSize(PChar(sFileName),iDummy);
 if (iBufferSize>0) then
 begin
  GetMem(pBuffer,iBufferSize);
  try
   GetFileVersionInfo(PChar(sFileName),0,iBufferSize,pBuffer);
   VerQueryValue(pBuffer,'\',pFileInfo,iDummy);
   iVer[1]:=HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS); //Major
   iVer[2]:=LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS); //Minor
   iVer[3]:=HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS); //Release
   iVer[4]:=LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS); //Build
  finally
   FreeMem(pBuffer);
  end;
  Result:=Format('%d.%.2d',[iVer[1],iVer[2]]);
 end;
end;}

{-------------------------------------------------------------------------------
Compare versions
-------------------------------------------------------------------------------}
function CompareVersion(current,minimum: String):Boolean;
var
 curr_major,
 curr_minor,
 min_major,
 min_minor: Integer;
begin
 curr_major:=StrToIntDef(Copy(current,1,Pos('.',current)-1),0);
 curr_minor:=StrToIntDef(Copy(current,Pos('.',current)+1),0);
 min_major:=StrToIntDef(Copy(minimum,1,Pos('.',minimum)-1),0);
 min_minor:=StrToIntDef(Copy(minimum,Pos('.',minimum)+1),0);
 if  (curr_major>=min_major)
 and (curr_minor>=min_minor) then
  Result:=true
 else
  Result:=false;
end;

{-------------------------------------------------------------------------------
Function to extract the file extension from a filename
-------------------------------------------------------------------------------}
function extractExtension(filename: String): String;
var
 s: String;
 i: Integer;
begin
 i:=Length(filename);
 Repeat
  i:=i-1;
 until (Copy(filename,i,1)='.') or (Copy(filename,i,1)=',') or (i=-1);
 if i>=0 then
  s:=LowerCase(Copy(filename,i,(Length(filename)-i)+1))
 else
  s:='';
 Result:=s;
end;

{-------------------------------------------------------------------------------
Function finds the appropriate line in the file, or returns false if not found
-------------------------------------------------------------------------------}
function SeekLn(var F: TFileStream; tofind: String): Boolean;
var
 S: String;
begin
 //Moves the pointer to the beginning of the file
 F.Position:=0;//Seek(0,soFromBeginning);
 Result:=False;
 repeat
  ReadLine(F,S);
 until (Copy(S,1,Length(tofind))=tofind) or (F.Position>=F.Size);
 if Copy(S,1,Length(tofind))=tofind then Result:=True;
end;

{-------------------------------------------------------------------------------
Function validates a filename
-------------------------------------------------------------------------------}
function MakeFilenameValid(S: String): String;
var
 i: Integer;
 X: Char;
begin
 Result:='';
 for i:=1 to Length(S) do
 begin
  X:=S[i];
//  if not TPath.IsValidFileNameChar(X) then X:=' ';
  Result:=Result+X;
 end;
end;

{-------------------------------------------------------------------------------
Swaps two integers
-------------------------------------------------------------------------------}
procedure Swap(var a,b: Integer); overload;
var
 i: Integer;
begin
 i:=a;
 a:=b;
 b:=i;
end;

{-------------------------------------------------------------------------------
Swaps two strings
-------------------------------------------------------------------------------}
procedure Swap(var a,b: String); overload;
var
 i: String;
begin
 i:=a;
 a:=b;
 b:=i;
end;

{-------------------------------------------------------------------------------
Sorts an array of integers into descending order
-------------------------------------------------------------------------------}
procedure ArraySort(var p: array of Integer);
var
 i      : Integer;
 swapped: Boolean;
begin
 repeat
 swapped:=false;
 for i:=Low(p)+1 to High(p) do
  if p[i-1]<p[i] then
  begin
   Swap(p[i-1],p[i]);
   swapped:=true;
  end;
 until not swapped;
end;

{-------------------------------------------------------------------------------
Sorts an array of strings into reverse alphabetical/numerical order
-------------------------------------------------------------------------------}
procedure ArraySort(var p: array of String);
var
 i      : Integer;
 swapped: Boolean;
begin
 repeat
 swapped:=false;
 for i:=Low(p)+1 to High(p) do
  if p[i-1]<p[i] then
  begin
   Swap(p[i-1],p[i]);
   swapped:=true;
  end;
 until not swapped;
end;

{-------------------------------------------------------------------------------
Sorts an array of strings into alphabetical/numerical order
-------------------------------------------------------------------------------}
procedure ArraySortA(var p: array of String);
var
 i      : Integer;
 swapped: Boolean;
begin
 repeat
 swapped:=false;
 for i:=Low(p)+1 to High(p) do
  if p[i-1]>p[i] then
  begin
   Swap(p[i-1],p[i]);
   swapped:=true;
  end;
 until not swapped;
end;

{-------------------------------------------------------------------------------
Returns a string filled with 'l' number of character 's'
-------------------------------------------------------------------------------}
function FillString(s: Char;l: Integer): String;
var
 i: Integer;
begin
 Result:='';
 for i:=1 to l do
  Result:=Result+s;
end;

{-------------------------------------------------------------------------------
Open the registry key
-------------------------------------------------------------------------------}
procedure OpenReg(key: String);
begin
 ESCCReg:=TRegistry.Create;
 if key<>'' then key:='\'+key;
 ESCCReg.OpenKey(RegKey+key,true);
end;

{-------------------------------------------------------------------------------
Function to delete a key from the registry
-------------------------------------------------------------------------------}
function DeleteKey(key: String): Boolean;
var
 x: Boolean;
begin
 x:=True;
 OpenReg(ExtractKey(key));
 if ESCCReg.ValueExists(key) then x:=ESCCReg.DeleteValue(key);
 ESCCReg.Free;
 Result:=x;
end;

{-------------------------------------------------------------------------------
Function to read a string from the registry, or create it if it doesn't exist
-------------------------------------------------------------------------------}
function GetRegValS(V: String;D: String): String;
var
 X: String;
begin
 OpenReg(ExtractKey(V));
 If ESCCReg.ValueExists(V)then X:=ESCCReg.ReadString(V)
 else begin X:=D;ESCCReg.WriteString(V,X);end;
 ESCCReg.Free;
 Result:=X;
end;

{-------------------------------------------------------------------------------
Function to read an array from the registry, or create it if it doesn't exist
-------------------------------------------------------------------------------}
procedure GetRegValA(V: String;var D: array of Byte);
var
 s: Integer;
begin
 OpenReg(ExtractKey(V));
 If ESCCReg.ValueExists(V)then
 begin
  s:=ESCCReg.GetDataSize(V);
  ESCCReg.ReadBinaryData(V,D,s);
 end
 else
 begin
  ESCCReg.WriteBinaryData(V,D,SizeOf(D));
 end;
 ESCCReg.Free;
end;

{-------------------------------------------------------------------------------
Function to read an integer from the registry, or create it if it doesn't exist
-------------------------------------------------------------------------------}
function GetRegValI(V: String;D: Cardinal): Cardinal;
var
 X: Cardinal;
begin
 OpenReg(ExtractKey(V));
 If ESCCReg.ValueExists(V)then X:=ESCCReg.ReadInteger(V)
 else begin X:=D;ESCCReg.WriteInteger(V,X);end;
 ESCCReg.Free;
 Result:=X;
end;

{-------------------------------------------------------------------------------
Function to read a boolean from the registry, or create it if it doesn't exist
-------------------------------------------------------------------------------}
function GetRegValB(V: String;D: Boolean): Boolean;
var
 X: Boolean;
begin
 OpenReg(ExtractKey(V));
 If ESCCReg.ValueExists(V)then X:=ESCCReg.ReadBool(V)
 else begin X:=D;ESCCReg.WriteBool(V,X);end;
 ESCCReg.Free;
 Result:=X;
end;

{-------------------------------------------------------------------------------
Function to save a string to the registry
-------------------------------------------------------------------------------}
procedure SetRegValS(V: String;D: String);
begin
 OpenReg(ExtractKey(V));
 ESCCReg.WriteString(V,D);
 ESCCReg.Free;
end;

{-------------------------------------------------------------------------------
Function to save an array to the registry
-------------------------------------------------------------------------------}
procedure SetRegValA(V: String;var D: array of Byte);
begin
 OpenReg(ExtractKey(V));
 ESCCReg.WriteBinaryData(V,D,SizeOf(D));
 ESCCReg.Free;
end;

{-------------------------------------------------------------------------------
Function to save an integer to the registry
-------------------------------------------------------------------------------}
procedure SetRegValI(V: String;D: Cardinal);
begin
 OpenReg(ExtractKey(V));
 ESCCReg.WriteInteger(V,D);
 ESCCReg.Free;
end;

{-------------------------------------------------------------------------------
Function to save a boolean to the registry
-------------------------------------------------------------------------------}
procedure SetRegValB(V: String;D: Boolean);
begin
 OpenReg(ExtractKey(V));
 ESCCReg.WriteBool(V,D);
 ESCCReg.Free;
end;

{-------------------------------------------------------------------------------
Function to extract key part of string
-------------------------------------------------------------------------------}
function ExtractKey(var V: String):String;
begin
 Result:='';
 if Pos('\',V)>0 then
 begin
  Result:=Copy(V,1,Pos('\',V)-1);
  V:=Copy(V,Pos('\',V)+1);
 end;
end;

{-------------------------------------------------------------------------------
Reads a line from a TStream
-------------------------------------------------------------------------------}
function ReadLine(var Stream: TFileStream;var Line: string): boolean;
var
 RawLine: UTF8String;
 ch     : AnsiChar;
begin
 Result:=False;
 ch:=#0;
 while (Stream.Read(ch,1)=1) and (ch<>#13) and (ch<>#10) do
 begin
  Result:=True;
  RawLine:=RawLine+UTF8String(ch);
 end;
 Line:=String(RawLine);
 if ch=#13 then
 begin
  Result:=True;
  if (Stream.Read(ch,1)=1) and (ch<>#10) then
   Stream.Seek(-1,soCurrent) // unread it if not LF character.
 end;
 if ch=#10 then
 begin
  Result:=True;
  if (Stream.Read(ch,1)=1) and (ch<>#13) then
   Stream.Seek(-1,soCurrent) // unread it if not CR character.
 end;
end;

{-------------------------------------------------------------------------------
Custom Message Dialogue
-------------------------------------------------------------------------------}
function CustomMessageDlg(const Msg: string;DlgTypt: TmsgDlgType;button: TMsgDlgButtons;
  Caption: array of string;dlgcaption: string;default: TMsgDlgBtn): Integer;
var
 aMsgdlg     : TForm;
 i,x         : Integer;
 Dlgbutton   : Tbutton;
 Captionindex: Integer;
begin
{ aMsgdlg:=createMessageDialog(Msg,DlgTypt,button,default);
 aMsgdlg.Caption:=dlgcaption;
 Captionindex:=0;
 x:=Length(Caption);
 for i:=0 to aMsgdlg.componentcount-1 Do
 begin
  if (aMsgdlg.components[i] is Tbutton) then
  begin
   Dlgbutton:=Tbutton(aMsgdlg.components[i]);
   if Captionindex<=High(Caption) then
   begin
    Dlgbutton.Caption:=Caption[Captionindex];
    Dlgbutton.Width:=128;
    Dlgbutton.Left:=((aMsgdlg.ClientWidth div x)*Captionindex)
                   +(((aMsgdlg.ClientWidth div x)-Dlgbutton.Width)div 2);
   end;
   inc(Captionindex);
  end;
 end;
 Result:=aMsgdlg.Showmodal;}
end;

{-------------------------------------------------------------------------------
Return month number, given competition number and using the start month
-------------------------------------------------------------------------------}
function GetMonthNumber(i: Integer): Integer;
begin
 Result:=((i+MainForm.season.Start_Month-2)mod 12);
end;

{-------------------------------------------------------------------------------
Writes a string to the TFileStream, and terminates it with 0x0A
-------------------------------------------------------------------------------}
function WriteLine(var Stream: TFileStream;Line: string): boolean;
var
 l,x: Integer;
 S: UTF8String;
begin
 S:=UTF8String(Line+#10);
 l:=Length(S);
 x:=Stream.Write(S[1],l);
 Result:=x=l;
end;

{-------------------------------------------------------------------------------
Function to convert a number into a colour
-------------------------------------------------------------------------------}
function Colour(c: Integer): Integer;
var
 r,g,b,m: Byte;
begin
 r:= c mod 2;
 g:=(c mod 4)div 2;
 b:=(c mod 8)div 4;
 m:=$FF-(((c mod 128) div 8)*$11);
 Result:=(r*m)+(g*m*$100)+(b*m*$10000);
 if (r=1) and (g=1) and (b=1) then
  Result:=((m-$11)*$100)+((m-$22)*$10000);
 if (r=0) and (g=0) and (b=0) then
  Result:=(m-$22)+((m-$11)*$100);
end;

{-------------------------------------------------------------------------------
Function to convert a number into a colour
-------------------------------------------------------------------------------}
function BoolToStr(X: Boolean): String;
begin
 if X then Result:='TRUE' else Result:='FALSE';
end;

end.
