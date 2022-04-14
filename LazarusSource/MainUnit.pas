unit MainUnit;

{$MODE objfpc} {$H+}

{
ESCC Competitions written and designed by Gerald J Holdsworth
(C)2015-2021 Gerald J Holdsworth & East Sutherland Camera Club
Graphics by Gerald J Holdsworth & Andy Kirby
http://www.eastsutherlandcc.org.uk
http://www.geraldholdsworth.co.uk
https://github.com/geraldholdsworth/ESCCCompetitions
}

interface

uses
 SysUtils,Classes,Graphics,Forms,Controls,StdCtrls,Dialogs,Buttons,ExtCtrls,
 ComCtrls,Global,Printers,LCLIntf,ActnList,Menus,PrintersDlgs,StrUtils,Types;

type
 TMembersArray = array of TMembers;
 TCompetitionArray = array of TCompetitions;

type

  { TMainForm }

  TMainForm = class(TForm)
    BigImages: TImageList;
    ToolBar1: TToolBar;
    NewSeason: TToolButton;
    SeasonPanel: TPanel;
    Splitter1: TSplitter;
    CompetitionPanel: TPanel;
    Splitter2: TSplitter;
    comp_title: TEdit;
    OpenSeason: TToolButton;
    escc_open: TOpenDialog;
    escc_Save: TSaveDialog;
    AboutButton: TToolButton;
    comp_date: TComboBox;
    cat_pages: TPageControl;
    LoadMembers: TToolButton;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    btn_votingslip: TToolButton;
    ToolButton2: TToolButton;
    btn_delphotographs: TToolButton;
    print_btn: TToolButton;
    btn_results: TToolButton;
    btn_saveresults: TToolButton;
    btn_a_results: TToolButton;
    btn_save_a_results: TToolButton;
    btn_prt_a_results: TToolButton;
    csv_Save: TSaveDialog;
    PrintDialog1: TPrintDialog;
    btn_recalculate: TToolButton;
    season_title: TEdit;
    pic_judge: TImage;
    btn_opencomp: TSpeedButton;
    no_ext_judge: TImage;
    sb_complist: TScrollBox;
    member_open: TOpenDialog;
    btn_importphotos: TToolButton;
    csv_open: TOpenDialog;
    KeyboardShortcuts: TActionList;
    act_NewVotingSlip: TAction;
    WebLinkBtn: TToolButton;
    Panel1: TPanel;
    sb_closecomp: TSpeedButton;
    Panel2: TPanel;
    act_OpenSeason: TAction;
    act_NewSeason: TAction;
    act_ImportMembers: TAction;
    act_DisplayPOY: TAction;
    act_PrintPOY: TAction;
    act_SavePOY: TAction;
    act_DeleteRedundantPhotographs: TAction;
    act_RecalculateResults: TAction;
    act_DisplayCompResults: TAction;
    act_PrintCompResults: TAction;
    act_SaveCompResults: TAction;
    Panel3: TPanel;
    sb_CloseSeason: TSpeedButton;
    sb_editseason: TToolButton;
    ProgressBar1: TProgressBar;
    MemberPanel: TPanel;
    Label3: TLabel;
    SB_MembersList: TScrollBox;
    add_btn_src: TSpeedButton;
    del_btn_src: TSpeedButton;
    OKbtnsrc: TSpeedButton;
    pnl_HeaderMembers: TPanel;
    pnl_PhotosTitle: TPanel;
    pnl_SurnameTitle: TPanel;
    pnl_ForenameTitle: TPanel;
    Panel4: TPanel;
    Splitter3: TSplitter;
    Label1: TLabel;
    sb_vote_graph: TScrollBox;
    vote_graph_master: TImage;
    act_EditSeason: TAction;
    act_ImportPhotos: TAction;
    act_GotoWebsite: TAction;
    act_About: TAction;
    ESCCLogo: TImage;
    settings_btn: TToolButton;
    act_Preferences: TAction;
    PhotoMenu: TPopupMenu;
    InsPhotoMenu: TMenuItem;
    DelPhotoMenu: TMenuItem;
    IgnPhotoMenu: TMenuItem;
    btn_importonlinecomp: TToolButton;
    procedure AddPhotoControl(comp,cat,x: Integer);
    procedure AddPhotoOrMember(Sender: TObject);
    procedure AddMemberControl(member: Integer);
    procedure AddNewCompControl;
    procedure AddNewCompetition(title: String;month: Integer;ext: Boolean);
    procedure AddNewPhotograph(tab: Integer);
    procedure AddNewMember;
    procedure AddNewVotingSlip(dialogue: Boolean);
    procedure AddVotingControl(comp,x: Integer);
    procedure btn_a_resultsClick(Sender: TObject);
    procedure btn_prt_a_resultsClick(Sender: TObject);
    procedure btn_recalculateClick(Sender: TObject);
    procedure btn_resultsClick(Sender: TObject);
    procedure btn_save_a_resultsClick(Sender: TObject);
    procedure btn_saveresultsClick(Sender: TObject);
    procedure btn_votingslipClick(Sender: TObject);
    procedure ChangeJudgeType(ext: Boolean;var pic: TImage);
    function CheckForDuplicates(f,s: String): Boolean;
    procedure CloseCompetition;
    procedure CloseSeason;
    procedure comp_dateChange(Sender: TObject);
    procedure comp_dateEnter(Sender: TObject);
    procedure comp_titleEnter(Sender: TObject);
    procedure comp_titleKeyUp(Sender: TObject;var Key: Word;Shift: TShiftState);
    function CountPhotographs(member: Integer): Integer;
    procedure DeleteCompetition(comp: Integer);
    procedure DeleteCompetitionClick(Sender: TObject);
    procedure DeleteCompetitionPhotographs(comp: Integer);
    procedure DeleteMember(Sender: TObject);
    procedure DeletePhotograph(cat,i: Integer);
    procedure DeleteRedundantPhotographs(Sender: TObject);
    procedure DeleteVoteSlip(Sender: TObject);
    procedure DelPhotoMenuClick(Sender: TObject);
    procedure DisplayActiveVoteGraph;
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure EditSeason(Sender: TObject);
    procedure EnableControls(lcontrols: Integer);
    procedure FillInPhotoControl(cat,y,x: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure FormShow(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    function FindAuthor(S: String): Integer;
    function FormatTally(S: String): String;
    procedure FreeMemberControls;
    function GetTagFromControl(Sender: TObject): Integer;
    procedure HelpAbout1Execute(Sender: TObject);
    procedure IgnorePhoto(Sender: TObject);
    procedure IgnPhotoMenuClick(Sender: TObject);
    procedure ImportMembers(Sender: TObject);
    procedure ImportOnlineComp(Sender: TObject);
    procedure ImportPhotos(Sender: TObject);
    procedure InsPhotoMenuClick(Sender: TObject);
    function LoadInMembers(var F: TFileStream): Boolean;
    procedure LoadSeason(filename: String);
    procedure MarkEmptyPhotos(cat,y: Integer);
    procedure MaxPhotoIDExit(Sender: TObject);
    procedure NewSeasonClick(Sender: TObject);
    procedure OpenCompetition(Sender: TObject);
    procedure OpenSeasonClick(Sender: TObject);
    procedure OutputResults(output,results: Integer);
    procedure PageHasChanged(Sender: TObject);
    procedure PageIsChanging(Sender: TObject; var AllowChange: Boolean);
    function PhotosPerCat(comp,cat: Integer): Integer;
    procedure pic_judgeClick(Sender: TObject);
    procedure PopulateComboBox(var cb: TComboBox;list: array of String);
    procedure print_btnClick(Sender: TObject);
    procedure PrintFooter;
    procedure PrintHeader(title: String;cat: Integer);
    procedure PrintLine(S,lfont: String;size,x: Integer;style: TFontStyles);
    procedure RecalculateResults(comp: Integer);
    procedure RePopulateMembers;
    procedure SaveSeasonFile;
    procedure sb_closecompClick(Sender: TObject);
    procedure sb_CloseSeasonClick(Sender: TObject);
    procedure season_titleExit(Sender: TObject);
    procedure settings_btnClick(Sender: TObject);
    procedure SetUpMembersList;
    procedure ShowTally(Sender: TObject);
    procedure SortCompetitions(opening: Boolean);
    procedure SortMembers(opening: Boolean);
    procedure UpdatePhotoCount;
    procedure ValidateVSlips(num_vslips: Integer);
    function VSlipsPerComp(comp: Integer): Integer;
    procedure WebLinkBtnClick(Sender: TObject);
  private
    SeasonFile: TFileStream;
  public
    //Season details of currently loaded season
    season             : TSeason;
    //Array of category names
    categories,
    //Array of concatenated members names (i.e. forename+surname)
    MembersList        : array of String;
    //Array for competition details for currently loaded season
    competitions       : TCompetitionArray;//array of TCompetitions;
    //Array for photograph details for currently loaded season
    photographs        : array of TPhotographs;
    //How the photographs are scored monthly
    m_scoring,
    //How the photographs are scored annually
    a_scoring          : array of Integer;
    //Array of members, full details, of currently loaded season
    members            : TMembersArray;
    //Array of voting slips of currently loaded season
    v_slips            : array of TVoting;
    //Panel array for voting slip IDs
    panl_vslip,
    //Panel array for splitters between categories on voting slip page
    panl_splitter      : array of TPanel;
    //Panel array for photograph IDs
    panl_ID            : array of array of TPanel;
    //Editbox arrays for member's details (surname,forename and photo count)
    edit_surname,
    edit_forename,
    edit_photocount,
    //Editbox array for maximum photo ID on voting slip page
    edit_maxphotoID    : array of TEdit;
    //Editbox arrays for photograph details (title, score, voting, and position)
    edit_title,
    edit_score,
    edit_voting,
    edit_place         : array of array of TEdit;
    //Editbox array for voting slip entries
    edit_vslip         : array of array of array of TEdit;
    //Combobox array for author field on photograph details
    cbox_author        : array of array of TComboBox;
    //Picture array for graphical voting display
    vote_graph         : array of TImage;
    //Array of Add buttons
    add_btn,
    //Array of Open competiton buttons
    open_btn,
    //Array of Delete competition buttons
    delcomp_btn,
    //Array of Delete member buttons
    SB_deletemember,
    //Array of Delete voting slip buttons
    delvotslip_btn     : array of TSpeedButton;
    //Array of judging type images, used on the competition pane
    judge_img          : array of TImage;
    //Scroll box used on the voting slip page
    sb_vslip           : TScrollBox;
    const
     //Column Left positions and widths for competition layouts
     ColumnPos: array[1..6] of Integer = ( 0, 20,220,420,460,540);
     ColumnWid: array[1..6] of Integer = (20,200,200, 40, 80, 40);
     //Max length of photograph IDs
     photo_maxlength                   = 2;
     //Width of each character in pixels
     widthperchar                      = 12;
     //Height of all the controls
     controlheight                     = 22;
     //Version of file - this is different to application version
     filever                           = '0.05';
     //What to put when no photo title is entered
     blank_title                       = 'No Title Entered';
     //Hints for deleting/undeleting voting slips
     delvs_hint                        = 'Delete Voting Slip';
     undelvs_hint                      = 'Undelete Voting Slip';
     //Hints for opening/creating competition
     opencomp_hint                     = 'Open Competition';
     createcomp_hint                   = 'Create New Competition';
     //Hints for internal/external judging
     int_judge_hint                    = 'Change to Internal Judging';
     ext_judge_hint                    = 'Change to External Judging';
     //Printer Margins (pixels), before adding the above
     top_margin                        = 150;
     left_margin                       = 150;
     right_margin                      = 150;
     bottom_margin                     = 150;
  end;

var
  MainForm: TMainForm;

{NOTES

To Do:
* Annual Competition
* Option to tabulate results on printer
* Option to choose whether results are total or average
  + In order to do this, we will need to record the number of photographs
    entered per member per category. Currently, we only record the total number
    of photographs per member across all competitions, and the POY tally will
    only produce entries that have been placed in the top 20, or scored points
    in the monthly.

BUGS:
}

implementation

{$R *.lfm}

uses AboutUnit,VotingUnit,SeasonDetailUnit,ResultsUnit,ImportUnit,
  SettingsUnit,DetailSelectionUnit, ImportOnlineUnit;

{-------------------------------------------------------------------------------
Month control has changed
-------------------------------------------------------------------------------}
procedure TMainForm.comp_dateChange(Sender: TObject);
begin
 //If it is not 'Annual'
 if comp_date.ItemIndex<12 then
 begin
  season_titleExit(Sender);
  SortCompetitions(False);
 end
 else
 begin
  //Otherwise revert
  comp_date.ItemIndex:=comp_date.Tag;
 end;
 //This will prevent a user from making a competition 'Annual' or changing an
 //'Annual' competition to a monthly
end;

{-------------------------------------------------------------------------------
Month control has gained focus
-------------------------------------------------------------------------------}
procedure TMainForm.comp_dateEnter(Sender: TObject);
begin
 //Remember the previous setting
 comp_date.Tag:=comp_date.ItemIndex;
end;

{-------------------------------------------------------------------------------
Edit control has become active
-------------------------------------------------------------------------------}
procedure TMainForm.comp_titleEnter(Sender: TObject);
var
 edit: TEdit;
begin
 if Sender is TEdit then
 begin
  edit:=Sender as TEdit;
  edit.SelectAll;
 end;
end;

{-------------------------------------------------------------------------------
User is changing the competition title
-------------------------------------------------------------------------------}
procedure TMainForm.comp_titleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if comp_title.Tag>=0 then
  open_btn[comp_title.Tag].Caption:=comp_title.Text;
end;

{-------------------------------------------------------------------------------
About has been clicked
-------------------------------------------------------------------------------}
procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
 AboutForm.Version.Caption:='Version '+AppVersion+' ('+AppDate+')';
 AboutForm.ShowModal;
end;

{-------------------------------------------------------------------------------
Import members
-------------------------------------------------------------------------------}
procedure TMainForm.ImportMembers(Sender: TObject);
var
 F        : TFileStream;
 forename,
 surname  : String;
 i,X,c,
 FNCol,
 SNCol    : Integer;
const
 DDList   : array[1..2] of String=('Forename','Surname');
begin
 if member_open.Execute then
 begin
  //if it is a CSV
  if extractExtension(member_open.FileName)='.csv' then
  begin
   //Load the file in
   X:=ImportForm.LoadCSV(member_open.FileName,DDList);
   if X>=2 then
   begin
    for i:=0 to ImportForm.sg_Columns.ColCount-1 do
    begin
     if i<2 then c:=2-i else c:=0;
     ImportForm.sg_Columns.Cells[i,0]:=ImportForm.cb_ColContents.Items[c];
     ImportForm.sg_Columns.ColWidths[i]:=128;
    end;
    //Show the import form, if more than 1 column
    ImportForm.ShowModal;
    //If user clicked OK, and both forname and surname are selected
    if  (ImportForm.ModalResult=mrOK)
    and (ImportForm.counter=3) then
    begin
     FNCol:=-1;
     SNCol:=-1;
     for i:=0 to ImportForm.sg_Columns.ColCount-1 do
      case ImportForm.cb_ColContents.Items.IndexOf(ImportForm.sg_Columns.Cells[i,0]) of
       1: FNCol:=i;
       2: SNCol:=i;
      end;
     for i:=1 to ImportForm.sg_Columns.RowCount-1 do
     begin
      forename:=ImportForm.sg_Columns.Cells[FNCol,i];
      surname:=ImportForm.sg_Columns.Cells[SNCol,i];
      //Add to the list, if not already in
      if CheckForDuplicates(forename,surname) then
      begin
       //Make space for new member
       SetLength(members,Length(members)+1);
       SetLength(MembersList,Length(MembersList)+1);
       SetLength(members[Length(members)-1].Score,season.Num_categories);
       SetLength(members[Length(members)-1].Tally,season.Num_categories);
       //Populate the new entry
       members[Length(members)-1].Forename:=forename;
       members[Length(members)-1].Surname:=surname;
       MembersList[Length(MembersList)-1]:=forename+' '+surname;
       members[Length(members)-1].Num_photos:=0;
       //And add a control for it
       AddMemberControl(Length(members)-1);
      end;
     end;
    end;
   end;
  end;
  //if it is an ESCC
  if extractExtension(member_open.FileName)='.escc' then
  begin
   F:=TFileStream.Create(member_open.FileName,fmOpenRead or fmShareDenyNone);
   F.Position:=0;
   //Then load in the members - this will overwrite all existing ones
   LoadInMembers(F);
   //All the photographs will need to have their 'author' reset to zero
   for i:=0 to Length(photographs)-1 do
    photographs[i].Author:=0;
  end;
  //Loading done, close the file
  F.Free;
  //Sort them, update the fields and save
  SortMembers(False);
 end;
end;

{-------------------------------------------------------------------------------
Check for duplicate members
-------------------------------------------------------------------------------}
function TMainForm.CheckForDuplicates(f,s: String): Boolean;
var i: Integer;
begin
 Result:=true;
 for i:=1 to Length(members)-1 do
  if  (members[i].Forename=f)
  and (members[i].Surname =s) then
   Result:=false;
end;

{-------------------------------------------------------------------------------
Creating a new season
-------------------------------------------------------------------------------}
procedure TMainForm.NewSeasonClick(Sender: TObject);
var
 i: Integer;
begin
 //Set up form for new season
 SeasonDetailForm.existing:=False;
 //Change Title
 SeasonDetailForm.Caption:='Create New Season';
 //Open form
 SeasonDetailForm.ShowModal;
 //User clicked OK, then create season
 if SeasonDetailForm.ModalResult=mrOK then
  if escc_Save.Execute then
  begin
   //Close the current season
   CloseSeason;
   //Record the information from the form
   //--------Season Details--------
   season.Filename         :=escc_Save.FileName;
   season.Title            :=SeasonDetailForm.season_title.Text;
   season.Num_categories   :=SeasonDetailForm.ud_num_cats.Position;
   season.a_Places_to_score:=SeasonDetailForm.ud_a_num_score.Position;
   season.m_Places_to_score:=SeasonDetailForm.ud_m_num_score.Position;
   season.Num_competitions :=SeasonDetailForm.ud_num_comps.Position;
   season.Start_Month      :=SeasonDetailForm.cb_start_month.ItemIndex+1;
   season.IncEntries       :=SeasonDetailForm.ud_a_comp_entries.Position;
   season.ScoreEntries     :=SeasonDetailForm.ud_score_entries.Position;
   season.ScoreTotalm      :=SeasonDetailForm.rb_total_m.Checked;
   season.ScoreTotala      :=SeasonDetailForm.rb_total_a.Checked;
   season.SplitEqual       :=SeasonDetailForm.cb_splitequal.Checked;
   //--------Category Details--------
   SetLength(categories,season.Num_categories);
   for i:=0 to season.Num_categories-1 do
    categories[i]:=SeasonDetailForm.cats[i+1].Text;
   //--------Competition Details--------
   SetLength(competitions,season.Num_competitions);
   for i:=0 to season.Num_competitions-1 do
   begin
    competitions[i].Month    :=SeasonDetailForm.comps_month[i+1].ItemIndex;
    competitions[i].Title    :=SeasonDetailForm.comps_title[i+1].Text;
    competitions[i].Ext_judge:=SeasonDetailForm.comps_ext[i+1].Checked;
    competitions[i].Deleted  :=false;
   end;
   //--------Scoring - annual--------
   SetLength(a_scoring,season.a_Places_to_score);
   for i:=0 to season.a_Places_to_score-1 do
    a_scoring[i]:=StrToIntDef(SeasonDetailForm.a_scoring_sco[i+1].Text,0);
   //--------Scoring - monthly--------
   SetLength(m_scoring,season.m_Places_to_score);
   for i:=0 to season.m_Places_to_score-1 do
    m_scoring[i]:=StrToIntDef(SeasonDetailForm.m_scoring_sco[i+1].Text,0);
   //--------Members List--------
   SetLength(members,1);
   SetLength(MembersList,1);
   SetUpMembersList;
   //Save it all to the file
   SaveSeasonFile;
   //Setup workarea
   EnableControls(ec_OpenSeason);
   //This is deliberately one more than needed, as the extra one is for adding
   // a new competition
   for i:=0 to season.Num_competitions do AddNewCompControl;
   PopulateComboBox(comp_date,MonthList);
  end;
end;

{-------------------------------------------------------------------------------
Save the season data to a file
-------------------------------------------------------------------------------}
procedure TMainForm.SaveSeasonFile;
var
 i,j: Integer;
begin
 if(SeasonFile=nil)and(season.Filename<>'')then
 begin
  //First create the file
  SeasonFile:=TFileStream.Create(season.Filename,fmCreate);
  //And close it
  SeasonFile.Free;
  //Now reopen but as Read and Write access
  SeasonFile:=TFileStream.Create(season.Filename,fmOpenReadWrite or fmShareDenyWrite);
 end;
 if SeasonFile<>nil then
 begin
  SeasonFile.Position:=0;
  //Write the file version
  WriteLine(SeasonFile,filever);
  //Write the header
  WriteLine(SeasonFile,'------------------------------------------------------------------');
  WriteLine(SeasonFile,'ESCC Competitions ©Gerald J Holdsworth/East Sutherland Camera Club');
  WriteLine(SeasonFile,'Written by Gerald J Holdsworth. Graphics by Andy Kirby');
  WriteLine(SeasonFile,'Version '+AppVersion+' ('+AppDate+')');
  WriteLine(SeasonFile,'------------------------------------------------------------------');
  WriteLine(SeasonFile,'');
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Season Details========');
  WriteLine(SeasonFile,season.Title);
  WriteLine(SeasonFile,IntToStr(season.Num_categories));
  WriteLine(SeasonFile,IntToStr(season.a_Places_to_score));
  WriteLine(SeasonFile,IntToStr(season.m_Places_to_score));
  WriteLine(SeasonFile,IntToStr(season.Num_competitions));
  WriteLine(SeasonFile,IntToStr(season.Start_Month));
  WriteLine(SeasonFile,IntToStr(season.IncEntries));
  WriteLine(SeasonFile,IntToStr(season.ScoreEntries));
  WriteLine(SeasonFile,IntToStr(season.MaxEntries));
  WriteLine(SeasonFile,BoolToStr(season.SplitEqual));
  WriteLine(SeasonFile,BoolToStr(season.ScoreTotalm));
  WriteLine(SeasonFile,BoolToStr(season.ScoreTotala));
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Category Details========');
  for i:=0 to season.Num_categories-1 do
   WriteLine(SeasonFile,categories[i]);
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Competition Details========');
  for i:=0 to season.Num_competitions-1 do
  begin
   WriteLine(SeasonFile,IntToStr(competitions[i].Month));
   WriteLine(SeasonFile,competitions[i].Title);
   WriteLine(SeasonFile,BoolToStr(competitions[i].Ext_judge));
   WriteLine(SeasonFile,BoolToStr(competitions[i].Deleted));
  end;
  //---------------------------------------------------------------------------
   WriteLine(SeasonFile,'========Scoring - annual========');
  for i:=0 to season.a_Places_to_score-1 do
   WriteLine(SeasonFile,IntToStr(a_scoring[i]));
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Scoring - monthly========');
  for i:=0 to season.m_Places_to_score-1 do
   WriteLine(SeasonFile,IntToStr(m_scoring[i]));
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Voting Slips========');
  //Work out total number of voting slips, skipping those that have been deleted
  j:=0;
  for i:=0 to Length(v_slips)-1 do
   if v_slips[i].Used then
    //and make sure that both the competition and category fields are valid
    if  (v_slips[i].Competition>=0)
    and (v_slips[i].Category>=0) then
     inc(j);
  //Total number of voting slips
  WriteLine(SeasonFile,IntToStr(j));
  //Now write the slips to the file, again skipping those that have been deleted
  for i:=0 to Length(v_slips)-1 do
   if v_slips[i].Used then
   //and those with invalid competition and category fields
    if  (v_slips[i].Competition>=0)
    and (v_slips[i].Category>=0) then
    begin
     WriteLine(SeasonFile,IntToStr(v_slips[i].Competition));
     WriteLine(SeasonFile,IntToStr(v_slips[i].Category));
     for j:=0 to season.m_places_to_score-1 do
      WriteLine(SeasonFile,v_slips[i].Places[j]);
    end;
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Photographs========');
  //Work out total number of photographs: -1 in competition and category denotes
  //a deleted photograph, and should be skipped
  j:=0;
  for i:=0 to Length(photographs)-1 do
   if (photographs[i].Competition>=0) and (photographs[i].Category>=0) then inc(j);
  WriteLine(SeasonFile,IntToStr(j)); {Total number of photographs}
  for i:=0 to Length(photographs)-1 do
   if (photographs[i].Competition>=0) and (photographs[i].Category>=0) then
   begin
    WriteLine(SeasonFile,IntToStr(photographs[i].Competition));
    WriteLine(SeasonFile,IntToStr(photographs[i].Category));
    WriteLine(SeasonFile,IntToStr(photographs[i].Author-1));
    WriteLine(SeasonFile,photographs[i].Title);
    WriteLine(SeasonFile,photographs[i].ID);
    WriteLine(SeasonFile,photographs[i].Voting);
    WriteLine(SeasonFile,IntToStr(photographs[i].Score));
    WriteLine(SeasonFile,photographs[i].Position);
    WriteLine(SeasonFile,BoolToStr(photographs[i].Ignore));
   end;
  //---------------------------------------------------------------------------
  WriteLine(SeasonFile,'========Members========');
  WriteLine(SeasonFile,IntToStr(Length(members)-1)); //Total number of members
  for i:=1 to Length(members)-1 do
  begin
   WriteLine(SeasonFile,members[i].Forename);
   WriteLine(SeasonFile,members[i].Surname);
   for j:=0 to season.Num_categories-1 do
    WriteLine(SeasonFile,IntToStr(members[i].Score[j]));
  end;
  //---------------------------------------------------------------------------
  //Set the length (as it may be shorter than before
  SeasonFile.Size:=SeasonFile.Position;
//  F.Free;
 end;
end;

{-------------------------------------------------------------------------------
Edit Season Details
-------------------------------------------------------------------------------}
procedure TMainForm.EditSeason(Sender: TObject);
var
 confirm,c,i,j: Integer;
begin
 SeasonDetailForm.existing:=True;
 SeasonDetailForm.Caption:='Edit Season';
 SeasonDetailForm.ShowModal;
 //OK has been clicked, so update the settings
 if SeasonDetailForm.ModalResult=mrOK then
 begin
  //Close the current competition
  CloseCompetition;
  //Reduction in competitions : ask if the user is sure about deleting competitions
  If SeasonDetailForm.ud_num_comps.Position<season.Num_competitions then
  begin
   confirm:=MessageDlg('You have reduced the number of competitions.'+
                       'This will result in the later competitions being deleted,'+
                       ' and earlier ones being renamed, if necessary.'+#13#10+
                       'Are you sure you wish to continue?',
                       mtConfirmation,[mbYes,mbNo],0,mbNo);
   if confirm=mrYes then
   begin
    for c:=season.Num_competitions downto SeasonDetailForm.ud_num_comps.Position+1 do
    begin
     //Delete the photographs first
     DeleteCompetitionPhotographs(c-1);
     //Then the competition
     DeleteCompetition(c-1);
    end;
    //Update the competition parameter
    season.Num_competitions:=SeasonDetailForm.ud_num_comps.Position;
   end;
  end;
  //Update the competition names, and judging types
  for i:=0 to Length(open_btn)-2 do
  begin
   open_btn[i].Caption:=SeasonDetailForm.comps_title[i+1].Text;
   competitions[i].Title:=open_btn[i].Caption;
   ChangeJudgeType(SeasonDetailForm.comps_ext[i+1].Checked,judge_img[i]);
   competitions[i].Ext_judge:=SeasonDetailForm.comps_ext[i+1].Checked;
   competitions[i].Month:=SeasonDetailForm.comps_month[i+1].ItemIndex;
  end;
  //Increase in competitions, just add them (new names get changed anyway)
  if SeasonDetailForm.ud_num_comps.Position>season.Num_competitions then
   repeat
    //This function updates season.Num_competitions parameter
    AddNewCompetition(SeasonDetailForm.comps_title[season.Num_competitions+1].Text,
                      SeasonDetailForm.comps_month[season.Num_competitions+1].ItemIndex,
                      SeasonDetailForm.comps_ext[season.Num_competitions+1].Checked);
   until SeasonDetailForm.ud_num_comps.Position=season.Num_competitions;
  //Reduction in categories : ask if the user is sure about deleting categories
  if SeasonDetailForm.ud_num_cats.Position<season.Num_categories then
  begin
   confirm:=MessageDlg('You have reduced the number of categories.'+
                       'This will result in data being deleted.'+
                       ' Later categories will be removed, and earlier ones will'+
                       ' be renamed, if necessary.'+
                       ' Voting slips will be amended as required.'+#13#10+
                       'Are you sure you wish to continue?',
                       mtConfirmation,[mbYes,mbNo],0,mbNo);
   if confirm=mrYes then
   begin
    for c:=season.Num_categories downto SeasonDetailForm.ud_num_cats.Position do
    begin
     //Iterate through the voting slips, removing the extra categories
     for i:=0 to Length(v_slips)-1 do
      if v_slips[i].Category=c then
      begin
       v_slips[i].Competition:=-1;
       v_slips[i].Category:=-1;
       v_slips[i].Used:=false;
      end;
     //Iterate through the photographs, removing the extra categories
     for i:=0 to Length(photographs)-1 do
      if photographs[i].Category=c then
      begin
       photographs[i].Competition:=-1;
       photographs[i].Category:=-1;
      end;
    end;
    //Update the category parameter
    season.Num_categories:=SeasonDetailForm.ud_num_cats.Position;
   end;
  end;
  //Increase in categories
  if SeasonDetailForm.ud_num_cats.Position>season.Num_categories then
  begin
   //Take a note of the number of slips, as this will change
   c:=Length(v_slips)-1;
   repeat
    //Interate through the voting slips.
    for i:=0 to c do
     //If the category is 0, and the slip hasn't been deleted
     if  (v_slips[i].Category=0)
     and (v_slips[i].Used) then
      begin
       //Then we'll add a new one at the end, to match this one
       SetLength(v_slips,Length(v_slips)+1);
       v_slips[Length(v_slips)-1].Competition:=v_slips[i].Competition;
       v_slips[Length(v_slips)-1].Category:=season.Num_categories;
       v_slips[Length(v_slips)-1].Used:=True;
       //This value may change later on - we'll worry about that then
       SetLength(v_slips[Length(v_slips)-1].Places,season.m_Places_to_score);
       //Blank off the entries, as it could be random data
       for j:=0 to season.m_Places_to_score-1 do
        v_slips[Length(v_slips)-1].Places[j]:='';
      end;
    //Increase the number of categories
    inc(season.Num_categories);
    //until it matches what has been set
   until season.Num_categories=SeasonDetailForm.ud_num_cats.Position;
  end;
  //Increase/decrease the category name array
  SetLength(categories,season.Num_categories);
  //Update the category names
  for c:=0 to Length(categories)-1 do
   categories[c]:=SeasonDetailForm.cats[c+1].Text;
  //Update all the other necessary parameters
  season.Title       :=SeasonDetailForm.season_title.Text;//Season Title
  season_title.Text  :=season.Title;//Update the title on the form
  season.Start_Month :=SeasonDetailForm.cb_start_month.ItemIndex+1;
  season.IncEntries  :=SeasonDetailForm.ud_a_comp_entries.Position;
  season.ScoreEntries:=SeasonDetailForm.ud_score_entries.Position;
  season.ScoreTotalm :=SeasonDetailForm.rb_total_m.Checked;
  season.ScoreTotala :=SeasonDetailForm.rb_total_a.Checked;
  season.SplitEqual  :=SeasonDetailForm.cb_splitequal.Checked;
  //Annual Scoring
  SetLength(a_scoring,SeasonDetailForm.ud_a_num_score.Position);
  for i:=1 to SeasonDetailForm.ud_a_num_score.Position do
   a_scoring[i-1]:=StrToIntDef(SeasonDetailForm.a_scoring_sco[i].Text,0);
  season.a_Places_to_score:=SeasonDetailForm.ud_a_num_score.Position;
  //Reduction in monthly scoring places
  if SeasonDetailForm.ud_m_num_score.Position<season.m_Places_to_score then
   confirm:=MessageDlg('You have reduced the number of monthly places to score.'+
                       'This will result in data being deleted from the voting'+
                       ' slips.'+#13#10+
                       'Are you sure you wish to continue?',
                       mtConfirmation,[mbYes,mbNo],0,mbNo)
  else confirm:=mrYes;
  if confirm=mrYes then
  begin
   //User is OK, or user confirmation not required (increase)
   SetLength(m_scoring,SeasonDetailForm.ud_m_num_score.Position);
   for i:=1 to SeasonDetailForm.ud_m_num_score.Position do
    m_scoring[i-1]:=StrToIntDef(SeasonDetailForm.m_scoring_sco[i].Text,0);
   //Set the parameter
   season.m_Places_to_score:=SeasonDetailForm.ud_m_num_score.Position;
   //Iterate through the voting slips and set the places lengths
   for i:=0 to Length(v_slips)-1 do
    SetLength(v_slips[i].Places,season.m_Places_to_score);
  end;
  //Call RecalulateResults for all competitions
  for i:=0 to Length(competitions)-1 do
   RecalculateResults(i);
  //Sort the competitions into order
  SortCompetitions(False);
 end;
end;

{-------------------------------------------------------------------------------
Close currently open competition
-------------------------------------------------------------------------------}
procedure TMainForm.sb_closecompClick(Sender: TObject);
begin
 CloseCompetition;
end;

{-------------------------------------------------------------------------------
Close currently open season
-------------------------------------------------------------------------------}
procedure TMainForm.sb_CloseSeasonClick(Sender: TObject);
begin
 CloseSeason;
end;

{-------------------------------------------------------------------------------
This gathers all information in all the competition controls
-------------------------------------------------------------------------------}
procedure TMainForm.season_titleExit(Sender: TObject);
var
 K: Char;
begin
 K:=#10;
 EditorKeyPress(Sender,K);
end;

{-------------------------------------------------------------------------------
Settings button clicked
-------------------------------------------------------------------------------}
procedure TMainForm.settings_btnClick(Sender: TObject);
begin
 SettingsForm.ShowModal;
end;

{-------------------------------------------------------------------------------
Exits max photo ID
-------------------------------------------------------------------------------}
procedure TMainForm.MaxPhotoIDExit(Sender: TObject);
var
 e: TEdit;
 i: Integer;
begin
 if Sender is TEdit then
 begin
  e:=Sender as TEdit;
  for i:=0 to Length(photographs)-1 do
   if  (photographs[i].Competition=comp_title.Tag)
   and (photographs[i].Category=e.Tag) then
    if ConvertFromID(photographs[i].ID)>ConvertFromID(e.Text) then
     e.Text:=photographs[i].ID;
 end;
end;

{-------------------------------------------------------------------------------
ENTER pressed in EditBox
-------------------------------------------------------------------------------}
procedure TMainForm.EditorKeyPress(Sender: TObject; var Key: Char);
var
 cat,comp,p: Integer;
const
 bannedchars: array[1..2] of Char = ('"','=');
begin
 for p:=Low(bannedchars) to High(bannedchars) do
  if Key=bannedchars[p] then Key:=#0;
 if (Key=#13) or (Key=#10) then
 begin
  //Get all information from all the controls
  comp:=comp_title.Tag;
  season.Title:=season_title.Text;
  if comp>=0 then
  begin
   //Competition Details
   competitions[comp].Title:=comp_title.Text;
   competitions[comp].Month:=comp_date.ItemIndex;
   //Photograph Details
   for cat:=0 to Length(panl_ID)-1 do
    for p:=0 to Length(panl_ID[cat])-1 do
    begin
     photographs[panl_ID[cat,p].Tag].ID:=panl_ID[cat,p].Caption;
     photographs[panl_ID[cat,p].Tag].Title:=edit_title[cat,p].Text;
     photographs[panl_ID[cat,p].Tag].Author:=cbox_author[cat,p].ItemIndex;
     photographs[panl_ID[cat,p].Tag].Score:=StrToIntDef(edit_score[cat,p].Text,0);
     photographs[panl_ID[cat,p].Tag].Voting:=edit_voting[cat,p].Text;
     photographs[panl_ID[cat,p].Tag].Position:=edit_place[cat,p].Text;
     MarkEmptyPhotos(cat,p+1);
    end;
   //voting slips
   if not competitions[comp].Ext_judge then
   begin
    ValidateVSlips(VSlipsPerComp(comp));
   //edit_vslip[Voting Slip,Category,Place]
    for cat:=0 to Length(edit_vslip)-1 do
     for p:=0 to Length(edit_vslip[cat])-1 do
      for comp:=0 to Length(edit_vslip[cat,p])-1 do
       v_slips[edit_vslip[cat,p,comp].Tag].Places[comp]:=edit_vslip[cat,p,comp].Text;
   end;
  end;
  //Concatenate the members names into the MembersList
  for p:=0 to Length(edit_surname)-1 do
  begin
   members[edit_surname[p].Tag].Forename:=edit_forename[p].Text;
   members[edit_surname[p].Tag].Surname:=edit_surname[p].Text;
   MembersList[edit_surname[p].Tag]:=edit_forename[p].Text+' '+edit_surname[p].Text;
   members[edit_surname[p].Tag].Num_photos:=CountPhotographs(edit_surname[p].Tag);
   edit_photocount[p].Text:=IntToStr(members[edit_surname[p].Tag].Num_photos);
   if members[edit_surname[p].Tag].Num_photos>0 then
    SB_deletemember[p].Enabled:=false
   else
    SB_deletemember[p].Enabled:=true;
  end;
  RePopulateMembers;
  //We'll now cancel the ENTER button and move onto the next control
  if Key=#13 then
  begin
   //if it is the surname field of the last member, then we'll add a new member
   if Length(edit_surname)>0 then
    if ActiveControl=edit_surname[Length(edit_surname)-1] then
     AddNewMember;
   //Move onto the next control
   SelectNext(ActiveControl,True,True);
   //and cancel the ENTER
   Key:=#0;
  end;
  SaveSeasonFile;
 end;
end;

{-------------------------------------------------------------------------------
Empty all the season arrays, clears all the data, and deletes all controls
-------------------------------------------------------------------------------}
procedure TMainForm.CloseSeason;
var
 i: Integer;
begin
 //Save the season
 SaveSeasonFile;
 //Close out the file
 SeasonFile.Free;
 SeasonFile:=nil;
 //Close any open competition
 if comp_title.Tag>=0 then CloseCompetition;
 //Reset the season paramters
 season.Filename:='';
 season.Title:='';
 season.Num_categories:=0;
 season.a_Places_to_score:=0;
 season.m_Places_to_score:=0;
 season.Num_competitions:=0;
 //Reset the arrays to zero
 SetLength(categories,0);
 SetLength(competitions,0);
 SetLength(a_scoring,0);
 SetLength(m_scoring,0);
 SetLength(v_slips,0);
 SetLength(photographs,0);
 //Reset the season and competition controls
 season_title.Text:='Season';
 season_title.ReadOnly:=True;
 comp_title.Text:='Competition';
 comp_title.ReadOnly:=True;
 comp_title.Tag:=-1;
 comp_date.Items.Clear;
 //Delete controls
 CloseCompetition;
 if Length(open_btn)>0 then
 begin
  for i:=0 to Length(open_btn)-1 do
  begin
   open_btn[i].Free;
   judge_img[i].Free;
   delcomp_btn[i].Free;
  end;
  SetLength(open_btn,0);
  SetLength(judge_img,0);
  SetLength(delcomp_btn,0);
 end;
 //Remove the members
 SetLength(members,1);
 SetLength(MembersList,1);
 FreeMemberControls;
 //Disable all the controls
 EnableControls(ec_AllOff);
end;

{-------------------------------------------------------------------------------
Deletes controls and resets the arrays used by a competition
-------------------------------------------------------------------------------}
procedure TMainForm.CloseCompetition;
var
 i: Integer;
begin
 if comp_title.Tag>=0 then
 begin
  //Save the season
  SaveSeasonFile;
  //Reset the title
  comp_title.Text:='Competition';
  comp_title.ReadOnly:=true;
  comp_title.Tag:=-1;
  comp_date.ItemIndex:=-1;
  //Make the pane not visible
  cat_pages.Visible:=False;
  //Reset the arrays to zero
  SetLength(panl_ID,        0,0);
  SetLength(edit_title,     0,0);
  SetLength(cbox_author,    0,0);
  SetLength(edit_score,     0,0);
  SetLength(edit_voting,    0,0);
  SetLength(edit_place,     0,0);
  SetLength(edit_vslip,     0,0,0);
  SetLength(panl_splitter , 0);
  SetLength(add_btn,        0);
  SetLength(edit_maxphotoID,0);
  //Delete the pages one by one
  if cat_pages.PageCount>0 then
   for i:=0 to cat_pages.PageCount-1 do
    //We used the reference of 0 here because as each page is deleted, they each
    //become reference number 0
    cat_pages.Pages[0].Free;
  //Disable the controls
  EnableControls(ec_OpenSeason);
  //Delete the voting graph
  for i:=0 to season.Num_categories-1 do
   vote_graph[i].Free;
  SetLength(vote_graph,0);
  //And make the master disappear
  sb_vote_graph.Visible:=False;
  vote_graph_master.Picture:=nil;
 end;
end;

{-------------------------------------------------------------------------------
Opening an existing season
-------------------------------------------------------------------------------}
procedure TMainForm.OpenSeasonClick(Sender: TObject);
begin
 if escc_open.Execute then LoadSeason(escc_open.FileName);
end;

{-------------------------------------------------------------------------------
Load an existing season
-------------------------------------------------------------------------------}
procedure TMainForm.LoadSeason(filename: String);
var
 i,j        : Integer;
 S          : String;
 FileVersion: Real;
 LoadSuccess: Boolean;
begin
 //Close the current season
 if SeasonFile<>nil then CloseSeason;
 //Flag to whether the load was successful
 LoadSuccess:=True;
 //Open the file
 SeasonFile:=TFileStream.Create(filename,fmOpenReadWrite or fmShareDenyWrite);
 SeasonFile.Position:=0;
 //Read version information
 ReadLine(SeasonFile,S);
 //Remove any spurious characters at the front
 if (Ord(S[1])<48) or (Ord(S[1])>57) then
  repeat
   S:=Copy(S,2,Length(S)-1);
  until ((Ord(S[1])>47) and (ord(S[1])<58)) or (Length(S)=1);
 //Convert to floating point
 FileVersion:=StrToFloatDef(S,0.00);
 if FileVersion>=0.02 then //minimum version allowed
 begin
  //Start setting up the array
  season.Filename:=filename;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Season Details========') then
  begin //Load Season Details (versions >=0.02)
   ReadLine(SeasonFile,season.Title); //Season Title
   ReadLine(SeasonFile,S);            //Number of Categories
   season.Num_categories   :=StrToIntDef(S,def_num_categories);
   ReadLine(SeasonFile,S);            //POY Number of Places to Score
   season.a_Places_to_score:=StrToIntDef(S,def_a_places_to_score);
   ReadLine(SeasonFile,S);            //Monthly Number of Places to Score
   season.m_Places_to_score:=StrToIntDef(S,def_m_places_to_score);
   ReadLine(SeasonFile,S);            //Number of competitions in the season
   season.Num_competitions :=StrToIntDef(S,def_num_categories);
   if FileVersion=0.02 then
   begin //Default values if version 0.02
    season.Start_Month     :=def_start_month;
    season.IncEntries      :=def_inc_entries;
    season.ScoreTotalm     :=def_scoretotalm;
    season.ScoreTotala     :=def_scoretotala;
   end;
   if FileVersion<0.05 then
   begin //Default values for versions 0.02-0.04
    season.ScoreEntries    :=def_score_entries;
    season.MaxEntries      :=def_maxentries;
    season.SplitEqual      :=def_splitequal;
   end;
   if FileVersion>0.02 then
   begin //Values for versions >0.02
    ReadLine(SeasonFile,S);           //Start Month
    season.Start_Month     :=StrToIntDef(S,def_start_month);
    ReadLine(SeasonFile,S);           //Entries to include in POY
    season.IncEntries      :=StrToIntDef(S,def_inc_entries);
    if FileVersion>0.04 then
    begin //Values for versions >0.04
     ReadLine(SeasonFile,S);          //Number of entries, per member, to include in POY
     season.ScoreEntries   :=StrToIntDef(S,def_score_entries);
     ReadLine(SeasonFile,S);          //Max number of entries, per member, per category
     season.MaxEntries     :=StrToIntDef(S,def_maxentries);
     ReadLine(SeasonFile,S);          //Split the equal places or not
     season.SplitEqual     :=S='TRUE';
    end;
    ReadLine(SeasonFile,S);           //Total or Average scores (monthly)
    season.ScoreTotalm     :=S='TRUE';
    ReadLine(SeasonFile,S);           //Total or Average scores (POY)
    season.ScoreTotala     :=S='TRUE';
   end;
  end
  else LoadSuccess         :=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Category Details========') then
  begin //Category Details (all versions)
   SetLength(categories,season.Num_categories);
   for i:=0 to season.Num_categories-1 do
    ReadLine(SeasonFile,categories[i]);//Category titles
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Competition Details========') then
  begin //Competition details (all versions)
   SetLength(competitions,season.Num_competitions);
   for i:=0 to season.Num_competitions-1 do
   begin
    ReadLine(SeasonFile,S);           //Month of competition
    competitions[i].Month:=StrToIntDef(S,0);
    ReadLine(SeasonFile,competitions[i].Title);//Competition title
    ReadLine(SeasonFile,S);           //Externally judged?
    competitions[i].Ext_judge:=S='TRUE';
    ReadLine(SeasonFile,S);           //Deleted entry?
    competitions[i].Deleted:=S='TRUE';
   end;
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Scoring - annual========') then
  begin //POY Scoring (all versions)
   SetLength(a_scoring,season.a_Places_to_score);
   for i:=0 to season.a_Places_to_score-1 do
   begin
    ReadLine(SeasonFile,S);           //Scores towards POY
    a_scoring[i]:=StrToIntDef(S,0);
   end;
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Scoring - monthly========') then
  begin //Monthly scoring (all versions)
   SetLength(m_scoring,season.m_Places_to_score);
   for i:=0 to season.m_Places_to_score-1 do
   begin
    ReadLine(SeasonFile,S);           //Scores to use
    m_scoring[i]:=StrToIntDef(S,0);
   end;
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Voting Slips========') then
  begin //Voting slips (all versions)
   ReadLine(SeasonFile,S); //Total number of voting slips
   SetLength(v_slips,StrToIntDef(S,0));
   for i:=0 to Length(v_slips)-1 do
   begin
    ReadLine(SeasonFile,S);           //Competition number
    v_slips[i].Competition:=StrToIntDef(S,0);
    ReadLine(SeasonFile,S);           //Category number
    v_slips[i].Category:=StrToIntDef(S,0);
    v_slips[i].Used:=True;   //Deleted?
    SetLength(v_slips[i].Places,season.m_Places_to_score);
    for j:=0 to season.m_places_to_score-1 do
     ReadLine(SeasonFile,v_slips[i].Places[j]);//Places ranked
   end;
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if SeekLn(SeasonFile,'========Photographs========') then
  begin //Photograph details (all versions)
   ReadLine(SeasonFile,S);
   SetLength(photographs,StrToIntDef(S,0)); //Total number of photographs
   for i:=0 to Length(photographs)-1 do
   begin
    ReadLine(SeasonFile,S);           //Competition number
    photographs[i].Competition:=StrToIntDef(S,0);
    ReadLine(SeasonFile,S);           //Category number
    photographs[i].Category:=StrToIntDef(S,0);
    ReadLine(SeasonFile,S);           //Author number
    photographs[i].Author:=StrToIntDef(S,-1)+1;
    ReadLine(SeasonFile,photographs[i].Title); //Title
    ReadLine(SeasonFile,photographs[i].ID);    //ID given
    ReadLine(SeasonFile,photographs[i].Voting);//How was it voted
    ReadLine(SeasonFile,S);           //Calculated score
    photographs[i].Score:=StrToIntDef(S,0);
    ReadLine(SeasonFile,S);           //Calculated position
    photographs[i].Position:=S;
    if FileVersion<0.04 then
     photographs[i].Ignore:=False //Deleted flag, default for version <0.04
    else
    begin
     ReadLine(SeasonFile,S);          //Deleted flag for versions >=0.04
     photographs[i].Ignore:=S='TRUE';
    end;
   end;
  end
  else LoadSuccess:=False;
  //---------------------------------------------------------------------------
  if LoadSuccess then LoadSuccess:=LoadInMembers(SeasonFile);
  //---------------------------------------------------------------------------
  if LoadSuccess then
  begin
   EnableControls(ec_OpenSeason);
   //This is deliberately one more than needed, as the extra one is for adding
   // a new competition
   for i:=0 to season.Num_competitions do AddNewCompControl;
   //Sort the competitions into order (this is done after creating the controls
   //as we update the controls
   SortCompetitions(True);
   //Populate the month combo box in the main part of the form
   PopulateComboBox(comp_date,MonthList);
   //comp_date.Items.Delete(12);
   //and finally sort the members into order
   SortMembers(True);
  end
  else ShowMessage('File Load Failure');
 end
 else ShowMessage('File format is too old');
end;

{-------------------------------------------------------------------------------
Free the member controls and reset the arrays
-------------------------------------------------------------------------------}
procedure TMainForm.FreeMemberControls;
var
 i: Integer;
begin
 //free the controls
 for i:=0 to Length(edit_surname)-1 do
 begin
  edit_surname[i].Free;
  edit_forename[i].Free;
  edit_photocount[i].Free;
  SB_deletemember[i].Free;
 end;
 //and 'forget' about them
 SetLength(edit_surname,0);
 SetLength(edit_forename,0);
 SetLength(edit_photocount,0);
 SetLength(SB_deletemember,0);
 add_btn_src.Top:=0;
end;

{-------------------------------------------------------------------------------
Load in Members from an escc file (overwriting all others)
-------------------------------------------------------------------------------}
function TMainForm.LoadInMembers(var F: TFileStream): Boolean;
var
 i,J: Integer;
 S: String;
begin
 Result:=True;
 if SeekLn(F,'========Members========') then
 begin
  //This will overwrite all the other members, so clear the arrays
  SetLength(members,1);
  SetLength(MembersList,1);
  //free the controls
  FreeMemberControls;
  //Now read in from the file
  ReadLine(F,S);
  SetLength(members,StrToIntDef(S,0)+1); //Total number of members
  SetLength(MembersList,StrToIntDef(S,0)+1);
  //Setup the progress bar
  ProgressBar1.Max:=Length(members)-1;
  ProgressBar1.Position:=0;
  ProgressBar1.Update;
  //Blank the display
  SB_MembersList.Visible:=False;
  SetUpMembersList;
  for i:=1 to Length(members)-1 do
  begin
   ReadLine(F,members[i].Forename);
   ReadLine(F,members[i].Surname);
   SetLength(members[i].Score,season.Num_categories);
   SetLength(members[i].Tally,season.Num_categories);
   for j:=0 to season.Num_categories-1 do
   begin
    ReadLine(F,S);
    members[i].Score[j]:=StrToIntDef(S,0);
   end;
   AddMemberControl(i);
   ProgressBar1.Position:=i;
   ProgressBar1.Update;
  end;
  ProgressBar1.Position:=0;
  ProgressBar1.Update;
  SB_MembersList.Visible:=True;
 end
 else Result:=False;
end;

{-------------------------------------------------------------------------------
Add a new competition
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewCompetition(title: String;month: Integer;ext: Boolean);
begin
 AddNewCompControl;
 SetLength(competitions,Length(competitions)+1);
 inc(season.Num_competitions);
 competitions[Length(competitions)-1].Title:=title;
 competitions[Length(competitions)-1].Month:=month;
 competitions[Length(competitions)-1].Ext_judge:=ext;
 open_btn[Length(open_btn)-2].Caption:=title;
 open_btn[Length(open_btn)-2].Hint:=opencomp_hint;
 delcomp_btn[Length(delcomp_btn)-2].Enabled:=True;
 delcomp_btn[Length(delcomp_btn)-2].Visible:=True;
 judge_img[Length(judge_img)-2].Visible:=True;
 if ext then
 begin
  judge_img[Length(judge_img)-2].Picture:=no_ext_judge.Picture;
  judge_img[Length(judge_img)-2].Hint:=int_judge_hint;
 end;
 SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
User is opening a competition
-------------------------------------------------------------------------------}
procedure TMainForm.OpenCompetition(Sender: TObject);
var
 i,x,y: Integer;
 SB: TScrollBox;
 TS: TTabSheet;
 btn: TSpeedButton;
 maxID: array of String;
const
 ColumnHdr: array[1..7] of String=('ID',
                                   'Photograph Title',
                                   'Photograph Author',
                                   'Score',
                                   'Tally',
                                   'Place',
                                   'Judged Place');
begin
 if Sender is TSpeedButton then
 begin
  btn:=Sender as TSpeedButton;
  //First, destroy all existing pages
  CloseCompetition;
  //If the last item is clicked, then this is for a new competition
  if btn.Tag=Length(open_btn)-1 then
   AddNewCompetition(open_btn[btn.Tag].Caption,GetMonthNumber(btn.Tag)+1,False);
  //Change the competition title on the header
  comp_title.Text:=competitions[btn.Tag].Title;
  comp_title.ReadOnly:=False;
  comp_date.ItemIndex:=competitions[btn.Tag].Month;
  comp_date.Enabled:=True;
  //Used to update the competition list, if the title changes
  comp_title.Tag:=btn.Tag;
  //Set aside space for the 'add' buttons
  if competitions[btn.Tag].Ext_judge then
   SetLength(add_btn,season.Num_categories)
  else
   SetLength(add_btn,season.Num_categories+1);
  //Set aside space for the edit controls
  SetLength(panl_ID,    season.Num_categories);
  SetLength(edit_title, season.Num_categories);
  SetLength(cbox_author,season.Num_categories);
  SetLength(edit_score, season.Num_categories);
  SetLength(edit_voting,season.Num_categories);
  SetLength(edit_place, season.Num_categories);
  SetLength(maxID,      season.Num_categories);
  //And the graphical voting displays
  SetLength(vote_graph, season.Num_categories);
  for i:=0 to season.Num_categories-1 do
  begin
   vote_graph[i]:=TImage.Create(sb_vote_graph);
   vote_graph[i].Visible:=False;
  end;
  //Setup the progress bar
  i:=(season.Num_categories-1)*(Length(photographs)-1);
  if i<0 then i:=0;
  ProgressBar1.Max:=i;
  ProgressBar1.Position:=0;
  ProgressBar1.Update;
  //Create the pages, scroll boxes and headers
  for i:=0 to season.Num_categories-1 do
  begin
   TS:=CreatePage(cat_pages,categories[i]);
   SB:=CreateScrollBox(TS);
   //Setup the max photo ID
   maxID[i]:=' ';
   for x:=1 to 6 do
   begin
    if (competitions[btn.Tag].Ext_judge)
    and (x=5) then y:=7 else y:=x;
    CreatePanel(ColumnHdr[y],ColumnPos[x],0,ColumnWid[x],SB);
   end;
   x:=PhotosPerCat(btn.Tag,i);
   add_btn[i]:=CreateSpeedButton(controlheight+1+(x*controlheight),i,SB);
   //Now, we need to display any photograph details
   for y:=0 to Length(photographs)-1 do
   begin
    if  (photographs[y].Competition=btn.Tag)
    and (photographs[y].Category=i) then
    begin
     AddPhotoControl(btn.Tag,i,y);
     if ConvertFromID(photographs[y].ID)>ConvertFromID(maxID[i]) then
      maxID[i]:=photographs[y].ID;
    end;
    ProgressBar1.Position:=(i*(Length(photographs)-1))+y;
    ProgressBar1.Update;
   end;
  end;
  //Create a page for the Voting Slips
  if not competitions[btn.Tag].Ext_judge then
  begin
   TS:=CreatePage(cat_pages,'Voting Slips');
   sb_vslip:=CreateScrollBox(TS);
   SetLength(panl_splitter,season.Num_categories-1);
   SetLength(edit_maxphotoID,season.Num_categories);
   //Create splitters between categories
   for i:=1 to season.Num_categories-1 do
   begin
    panl_splitter[i-1]:=CreatePanel('',
                   18+((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*i),
                   0,4,sb_vslip);
    panl_splitter[i-1].ParentBackground:=False;
    panl_splitter[i-1].Color:=clRed;
    panl_splitter[i-1].Height:=controlheight*3;
   end;
   for i:=0 to season.Num_categories-1 do
   begin
    CreatePanel(categories[i],
                22+((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*i),
                0,
                season.m_Places_to_score*(photo_maxlength*widthperchar),sb_vslip);
    CreatePanel('Max',
                22+((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*i),
                controlheight,photo_maxlength*widthperchar,sb_vslip);
    edit_maxphotoID[i]:=CreateEdit(
             22+(photo_maxlength*widthperchar)+((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*i),
             controlheight,photo_maxlength*widthperchar*(season.m_Places_to_score-1),
             false,sb_vslip);
    if maxID[i]=' ' then maxID[i]:=FillString('Z',photo_maxlength);
    edit_maxphotoID[i].Text:=maxID[i];
    edit_maxphotoID[i].Alignment:=taCenter;
    edit_maxphotoID[i].OnChange:=@VotingForm.Pos_1_1Change;
    edit_maxphotoID[i].OnExit:=@MaxPhotoIDExit;
    edit_maxphotoID[i].MaxLength:=photo_maxlength;
    edit_maxphotoID[i].CharCase:=ecUpperCase;
    edit_maxphotoID[i].Tag:=i;
    for x:=0 to season.m_Places_To_score-1 do
     CreatePanel(IntToPos(x+1),
       22+((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*i)+(x*(photo_maxlength*widthperchar))
       ,controlheight*2,(photo_maxlength*widthperchar),sb_vslip);
   end;
   x:=VSlipsPerComp(btn.Tag);
   add_btn[season.Num_categories]:=CreateSpeedButton(
                 (3*controlheight)+((x div season.Num_categories)*controlheight),
                 season.Num_categories,sb_vslip);
   btn_votingslip.Enabled:=True;
   btn_delphotographs.Enabled:=True;
   //Display any voting slips
   for y:=0 to Length(v_slips)-1 do
    if  (v_slips[y].Competition=btn.Tag)
    and (v_slips[y].Category=0) then //Only checks for the first category
     AddVotingControl(btn.Tag,y);    //This procedure will load the rest
  end;
  //and finally save the data, as it may have been updated
  RecalculateResults(comp_title.Tag);
  //Then enable some of the controls
  EnableControls(ec_OpenComp);
  ProgressBar1.Position:=0;
  ProgressBar1.Update;
 end;
end;

{-------------------------------------------------------------------------------
Set up application
-------------------------------------------------------------------------------}
procedure TMainForm.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 //Set default values by reading them from the registry
 def_num_categories   :=GetRegValI('Num_categories',c_def_num_categories);
 SetLength(def_categories,def_num_categories+1);
 for i:=1 to def_num_categories do
  def_categories[i]   :=GetRegValS('Categories\'+IntToStr(i),c_def_categories[i]);
 def_a_places_to_score:=GetRegValI('A_places_to_score',c_def_a_places_to_score);
 SetLength(def_a_scores,def_a_places_to_score+1);
 for i:=1 to def_a_places_to_score do
  def_a_scores[i]     :=c_def_a_scores[i];
 GetRegValA('Annual Scores',def_a_scores);
 def_m_places_to_score:=GetRegValI('M_places_to_score',c_def_m_places_to_score);
 SetLength(def_m_scores,def_m_places_to_score+1);
 for i:=1 to def_m_places_to_score do
  def_m_scores[i]     :=c_def_m_scores[i];
 GetRegValA('Monthly Scores',def_m_scores);
 def_num_competitions :=GetRegValI('Num_competitions',c_def_num_competitions);
 def_start_month      :=GetRegValI('Start_Month',c_def_start_month);
 def_inc_entries      :=GetRegValI('Included_Entries',c_def_inc_entries);
 def_score_entries    :=GetRegValI('Scored_Entries',c_def_score_entries);
 def_maxentries       :=GetRegValI('Max_Entries',c_def_maxentries);
 def_scoretotalm      :=GetRegValB('Score_Total_Monthly',c_def_scoretotalm);
 def_scoretotala      :=GetRegValB('Score_Total_POY',c_def_scoretotala);
 def_splitequal       :=GetRegValB('SplitEquals',c_def_splitequal);
 SeasonFile:=nil;
end;

{-------------------------------------------------------------------------------
Dropped files handler
-------------------------------------------------------------------------------}
procedure TMainForm.FormDropFiles(Sender: TObject;
 const FileNames: array of String);
begin
 if extractExtension(FileNames[0])='.escc' then
  LoadSeason(FileNames[0]);
end;

{-------------------------------------------------------------------------------
Set up Main Form
-------------------------------------------------------------------------------}
procedure TMainForm.FormShow(Sender: TObject);
begin
 CompetitionPanel.Width:=804-190;
 SeasonPanel.Width:=264;
 sb_complist.Height:=13*ControlHeight;
 CloseSeason;
 EnableControls(ec_AllOff);
 SeasonPanel.SetFocus;
end;

{-------------------------------------------------------------------------------
Procedure to populate a combo box
-------------------------------------------------------------------------------}
procedure TMainForm.PopulateComboBox(var cb: TComboBox;list: array of String);
var
 i: Integer;
begin
 cb.Clear;
 for i:=Low(list) to High(list) do
  cb.Items.Add(list[i]);
end;

{-------------------------------------------------------------------------------
Close application
-------------------------------------------------------------------------------}
procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
 SaveSeasonFile;
 Close;
end;

{-------------------------------------------------------------------------------
Add New Photograph/Member button
-------------------------------------------------------------------------------}
procedure TMainForm.AddPhotoOrMember(Sender: TObject);
var
 btn: TSpeedButton;
begin
 if Sender is TSpeedButton then
 begin
  btn:=Sender as TSpeedButton;
  if btn.Tag<season.Num_categories then
   AddNewPhotograph(btn.Tag)
  else
   if btn.Tag<>9999 then AddNewVotingSlip(false)
   else AddNewMember;
 end;
end;

{-------------------------------------------------------------------------------
Delete Member button
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteMember(Sender: TObject);
var
 btn: TSpeedButton;
 confirm: Integer;
begin
 if Sender is TSpeedButton then
 begin
  btn:=Sender as TSpeedButton;
  confirm:=MessageDlg('Delete Member '+MembersList[btn.Tag]+'?',
                      mtConfirmation,[mbYes,mbNo],0,mbNo);
  if confirm=mrYes then
  begin
   members[btn.Tag].Num_photos:=-1;
   SortMembers(False);
  end;
 end;
end;

{-------------------------------------------------------------------------------
Delete Voting Slip button
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteVoteSlip(Sender: TObject);
var
 btn: TSpeedButton;
 cat,i: Integer;
begin
 if Sender is TSpeedButton then
 begin
  btn:=Sender as TSpeedButton;
  //Check to see if it is deleted
  if v_slips[panl_vslip[btn.Tag].Tag].Used then //Not deleted, so delete
  begin
   //Mark as deleted
   panl_vslip[btn.Tag].Color:=clRed;
   //Change the delete button
   btn.Glyph:=OKbtnsrc.Glyph;
   btn.Hint:=undelvs_hint;
   for cat:=0 to season.Num_categories-1 do
   begin
    //Set the used flag
    v_slips[panl_vslip[btn.Tag].Tag+cat].Used:=False;
    for i:=0 to season.m_Places_to_score-1 do
    begin
     //Mark the edit boxes, and make them read only
     edit_vslip[btn.Tag,cat,i].ReadOnly:=True;
     edit_vslip[btn.Tag,cat,i].Color:=clRed;
    end;
   end;
  end
  else //Is deleted, so undelete
  begin
   //Mark as not deleted
   panl_vslip[btn.Tag].Color:=clBtnFace;
   //Change the button
   btn.Glyph:=del_btn_src.Glyph;
   btn.Hint:=delvs_hint;
   for cat:=0 to season.Num_categories-1 do
   begin
    //Set the used flag
    v_slips[panl_vslip[btn.Tag].Tag+cat].Used:=True;
    for i:=0 to season.m_Places_to_score-1 do
    begin
     //Mark the edit boxes, and make them editable
     edit_vslip[btn.Tag,cat,i].ReadOnly:=False;
     edit_vslip[btn.Tag,cat,i].Color:=clWindow;
    end;
   end;
  end;
  //Amend the results
  RecalculateResults(comp_title.Tag);
 end;
end;

{-------------------------------------------------------------------------------
Delete a single photograph (menu selection)
-------------------------------------------------------------------------------}
procedure TMainForm.DelPhotoMenuClick(Sender: TObject);
var
 index,i,j,cat,R: Integer;
 ID: String;
begin
 {This works differently than deleting redundant photos - this one is to delete
 a single photograph, whether it has a score or not and whether it has an author
 or not, and shift those below it up. The bottom one will be marked as -1 in the
 competition and category fields to be ignored when saving.}
 index:=GetTagFromControl(((Sender as TMenuItem).GetParentMenu as TPopUpMenu).PopupComponent);
 if index>=0 then
 begin
  cat:=cat_pages.ActivePageIndex;
  //Find the control index
  i:=-1;
  repeat
   inc(i);
  until (panl_ID[cat,i].Tag=index) or (i=Length(panl_ID[cat])-1);
  if panl_ID[cat,i].Tag=index then
  begin
   //Confirm
   R:=MessageDlg(
      'Delete '+panl_ID[cat,i].Caption+': "'+edit_title[cat,i].Text+'"?'+#13#10+
      'WARNING: THIS CANNOT BE UNDONE',
      mtConfirmation,[mbYes,mbNo],0,mbNo);
   if R=mrYes then
   begin
    //Move all from index+1 up by one
    for j:=i+1 to Length(panl_ID[cat])-1 do
    begin
     ID:=photographs[panl_ID[cat,j-1].Tag].ID;
     photographs[panl_ID[cat,j-1].Tag]:=photographs[panl_ID[cat,j].Tag];
     photographs[panl_ID[cat,j-1].Tag].ID:=ID;
     //Update the control, and mark empty photos
     FillInPhotoControl(cat,j,panl_ID[cat,j-1].Tag);
     MarkEmptyPhotos(cat,j);
    end;
    i:=Length(panl_ID[cat])-1;
    DeletePhotograph(cat,i);
    //Recalculate and Save results
    RecalculateResults(comp_title.Tag);
    SaveSeasonFile;
   end;
  end;
 end;
end;

{-------------------------------------------------------------------------------
Delete a single photograph (including the control)
-------------------------------------------------------------------------------}
procedure TMainForm.DeletePhotograph(cat,i: Integer);
begin
 //Delete final photograph
 //Photographs get marked as -1 in the competition and category fields
 //They will be ignored when saving.
 photographs[panl_ID[cat,i].Tag].Competition:=-1;
 photographs[panl_ID[cat,i].Tag].Category:=-1;
 //Now we free up the controls and reduce the array lengths
 panl_ID[cat,i].Free;
 SetLength(panl_ID[cat],Length(panl_ID[cat])-1);
 edit_title[cat,i].Free;
 SetLength(edit_title[cat],Length(edit_title[cat])-1);
 cbox_author[cat,i].Free;
 SetLength(cbox_author[cat],Length(cbox_author[cat])-1);
 edit_score[cat,i].Free;
 SetLength(edit_score[cat],Length(edit_score[cat])-1);
 edit_voting[cat,i].Free;
 SetLength(edit_voting[cat],Length(edit_voting[cat])-1);
 edit_place[cat,i].Free;
 SetLength(edit_place[cat],Length(edit_place[cat])-1);
 //Move the add button back up
 add_btn[cat].Top:=(Length(panl_ID[cat])+1)*controlheight;
end;

{-------------------------------------------------------------------------------
Work out number of photographs for this category in this competition
-------------------------------------------------------------------------------}
function TMainForm.PhotosPerCat(comp,cat: Integer): Integer;
var
 c: Integer;
begin
 Result:=0;
 for c:=0 to Length(photographs)-1 do
  if  (photographs[c].Competition=comp)
  and (photographs[c].Category=cat) then inc(Result);
end;

{-------------------------------------------------------------------------------
Change the competition type
-------------------------------------------------------------------------------}
procedure TMainForm.pic_judgeClick(Sender: TObject);
var
 img: TImage;
 p,v,cat: Integer;
 data: Boolean;
begin
 if Sender is TImage then
 begin
  img:=Sender as TImage;
  //Won't change if competition is currently open
  if (comp_title.Tag<>img.Tag)
  and(img.Tag<season.Num_competitions) then
  begin
   //Is there any data associated with this competition?
   v:=VSlipsPerComp(img.Tag);
   if v>0 then data:=True else data:=False;
   //Not much point checking for photos if there are voting slips
   if not data then
   for cat:=0 to season.Num_categories-1 do
    begin
     p:=PhotosPerCat(img.Tag,cat);
     if p>0 then data:=True;
    end;
   cat:=mrYes;
   //If there is data, then ask
   if data then
    cat:=MessageDlg('There is data associated with this competition. '+
                    'Changing the judging method will delete this data.'+#13#10+
                    'Are you sure you wish to continue?'+#13#10+
                    '(some data is recoverable, in certain cases)',
                    mtConfirmation,[mbYes,mbNo],0,mbNo);
   //User is OK to change, or no data
   if cat=mrYes then
   begin
    //If there is data, delete it
    if data then
    begin
     //First we blank off the voting, score, position and tally fields
     for cat:=0 to Length(photographs)-1 do
      if photographs[cat].Competition=img.Tag then
      begin
       photographs[cat].Voting:='';
       photographs[cat].Score:=0;
       photographs[cat].Position:='';
       photographs[cat].Tally:='';
      end;
     //Now we delete any voting slips (if going from external judge, there
     //won't be any anyway)
     for cat:=0 to Length(v_slips)-1 do
      if v_slips[cat].Competition=img.Tag then
       v_slips[cat].Used:=not v_slips[cat].Used;
     //This actually just reverses what was marked before. If the competition is
     //changed back, the voting slips are restored.
    end;
    //Toggle the Ext_judge flag
    competitions[img.Tag].Ext_judge:=not competitions[img.Tag].Ext_judge;
    //And change the picture
    ChangeJudgeType(competitions[img.Tag].Ext_judge,img);
   end;
  end;
 end;
end;

{-------------------------------------------------------------------------------
Work out number of voting slips for this competition
-------------------------------------------------------------------------------}
function TMainForm.VSlipsPerComp(comp: Integer): Integer;
var
 c: Integer;
begin
 Result:=0;
 for c:=0 to Length(v_slips)-1 do
  if v_slips[c].Competition=comp then inc(Result);
end;

{-------------------------------------------------------------------------------
Add a new photograph control
-------------------------------------------------------------------------------}
procedure TMainForm.AddPhotoControl(comp,cat,x: Integer);
var
 y: Integer;
 SB: TScrollBox;
begin
 SB:=add_btn[cat].Parent as TScrollBox;
 //Make space for the controls
 SetLength(panl_ID[cat],    Length(panl_ID[cat])+1);
 SetLength(edit_title[cat], Length(edit_title[cat])+1);
 SetLength(cbox_author[cat],Length(cbox_author[cat])+1);
 SetLength(edit_score[cat], Length(edit_score[cat])+1);
 SetLength(edit_voting[cat],Length(edit_voting[cat])+1);
 SetLength(edit_place[cat], Length(edit_place[cat])+1);
 y:=Length(panl_ID[cat]);
 //Create the controls
 panl_ID[cat,y-1]     :=CreatePanel('',ColumnPos[1],y*controlheight,ColumnWid[1],SB);
 edit_title[cat,y-1]  :=CreateEdit(ColumnPos[2],y*controlheight,ColumnWid[2],false,SB);
 cbox_author[cat,y-1] :=CreateComboBox(ColumnPos[3],y*controlheight,ColumnWid[3],SB);
 edit_score[cat,y-1]  :=CreateEdit(ColumnPos[4],y*controlheight,ColumnWid[4],not competitions[comp].Ext_judge,SB);
 edit_voting[cat,y-1] :=CreateEdit(ColumnPos[5],y*controlheight,ColumnWid[5],true,SB);
 edit_place[cat,y-1]  :=CreateEdit(ColumnPos[6],y*controlheight,ColumnWid[6],true,SB);
 //Setup the event handlers
 panl_ID[cat,y-1].OnClick:=@IgnorePhoto;
 edit_title[cat,y-1].OnExit:=@season_titleExit;
 edit_title[cat,y-1].OnKeyPress:=@EditorKeyPress;
 cbox_author[cat,y-1].OnChange:=@season_titleExit;
 //Right click menu
 panl_ID[cat,y-1].PopupMenu:=PhotoMenu;
 edit_title[cat,y-1].PopupMenu:=PhotoMenu;
 cbox_author[cat,y-1].PopupMenu:=PhotoMenu;
 edit_score[cat,y-1].PopupMenu:=PhotoMenu;
 edit_voting[cat,y-1].PopupMenu:=PhotoMenu;
 edit_place[cat,y-1].PopupMenu:=PhotoMenu;
 if competitions[comp].Ext_judge then
 begin
  edit_score[cat,y-1].OnExit:=@season_titleExit;
  edit_score[cat,y-1].OnKeyPress:=@EditorKeyPress;
  edit_score[cat,y-1].ReadOnly:=False;
  edit_score[cat,y-1].NumbersOnly:=True;
  edit_score[cat,y-1].MaxLength:=3;
  edit_voting[cat,y-1].OnExit:=@season_titleExit;
  edit_voting[cat,y-1].OnKeyPress:=@EditorKeyPress;
  edit_voting[cat,y-1].ReadOnly:=False;
  edit_voting[cat,y-1].NumbersOnly:=True;
  edit_voting[cat,y-1].MaxLength:=2;
 end;
 //Fill in the fields
 FillInPhotoControl(cat,y,x);
 //Move the button down
 add_btn[cat].Top:=(y+1)*controlheight;
end;

{-------------------------------------------------------------------------------
Set photo as 'ignored'
-------------------------------------------------------------------------------}
procedure TMainForm.IgnorePhoto(Sender: TObject);
var
 cat,p,index: Integer;
begin
 index:=GetTagFromControl(Sender);
 if index>=0 then
 begin
  //Just flag it
  photographs[index].Ignore:=not photographs[index].Ignore;
  //And recolour it
  for cat:=0 to Length(panl_ID)-1 do
   for p:=0 to Length(panl_ID[cat])-1 do
    MarkEmptyPhotos(cat,p+1);
  //Then remove it from the results
  RecalculateResults(comp_title.Tag);
 end;
end;

{-------------------------------------------------------------------------------
Get the Tag from a control, type unknown. Returns -1 if type not known
-------------------------------------------------------------------------------}
function TMainForm.GetTagFromControl(Sender: TObject): Integer;
begin
 Result:=-1; //In case it is none of these controls
 If Sender is TPanel    then Result:=(Sender as TPanel).Tag;
 if Sender is TEdit     then Result:=(Sender as TEdit).Tag;
 if Sender is TComboBox then Result:=(Sender as TComboBox).Tag;
end;

{-------------------------------------------------------------------------------
Ignore menu item clicked
-------------------------------------------------------------------------------}
procedure TMainForm.IgnPhotoMenuClick(Sender: TObject);
begin
 //Just find the appropriate calling control and pass to the IgnorePhoto procedure
 IgnorePhoto(((Sender as TMenuItem).GetParentMenu as TPopUpMenu).PopupComponent);
end;

{-------------------------------------------------------------------------------
Mark Photo if title or author are 'blank'
-------------------------------------------------------------------------------}
procedure TMainForm.MarkEmptyPhotos(cat,y: Integer);
const
 blank  = clYellow;
 filled = clBtnFace;
 ignore = clRed;
begin
 //Check to see if the title is not filled in
 if (edit_title[cat,y-1].Text=blank_title)
 or (edit_title[cat,y-1].Text='')
 //or the author not filled in
 or (cbox_author[cat,y-1].ItemIndex=0) then
  panl_ID[cat,y-1].Color:=blank //Make it a stand out
 else
  panl_ID[cat,y-1].Color:=filled; //otherwise make it the same as the rest
 //Is the photo marked as 'ignored'
 if photographs[panl_ID[cat,y-1].Tag].Ignore then
  panl_ID[cat,y-1].Color:=ignore;
 //If the title is blank, put the blank text in
 if edit_title[cat,y-1].Text='' then
  edit_title[cat,y-1].Text:=blank_title;
end;

{-------------------------------------------------------------------------------
Add New Photograph
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewPhotograph(tab: Integer);
var
 comp,x,y: Integer;
begin
 comp:=comp_title.Tag; {Competition number}
 y:=PhotosPerCat(comp,tab)+1;
 //Increase the number of photographs
 SetLength(photographs,Length(photographs)+1);
 x:=Length(photographs);
 //Setup the array
 photographs[x-1].Competition:=comp;
 photographs[x-1].Category:=tab;
 photographs[x-1].ID:=ConvertToID(y);
 photographs[x-1].Title:=blank_title;
 photographs[x-1].Author:=0;
 photographs[x-1].Score:=0;
 AddPhotoControl(comp,tab,x-1);
 //Save the data
 SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
Show Annual Results button has been clicked
-------------------------------------------------------------------------------}
procedure TMainForm.btn_a_resultsClick(Sender: TObject);
begin
 OutputResults(1,1);
end;


{-------------------------------------------------------------------------------
Import voting slip from website
-------------------------------------------------------------------------------}
procedure TMainForm.ImportOnlineComp(Sender: TObject);
var
 num_cats,
 cat,
 photo,
 vote,
 i,e,
 progress: Integer;
 slip    : array of array of array of String;
 match   : Boolean;
 temp    : String;
begin
 if ImportOnlineForm.ShowModal=mrOK then
 begin
  num_cats:=Length(ImportOnlineForm.Categories);
  progress:=0;
  //Only continue if the number of categories match
  if num_cats=Length(categories) then
  begin
   //Check the category names and only continue if match
   match:=True;
   for cat:=0 to num_cats-1 do
   begin
    if categories[cat]<>ImportOnlineForm.Categories[cat] then match:=False;
    inc(progress,Length(ImportOnlineForm.Photographs[cat]));
    if cat<Length(panl_ID) then inc(progress,Length(panl_ID[cat]));
   end;
   if match then
   begin
    inc(progress,Length(panl_vslip));
    //Setup the progress bar
    ProgressBar1.Max:=progress;
    ProgressBar1.Position:=0;
    ProgressBar1.Update;
    Application.ProcessMessages;
    progress:=0;
    //Delete all entries in each category
    for cat:=0 to num_cats-1 do
     for photo:=Length(panl_ID[cat])-1 downto 0 do
     begin
      DeletePhotograph(cat,photo);
      inc(progress);
      ProgressBar1.Position:=progress;
      ProgressBar1.Update;
      Application.ProcessMessages;
     end;
    //Delete all voting slips
    for vote:=Length(panl_vslip)-1 downto 0 do
    begin
     //Delete the slips
     for cat:=0 to num_cats-1 do
     begin
      v_slips[panl_vslip[vote].Tag+cat].Used:=False;
      v_slips[panl_vslip[vote].Tag+cat].Competition:=-1;
      v_slips[panl_vslip[vote].Tag+cat].Category:=-1;
     end;
     //Delete the controls
     panl_vslip[vote].Free;
     delvotslip_btn[vote].Free;
     for i:=0 to Length(edit_vslip[vote])-1 do
      for e:=0 to Length(edit_vslip[vote,i])-1 do
      begin
       edit_vslip[vote,i,e].Free;
       inc(progress);
       ProgressBar1.Position:=progress;
       ProgressBar1.Update;
       Application.ProcessMessages;
      end;
    end;
    SetLength(panl_vslip,    0);
    SetLength(delvotslip_btn,0);
    SetLength(edit_vslip,    0);
    //Import all entries in each category
    for cat:=0 to num_cats-1 do
     for photo:=0 to Length(ImportOnLineForm.Photographs[cat])-1 do
     begin
      AddNewPhotograph(cat);
      i:=Length(photographs)-1;
      photographs[i].Title:=ImportOnlineForm.Photographs[cat,photo];
      photographs[i].Score:=0;
      photographs[i].Position:='0';
      photographs[i].Voting:='';
      photographs[i].Author:=FindAuthor(ImportOnlineForm.Authors[cat,photo]);
      e:=Length(panl_ID[cat])-1;
      edit_title[cat,e].Text      :=photographs[i].Title;
      edit_score[cat,e].Text      :=IntToStr(photographs[i].Score);
      cbox_author[cat,e].ItemIndex:=photographs[i].Author;
      edit_voting[cat,e].Text     :=photographs[i].Voting;
      edit_place[cat,e].Text      :=photographs[i].Position;
      MarkEmptyPhotos(cat,e+1);
      inc(progress);
      ProgressBar1.Position:=progress;
      ProgressBar1.Update;
      Application.ProcessMessages;
     end;
    //Import all voting slips
    SetLength(slip,Length(ImportOnlineForm.VoteSlips),num_cats,season.m_Places_to_score);
    //Decode the CSV format into a temporary array
    for vote:=0 to Length(ImportOnlineForm.VoteSlips)-1 do
    begin
     temp:=ImportOnlineForm.VoteSlips[vote];
     cat:=0;
     e:=0;
     while Pos(',',temp,1)<>0 do
     begin
      if cat<num_cats then slip[vote,cat,e]:=LeftStr(temp,Pos(',',temp,1)-1);
      temp:=Copy(temp,Pos(',',temp,1)+1,Length(temp));
      inc(e);
      if e=season.m_Places_to_score then
      begin
       e:=0;
       inc(cat);
       //if cat>=num_cats then cat:=num_cats-1;
      end;
     end;
     if temp<>'' then slip[vote,num_cats-1,season.m_Places_to_score-1]:=temp;
     //Add a new voting slip, including the controls
     AddNewVotingSlip(False);
     //Get the reference for the new voting slip
     e:=panl_vslip[Length(panl_vslip)-1].Tag;
     //Now populate the places
     for cat:=0 to num_cats-1 do
      for i:=0 to season.m_Places_to_score-1 do
       if slip[vote,cat,i]<>'-1' then
       begin
        v_slips[e+cat].Places[i]:=slip[vote,cat,i];
        edit_vslip[Length(edit_vslip)-1,cat,i].Text:=v_slips[e+cat].Places[i];
       end;
     inc(progress);
     ProgressBar1.Position:=progress;
     ProgressBar1.Update;
     Application.ProcessMessages;
    end;
    RecalculateResults(comp_title.Tag);
    SaveSeasonFile;
    ProgressBar1.Position:=0;
    ProgressBar1.Update;
    Application.ProcessMessages;
    ShowMessage('Finished importing');
   end
   else
    MessageDlg('Category names differ. Cannot continue.',mtError,[mbOK],0);
  end
  else
   MessageDlg('Number of categories differ. Cannot continue.',mtError,[mbOK],0);
 end;
end;

{-------------------------------------------------------------------------------
Print Annual Results button has been clicked
-------------------------------------------------------------------------------}
procedure TMainForm.btn_prt_a_resultsClick(Sender: TObject);
begin
 if PrintDialog1.Execute then OutputResults(3,1);
end;

{-------------------------------------------------------------------------------
Save Annual Results button has been clicked
-------------------------------------------------------------------------------}
procedure TMainForm.btn_save_a_resultsClick(Sender: TObject);
begin
 csv_Save.FileName:=MakeFilenameValid('Photographers Of The Year '+season.Title+'.csv');
 if csv_Save.Execute then OutputResults(2,1);
end;

{-------------------------------------------------------------------------------
Sort Members into order
-------------------------------------------------------------------------------}
procedure TMainForm.SortMembers(opening: Boolean);
var
 i,j,del: Integer;
 SortMember: array of String;
 RefMember: array of Integer;
 memberCopy: TMembersArray;
begin
 //Create a string array and populate with members: surname forename
 SetLength(SortMember,Length(members));
 del:=0;
 for i:=1 to Length(members)-1 do
  //If number of photographs is less than zero, then member has been deleted, so
  //shift to the end
  if members[i].Num_photos>=0 then
   SortMember[i]:=members[i].Surname+' '+members[i].Forename
  else
  begin
   SortMember[i]:=#126+members[i].Surname+' '+members[i].Forename;
   inc(del);
  end;
 SortMember[0]:=' ';
 //Sort this array into order
 ArraySortA(SortMember);
 //Create an integer array, length of members, and zero
 SetLength(RefMember,Length(members));
 for i:=0 to Length(members)-1 do
  RefMember[i]:=0;
 //Iterate through sorted array, comparing with members array (surname forename)
 // and note offset in integer array at same position in sorted array (i.e.
 // translation table)
 for i:=0 to Length(members)-1 do
  for j:=0 to Length(members)-1 do
   if (members[i].Surname+' '+members[i].Forename=SortMember[j])
   or (#126+members[i].Surname+' '+members[i].Forename=SortMember[j]) then
    RefMember[i]:=j;
 //Create a copy of membership array
 memberCopy:=Copy(members);
 //Iterate through membership array, using RefMember and membership copy arrays
 // to sort into order
 for i:=0 to Length(members)-1 do
  members[RefMember[i]]:=memberCopy[i];
 //Update MembersList array
 for i:=1 to Length(members)-1 do
  MembersList[i]:=members[i].Forename+' '+members[i].Surname;
 //Iterate through photographs, changing membership ref for sorted ref
 for i:=0 to Length(photographs)-1 do
  photographs[i].Author:=RefMember[photographs[i].Author];
 //Update Membership list controls
 for i:=0 to Length(edit_surname)-1 do
 begin
  edit_surname[i].Text:=members[i+1].Surname;
  edit_forename[i].Text:=members[i+1].Forename;
  members[i+1].Num_photos:=CountPhotographs(i+1);
  edit_photocount[i].Text:=IntToStr(members[i+1].Num_photos);
  if members[i+1].Num_photos>0 then
   SB_deletemember[i].Enabled:=false
  else
   SB_deletemember[i].Enabled:=true;
 end;
 //Remove any deleted members
 if del>0 then
 begin
  for i:=Length(edit_surname)-1 downto Length(edit_surname)-del do
  begin
   add_btn_src.Top:=edit_surname[i].Top;
   edit_surname[i].Free;
   edit_forename[i].Free;
   edit_photocount[i].Free;
   SB_deletemember[i].Free;
  end;
  SetLength(members,Length(members)-del);
  SetLength(MembersList,Length(MembersList)-del);
  SetLength(edit_surname,Length(edit_surname)-del);
  SetLength(edit_forename,Length(edit_forename)-del);
  SetLength(edit_photocount,Length(edit_photocount)-del);
  SetLength(SB_deletemember,Length(SB_deletemember)-del);
 end;
 //Repopulate and refresh all open combo boxes
 RePopulateMembers;
 if not opening then SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
Delete Redundant Photographs
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteRedundantPhotographs(Sender: TObject);
var
 i,cat: Integer;
 found_high: Boolean;
begin
 //Recalculate the results so we can delete those with zero score
 RecalculateResults(comp_title.Tag);
 //Go through each category
 for cat:=0 to season.Num_categories-1 do
 begin
  i:=Length(panl_ID[cat])-1;
  found_high:=false; //'found' flag
  //We'll start at the end and work back until we find a photograph with a score
  //and an author
  while (found_high=false) and (i>=0) do
  begin
   if (edit_score[cat,i].Text='0') and (cbox_author[cat,i].ItemIndex=0) then
    DeletePhotograph(cat,i)
   else found_high:=True;
   dec(i);
  end;
{  //Move the add button back up
  add_btn[cat].Top:=(Length(panl_ID[cat])+1)*controlheight;}
 end;
 //and finally save the data file
 SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
Import Photographs from CSV
-------------------------------------------------------------------------------}
procedure TMainForm.ImportPhotos(Sender: TObject);
var
 i,X,p,n,e,
 PhotoTitleCol,AuthorCol,ScoreCol,PosCol: Integer;
const
 DDList: array[1..4] of String = ('Author','Title','Score','Position');
begin
 csv_open.Title:='Import Photos from CSV into '
                +cat_pages.ActivePage.Caption
                +' Category';
 If csv_open.Execute then
 begin
  //Setup the column variables
  AuthorCol:=-1;
  ScoreCol:=-1;
  PosCol:=-1;
  //Load the file, and setup the import dialogue box
  X:=ImportForm.LoadCSV(csv_open.FileName,DDList);
  //Continue setting up Import Dialogue Box, if there are enough columns
  if X>=2 then
  begin
   //Set all the headers to 'Don't Import', and the widths to 128px
   for i:=0 to ImportForm.sg_Columns.ColCount-1 do
   begin
    ImportForm.sg_Columns.Cells[i,0]:=ImportForm.cb_ColContents.Items[0];
    if i>0 then
     ImportForm.sg_Columns.ColWidths[i]:=128
    else
     ImportForm.sg_Columns.ColWidths[i]:=192;
   end;
   //Put the title in the first column
   PhotoTitleCol:=0;
   //Add the text
   ImportForm.sg_Columns.Cells[PhotoTitleCol,0]:=
                                      ImportForm.cb_ColContents.Items[2];
   //Depending on the number of columns, arrange the other fields
   if X>1 then AuthorCol:=1;
   if X>2 then PosCol:=2;
   if X>3 then
   begin
    ScoreCol:=2;
    PosCol:=3;
   end;
   //And then put the text in
   if AuthorCol>=0 then
    ImportForm.sg_Columns.Cells[AuthorCol,0]:=
                                      ImportForm.cb_ColContents.Items[1];
   if ScoreCol>=0 then
    ImportForm.sg_Columns.Cells[ScoreCol,0]:=
                                      ImportForm.cb_ColContents.Items[3];
   if PosCol>=0 then
    ImportForm.sg_Columns.Cells[PosCol,0]:=
                                      ImportForm.cb_ColContents.Items[4];
   //Now open the Import form
   ImportForm.ShowModal;
   //User clicked on OK, so import the photos
   if ImportForm.ModalResult=mrOK then
   begin
    //Get the columns to import
    PhotoTitleCol:=-1;
    AuthorCol:=-1;
    ScoreCol:=-1;
    PosCol:=-1;
    for i:=0 to ImportForm.sg_Columns.ColCount-1 do
     case ImportForm.cb_ColContents.Items.IndexOf(ImportForm.sg_Columns.Cells[i,0]) of
      1: AuthorCol:=i;
      2: PhotoTitleCol:=i;
      3: ScoreCol:=i;
      4: PosCol:=i;
     end;
    //Import the photos
    for p:=1 to ImportForm.sg_Columns.RowCount-1 do
    begin
     AddNewPhotograph(cat_pages.ActivePageIndex);
     i:=Length(photographs)-1;
     //Photograph title
     if PhotoTitleCol>=0 then
      photographs[i].Title:=ImportForm.sg_Columns.Cells[PhotoTitleCol,p];
     //Score given
     if ScoreCol>=0 then
      photographs[i].Score:=StrToIntDef(ImportForm.sg_Columns.Cells[ScoreCol,p],0);
     //Place given
     if PosCol>=0 then
      photographs[i].Position:=ImportForm.sg_Columns.Cells[PosCol,p];
     if competitions[comp_title.Tag].Ext_judge then
      photographs[i].Voting:=photographs[i].Position;
     //Author
     if AuthorCol>=0 then
      photographs[i].Author:=FindAuthor(ImportForm.sg_Columns.Cells[AuthorCol,p]);
     //Update photo controls
     n:=cat_pages.ActivePageIndex;
     e:=Length(panl_ID[n])-1;
     edit_title[n,e].Text      :=photographs[i].Title;
     edit_score[n,e].Text      :=IntToStr(photographs[i].Score);
     cbox_author[n,e].ItemIndex:=photographs[i].Author;
     edit_voting[n,e].Text     :=photographs[i].Voting;
     edit_place[n,e].Text      :=photographs[i].Position;
     MarkEmptyPhotos(n,e+1);
    end;
    RecalculateResults(comp_title.Tag);
    SaveSeasonFile;
   end;
  end;
 end;
end;

{-------------------------------------------------------------------------------
Insert photo (menu click)
-------------------------------------------------------------------------------}
procedure TMainForm.InsPhotoMenuClick(Sender: TObject);
var
 index,cat,i: Integer;
 ID: String;
begin
 {This needs to shift everything down by one, adding a new one at the bottom.}
 index:=GetTagFromControl(((Sender as TMenuItem).GetParentMenu as TPopUpMenu).PopupComponent);
 if index>=0 then
 begin
  cat:=cat_pages.ActivePageIndex;
  //Add new photograph
  AddNewPhotograph(cat);
  //Move all from index to the end down by one (except ID)
  i:=Length(panl_ID[cat])-1;
  repeat
   ID:=photographs[panl_ID[cat,i].Tag].ID;
   photographs[panl_ID[cat,i].Tag]:=photographs[panl_ID[cat,i-1].Tag];
   photographs[panl_ID[cat,i].Tag].ID:=ID;
   //Update the control, and mark empty photos
   FillInPhotoControl(cat,i+1,panl_ID[cat,i].Tag);
   dec(i);
  until (panl_ID[cat,i].Tag=index) or (i=0);
  //Blank off index details (except ID)
  photographs[index].Title:='';
  photographs[index].Author:=0;
  photographs[index].Score:=0;
  photographs[index].Position:='';
  photographs[index].Tally:='';
  photographs[index].Voting:='';
  MarkEmptyPhotos(cat,i+1);
  //Recalculate results and save data
  RecalculateResults(comp_title.Tag);
  SaveSeasonFile;
 end;
end;

{-------------------------------------------------------------------------------
Recalculate Results
-------------------------------------------------------------------------------}
procedure TMainForm.btn_recalculateClick(Sender: TObject);
begin
 RecalculateResults(comp_title.Tag);
end;

{-------------------------------------------------------------------------------
Show competition results
-------------------------------------------------------------------------------}
procedure TMainForm.btn_resultsClick(Sender: TObject);
begin
 OutputResults(1,0);
end;

{-------------------------------------------------------------------------------
Save competition results
-------------------------------------------------------------------------------}
procedure TMainForm.btn_saveresultsClick(Sender: TObject);
begin
 csv_Save.FileName:=MakeFilenameValid(comp_title.Text+
                    ' ('+MonthList[competitions[comp_title.Tag].Month+1]+').csv');
 if csv_Save.Execute then OutputResults(2,0);
end;

{-------------------------------------------------------------------------------
Print competition results
-------------------------------------------------------------------------------}
procedure TMainForm.print_btnClick(Sender: TObject);
begin
 if PrintDialog1.Execute then OutputResults(3,0);
end;

{-------------------------------------------------------------------------------
Display the tally results
-------------------------------------------------------------------------------}
procedure TMainForm.ShowTally(Sender: TObject);
var
 S: TSpeedButton;
 X: String;
 i: Integer;
begin
 if Sender is TSpeedButton then
 begin
  S:=Sender as TSpeedButton;
  X:='"'+photographs[S.Tag].Title+'" by '
    +MembersList[photographs[S.Tag].Author]+#13+#10;
  for i:=0 to season.m_Places_to_score-1 do
   X:=X+'Number of '+IntToPos(i+1)+'s: '
       +IntToStr(StrToInt((Copy(photographs[S.Tag].Tally,(i*2)+1+3,2))))
       +#13+#10;
  ShowMessage(X);
 end;
end;

{-------------------------------------------------------------------------------
New Voting Slip - dialogue box style
-------------------------------------------------------------------------------}
procedure TMainForm.btn_votingslipClick(Sender: TObject);
begin
 VotingForm.pnl_slipnum.Caption:=
           IntToStr((VSlipsPerComp(comp_title.Tag)div season.Num_categories)+1);
 VotingForm.ShowModal;
 if VotingForm.ModalResult=mrOK then
 begin
  AddNewVotingSlip(true);
  ValidateVSlips(VSlipsPerComp(comp_title.Tag));
  if cat_pages.ActivePageIndex<>season.Num_categories then
   //If we are on a page other than the voting slips, do a recalculate
   RecalculateResults(comp_title.Tag);
  SaveSeasonFile;
 end;
end;

{-------------------------------------------------------------------------------
Page has changed
-------------------------------------------------------------------------------}
procedure TMainForm.PageHasChanged(Sender: TObject);
begin
 btn_importphotos.Enabled:=False;
 btn_importonlinecomp.Enabled:=False;
 if cat_pages.ActivePageIndex<season.Num_categories then
 begin
  //We are not on the voting slip page, enable the button to import photos
  btn_importphotos.Enabled:=True;
  //And the Import Online Competition button
  btn_importonlinecomp.Enabled:=True;
 end;
 //Change the graph
 DisplayActiveVoteGraph;
end;

{-------------------------------------------------------------------------------
Page is changing
-------------------------------------------------------------------------------}
procedure TMainForm.PageIsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
 if cat_pages.ActivePageIndex=season.Num_categories then
  //As we are moving away from the voting slip page, do a recalculate
  RecalculateResults(comp_title.Tag);
 SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
New Voting Slip
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewVotingSlip(dialogue: Boolean);
var
 x,i,j: Integer;
begin
 //x points to the next new voting slip
 x:=Length(v_slips);
 //Increase number of voting slips by number of categories
 SetLength(v_slips,Length(v_slips)+season.Num_categories);
 for i:=0 to season.Num_categories-1 do
 begin
  //Fill in competition, category and used fields
  v_slips[x+i].Competition:=comp_title.Tag;
  v_slips[x+i].Category:=i;
  v_slips[x+i].Used:=True;
  //And make space for the places
  SetLength(v_slips[x+i].Places,season.m_Places_to_score);
  //Now populate the places
  for j:=0 to season.m_Places_to_score-1 do
   if dialogue then
    v_slips[x+i].Places[j]:=VotingForm.Positions[i,j].Text
   else
    v_slips[x+i].Places[j]:='';
 end;
 if dialogue then VotingForm.FreeControls;
 AddVotingControl(comp_title.Tag,x);
 SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
New Voting Slip Controls
-------------------------------------------------------------------------------}
procedure TMainForm.AddVotingControl(comp,x: Integer);
var
 i,j,vslip,cat: Integer;
begin
 //Get the voting slip number
 vslip:=Length(edit_vslip);
 //Increase the control arrays
 SetLength(edit_vslip,       vslip+1);
 SetLength(panl_vslip,       vslip+1);
 SetLength(delvotslip_btn,   vslip+1);
 SetLength(edit_vslip[vslip],season.Num_categories,season.m_Places_to_score);
 //Create the controls
 //Voting slip number panel
 panl_vslip[vslip]:=CreatePanel(IntToStr(vslip+1),
                                0,
                                (3*controlheight)+(vslip*controlheight),
                                22,sb_vslip);
 panl_vslip[vslip].Tag:=x;
 if not v_slips[x].Used then
  panl_vslip[vslip].Color:=clRed;
 //Delete voting slip button
 delvotslip_btn[vslip]:=CreateSpeedButton(
                                       (3*controlheight)+(vslip*controlheight),
                                       vslip,sb_vslip);
 delvotslip_btn[vslip].Left:=22
                          +((season.m_Places_to_score*
                             (photo_maxlength*widthperchar)+4)*
                             season.Num_categories);
 if v_slips[x].Used then
 begin
  delvotslip_btn[vslip].Glyph:=del_btn_src.Glyph;
  delvotslip_btn[vslip].Hint:=delvs_hint;
 end
 else
 begin
  delvotslip_btn[vslip].Glyph:=OKbtnsrc.Glyph;
  delvotslip_btn[vslip].Hint:=undelvs_hint;
 end;
 delvotslip_btn[vslip].OnClick:=@DeleteVoteSlip;
 for i:=0 to season.m_places_to_score-1 do
 begin
  for cat:=0 to season.Num_categories-1 do
  begin
   //Find the voting slip for the category/competition
   j:=x-1; //x is the slip for the first category
   repeat
    inc(j); //the rest don't necessarily follow on
   until (v_slips[j].Competition=comp) and (v_slips[j].Category=cat);
   //Vote entry edit boxes
   edit_vslip[vslip,cat,i]:=CreateEdit(22
                           +((season.m_Places_to_score*(photo_maxlength*widthperchar)+4)*cat)
                           +(i*(photo_maxlength*widthperchar)),
                           (3*controlheight)+(vslip*controlheight),
                           photo_maxlength*widthperchar,
                           false,sb_vslip);
   //Change the attributes
   edit_vslip[vslip,cat,i].Text:=v_slips[j].Places[i];
   edit_vslip[vslip,cat,i].OnChange:=@VotingForm.Pos_1_1Change;
   edit_vslip[vslip,cat,i].OnExit:=@season_titleExit;
   edit_vslip[vslip,cat,i].OnKeyPress:=@EditorKeyPress;
   edit_vslip[vslip,cat,i].MaxLength:=photo_maxlength;
   edit_vslip[vslip,cat,i].CharCase:=ecUpperCase;
   edit_vslip[vslip,cat,i].Tag:=j;
   if not v_slips[j].Used then
   begin
    edit_vslip[vslip,cat,i].Color:=clRed;
    edit_vslip[vslip,cat,i].ReadOnly:=True;
   end;
   //Increase the length of the red line between the categories
   if cat<season.Num_categories-1 then
    panl_splitter[cat].Height:=(vslip+4)*controlheight;
  end;
 end;
 //Move the add button down
 add_btn[season.Num_categories].Top:=(vslip+4)*controlheight;
 //Repaint the form
 sb_vslip.Repaint;
end;

{-------------------------------------------------------------------------------
Enable/disable controls and setup main form
-------------------------------------------------------------------------------}
procedure TMainForm.EnableControls(lcontrols: Integer);
var
 e: Boolean;
begin
 e:=false; //To enable screen shots with all controls enabled, set this to true
 //Disable all controls
 LoadMembers.Enabled:=e;
 btn_a_results.Enabled:=e;
 btn_prt_a_results.Enabled:=e;
 btn_save_a_results.Enabled:=e;
 btn_votingslip.Enabled:=e;
 btn_delphotographs.Enabled:=e;
 btn_results.Enabled:=e;
 print_btn.Enabled:=e;
 btn_saveresults.Enabled:=e;
 comp_date.Enabled:=e;
 add_btn_src.Enabled:=e;
 cat_pages.Visible:=e;
 sb_editseason.Enabled:=e;
 btn_importphotos.Enabled:=e;
 btn_importonlinecomp.Enabled:=e;
 btn_recalculate.Enabled:=e;
 sb_closecomp.Enabled:=e;
 sb_CloseSeason.Enabled:=e;
 cat_pages.Visible:=False;
 //Now re-enable those required
 if  ((lcontrols=ec_OpenSeason)or(lcontrols=ec_OpenComp))
 and (season.Filename<>'') then
 begin
  season_title.Text:=season.Title;
  season_title.ReadOnly:=False;
  add_btn_src.Enabled:=True;
  btn_a_results.Enabled:=True;
  btn_save_a_results.Enabled:=True;
  btn_prt_a_results.Enabled:=Printer.Printers.Count>0;
  LoadMembers.Enabled:=True;
  sb_editseason.Enabled:=True;
  sb_CloseSeason.Enabled:=True;
 end;
 if lcontrols=ec_OpenComp then
 begin
  btn_results.Enabled:=True;     //Display results on screen
  btn_saveresults.Enabled:=True; //Save results to a file
  print_btn.Enabled:=Printer.Printers.Count>0;//Prints results to a printer
  btn_recalculate.Enabled:=True; //Recalculates positions
  btn_importphotos.Enabled:=True;//Import Photos via CSV
  btn_importonlinecomp.Enabled:=True;//Import entire competition
  btn_delphotographs.Enabled:=True; //Delete Redundant Photos
  if comp_title.Tag>=0 then        //Voting Slip
   btn_votingslip.Enabled:=not competitions[comp_title.Tag].Ext_judge;
  comp_date.Enabled:=True;
  cat_pages.Visible:=True;
  sb_closecomp.Enabled:=True;
 end;
end;

{-------------------------------------------------------------------------------
Change the judging picture
-------------------------------------------------------------------------------}
procedure TMainForm.ChangeJudgeType(ext: Boolean;var pic: TImage);
begin
 if ext then
 begin
  pic.Picture:=no_ext_judge.Picture;
  pic.Hint:=int_judge_hint;
 end
 else
 begin
  pic.Picture:=pic_judge.Picture;
  pic.Hint:=ext_judge_hint;
 end;
end;

{-------------------------------------------------------------------------------
Add controls for a new competition
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewCompControl;
var
 i: Integer;
 S: String;
begin
 //Get number of competitions already created
 i:=Length(open_btn);
 //And extend the button arrays to suit
 SetLength(open_btn,i+1);
 SetLength(judge_img,i+1);
 SetLength(delcomp_btn,i+1);
 //Create the 'external judge' option button
 judge_img[i]:=CreateImage(1,(i*ControlHeight)+2,i,sb_complist);
 if i<season.Num_competitions then
  ChangeJudgeType(competitions[i].Ext_judge,judge_img[i])
 else
  judge_img[i].Visible:=False;
 //Create, and set up, the 'Delete competition' button
 delcomp_btn[i]:=CreateSpeedButton(i*ControlHeight,i,sb_complist);
 delcomp_btn[i].Left:=21;
 delcomp_btn[i].Glyph:=del_btn_src.Glyph;
 delcomp_btn[i].Width:=21;
 delcomp_btn[i].Margin:=0;
 delcomp_btn[i].OnClick:=@DeleteCompetitionClick;
 delcomp_btn[i].Hint:='Delete Competition';
 //Create, and set up, the 'open competition' button
 open_btn[i]:=CreateSpeedButton(i*ControlHeight,i,sb_complist);
 open_btn[i].Left:=21+21;
 open_btn[i].Glyph:=btn_opencomp.Glyph;
 open_btn[i].OnClick:=@OpenCompetition;
 if i<season.Num_competitions then
  S:=competitions[i].Title
 else
 begin
  S:='New Competition';
  delcomp_btn[i].Visible:=False;
 end;
 open_btn[i].Caption:=S;
 open_btn[i].Width:=148;
 open_btn[i].Font.Style:=[fsBold];
 open_btn[i].Margin:=0;
 if i<season.Num_competitions then
  open_btn[i].Hint:=opencomp_hint
 else
  open_btn[i].Hint:=createcomp_hint;
 if i=12 then open_btn[i].Visible:=False;
end;

{-------------------------------------------------------------------------------
First element of members array is a special one
-------------------------------------------------------------------------------}
procedure TMainForm.SetUpMembersList;
begin
 members[0].Forename:='';
 members[0].Surname:='';
 SetLength(members[0].Score,season.Num_categories);
 SetLength(members[0].Tally,season.Num_categories);
 MembersList[0]:='<none selected>';
 members[0].Num_photos:=0;
end;

{-------------------------------------------------------------------------------
Validate The Voting Slips
-------------------------------------------------------------------------------}
procedure TMainForm.ValidateVSlips(num_vslips: Integer);
var
 j,cat,pos,i,entry: Integer;
begin
 if num_vslips>0 then
 begin
  //Check for duplicates
  for j:=0 to (num_vslips div season.Num_categories)-1 do
   for cat:=0 to MainForm.season.Num_categories-1 do
    for pos:=0 to MainForm.season.m_Places_to_score-1 do
     for i:=0 to MainForm.season.m_Places_to_score-1 do
      if (pos<>i)
      and (edit_vslip[j,cat,pos].Text=edit_vslip[j,cat,i].Text)
      and (edit_vslip[j,cat,i].Text<>'') then
       edit_vslip[j,cat,i].Text:='';
  //Check to make sure the votes are not out of specified range
  for j:=0 to (num_vslips div season.Num_categories)-1 do
   for cat:=0 to MainForm.season.Num_categories-1 do
    for pos:=0 to MainForm.season.m_Places_to_score-1 do
     if ConvertFromID(edit_vslip[j,cat,pos].Text)>ConvertFromID(edit_maxphotoID[cat].Text) then
      edit_vslip[j,cat,pos].Text:='';
  //Now ensure that the high positions are not blank
  for j:=0 to (num_vslips div season.Num_categories)-1 do
   for cat:=0 to MainForm.season.Num_categories-1 do
   begin
    i:=0;
    for pos:=0 to MainForm.season.m_Places_to_score-1 do
     if edit_vslip[j,cat,pos].Text='' then inc(i);
    if (i>0) and (i<4) then
     for pos:=1 to MainForm.season.m_Places_to_score-1 do
      if  (edit_vslip[j,cat,pos-1].Text='')
      and (edit_vslip[j,cat,pos].Text<>'') then
      begin
       edit_vslip[j,cat,pos-1].Text:=edit_vslip[j,cat,pos].Text;
       edit_vslip[j,cat,pos].Text:='';
      end;
   end;
  //Add in extra photographs
  for j:=0 to (num_vslips div season.Num_categories)-1 do
   for cat:=0 to MainForm.season.Num_categories-1 do
    for pos:=0 to MainForm.season.m_Places_to_score-1 do
    begin
     if v_slips[panl_vslip[j].Tag].Used then
      entry:=ConvertFromId(edit_vslip[j,cat,pos].Text)
     else entry:=0;
     if entry<0 then entry:=0;
     if entry>Length(edit_voting[cat]) then
      for i:=Length(edit_voting[cat]) to entry-1 do
       AddNewPhotograph(cat);
    end;
 end;
end;

{-------------------------------------------------------------------------------
Recalculate the Results for competition 'comp'
-------------------------------------------------------------------------------}
procedure TMainForm.RecalculateResults(comp: Integer);
var
 cat,i,j,pos,
 entry,
 num_photos,
 high,fromy  : Integer;
 s           : String;
 p           : array of Integer;
 p2          : array of String;
 pos_count   : array of array of array of Integer;
 photos      : array of TPhotographs;
 dest,source : TRect;
const
 //Voting graph constants
 OriginX     = 30; //Where the bottom left of the
 OriginY     = 25; //graph is, e.g. (0,0)
 TitleHeight = 25; //Margin for the title
 IDWidth     = 100;//Margin for the IDs
 xmulti      = 20; //Multipliers - determines the
 ymulti      = 10; //scale of the graph
 //Set Up the graph ------------------------------------------------------------
 procedure SetUpVoteGraph;
 begin
  if not competitions[comp].Ext_judge then
   if VSlipsPerComp(comp)>0 then
   begin
    vote_graph[cat].Picture.Bitmap.Width :=((VSlipsPerComp(comp)div season.Num_categories)*xmulti)
                           +OriginX+IDWidth;
    vote_graph[cat].Picture.Bitmap.Height:=
               ((VSlipsPerComp(comp)div season.Num_categories)*ymulti*m_scoring[0])
               +OriginY+TitleHeight;
    vote_graph[cat].Width:=vote_graph[cat].Picture.Bitmap.Width;
    vote_graph[cat].Height:=vote_graph[cat].Picture.Bitmap.Height;
    vote_graph[cat].Canvas.Pen.Color  :=$000000;
    vote_graph[cat].Canvas.Brush.Color:=clBtnFace;
    vote_graph[cat].Canvas.Rectangle(0,
                                     0,
                                     vote_graph[cat].Width,
                                     vote_graph[cat].Height);
   end;
 end;
 //Draw a line on the graph ----------------------------------------------------
 procedure DrawALine(entry,x,fromy,toy: Integer);
 var
  h: Integer;
 begin
  if not competitions[comp_title.Tag].Ext_judge then
   if VSlipsPerComp(comp_title.Tag)>0 then
   begin
    h:=vote_graph[cat].Height;
    vote_graph[cat].Canvas.Pen.Color:=Colour(entry);
    vote_graph[cat].Canvas.MoveTo(((x-1)*xmulti)+OriginX,(h-(fromy*ymulti))-OriginY);
    vote_graph[cat].Canvas.LineTo(( x   *xmulti)+OriginX,(h-(toy  *ymulti))-OriginY);
   end;
 end;
//Draw the scale and legends ---------------------------------------------------
 procedure DrawLegends;
 var
  w,h,i: Integer;
  x: TSize;
  S: String;
  offset: array of Integer;
 begin
  if not competitions[comp_title.Tag].Ext_judge then
   if VSlipsPerComp(comp_title.Tag)>0 then
   begin
    //Set the colour to draw with
    vote_graph[cat].Canvas.Pen.Color  :=$000000;
    //Draw the Y-axis
    vote_graph[cat].Canvas.MoveTo(OriginX,vote_graph[cat].Height-OriginY);
    vote_graph[cat].Canvas.LineTo(vote_graph[cat].Width-IDWidth,
                                  vote_graph[cat].Height-OriginY);
    //Draw the X-axis
    vote_graph[cat].Canvas.MoveTo(OriginX,vote_graph[cat].Height-OriginY);
    vote_graph[cat].Canvas.LineTo(OriginX,TitleHeight);
    //Set the text
    vote_graph[cat].Canvas.Brush.Style:=bsClear;
    vote_graph[cat].Canvas.Font.Name:='Arial';
    vote_graph[cat].Canvas.Font.Size:=8;
    vote_graph[cat].Canvas.Font.Style:=[];
    vote_graph[cat].Canvas.Font.Color:=$000000;
    //X-axis text
    vote_graph[cat].Canvas.Font.Orientation:=0;
    vote_graph[cat].Canvas.TextOut(OriginX,
                                   (vote_graph[cat].Height-OriginY)+4,
                                   'Voting Slips');
    //Y-axis text
    vote_graph[cat].Canvas.Font.Orientation:=900;
    S:='Score';
    w:=vote_graph[cat].Canvas.TextWidth(S)div 2;
    vote_graph[cat].Canvas.TextOut(OriginX-w,
                                   vote_graph[cat].Height-OriginY,S);
    //IDs
    vote_graph[cat].Canvas.Font.Orientation:=0;
    SetLength(offset,
           (VSlipsPerComp(comp_title.Tag)div season.Num_categories)*m_scoring[0]);
    //The offset array is used when multiple photos have the same final score
    for i:=0 to Length(offset)-1 do offset[i]:=0;
    high:=0; //Used to work out the highest score
    //Calculate the size of a letter
    x:=vote_graph[cat].Canvas.TextExtent('XX');
    w:=x.cx+4;
    h:=x.cy div 2;
    for i:=0 to Length(photographs)-1 do
     if  (photographs[i].Competition=comp_title.Tag)
     and (photographs[i].Category=cat)
     and (not photographs[i].Ignore) then
     begin
      vote_graph[cat].Canvas.Font.Color:=Colour(ConvertFromID(photographs[i].ID)-1);
      vote_graph[cat].Canvas.TextOut(
                (vote_graph[cat].Width-IDWidth)+4+(offset[photographs[i].Score]*w),
                vote_graph[cat].Height-((photographs[i].Score*ymulti)+OriginY+h),
                photographs[i].ID);
      inc(offset[photographs[i].Score]);
      if photographs[i].Score>high then high:=photographs[i].Score;
     end;
    //Shift the entire graphic up
    source.Left:=0;
    source.Top:=vote_graph[cat].Height-((high*ymulti)+OriginY+h);
    source.Width:=vote_graph[cat].Width;
    source.Height:=(high*ymulti)+OriginY+h;
    dest.Left:=0;
    dest.Top:=TitleHeight;
    dest.Height:=source.Height;
    dest.Width:=source.Width;
    vote_graph[cat].Canvas.CopyRect(dest,vote_graph[cat].Canvas,source);
    //Resize the image
    vote_graph[cat].Picture.Bitmap.Height:=(high*ymulti)
                                          +OriginY+TitleHeight;
    vote_graph[cat].Height:=vote_graph[cat].Picture.Bitmap.Height;
    //Title
    S:=competitions[comp_title.Tag].Title+' '+categories[cat]+' Category';
    vote_graph[cat].Canvas.Font.Style:=[fsBold];
    vote_graph[cat].Canvas.Font.Color:=$FF0000;
    i:=14;
    repeat
     vote_graph[cat].Canvas.Font.Size:=i;
     x:=vote_graph[cat].Canvas.TextExtent(S);
     w:=x.cx;
     h:=x.cy;
     dec(i);
    until w<=vote_graph[cat].Width;
    vote_graph[cat].Canvas.TextOut((vote_graph[cat].Width-w)div 2,
                                   TitleHeight-h,S);
   end;
 end;
//Main procedure starts here ---------------------------------------------------
begin
 //Validate the voting slips, if the current competition is open
 if not competitions[comp].Ext_judge then
  if comp=comp_title.Tag then ValidateVSlips(VSlipsPerComp(comp));
 SetLength(pos_count,season.Num_categories);
 //Blank the current results
 for cat:=0 to season.Num_categories-1 do
 begin
  //Get all the photos for this category/competition
  num_photos:=PhotosPerCat(comp,cat);
  j:=0;
  SetLength(photos,num_photos);
  for i:=0 to Length(photographs)-1 do
   if  (photographs[i].Competition=comp)
   and (photographs[i].Category=cat) then
   begin
    photos[j]:=photographs[i];
    inc(j);
   end;
  for i:=0 to num_photos-1 do
  begin
   if not competitions[comp].Ext_judge then
    begin
     photos[i].Score :=0;  //Score
     photos[i].Voting:=''; //Voting
    end;
   photos[i].Position:=''; //Position
   photos[i].Tally:='';    //Tally
  end;
  SetLength(pos_count[cat],num_photos,season.m_places_to_score);
  //Add in the voting slips and add up the scores
  if not competitions[comp].Ext_judge then
  begin
   //Setup the graph
   if comp=comp_title.Tag then SetUpVoteGraph;
   high:=0; //To keep track of number of voting slips used
   for i:=0 to Length(v_slips)-1 do
    if v_slips[i].Used then
     if  (v_slips[i].Competition=comp)
     and (v_slips[i].Category=cat) then
     begin
      fromy:=0;
      //Increase the voting slip counter
      inc(high);
      for pos:=0 to season.m_Places_to_score-1 do
      begin
       entry:=ConvertFromId(v_slips[i].Places[pos]);
       if entry>0 then
       begin
        inc(pos_count[cat,entry-1,pos]);
        j:=-1;
        repeat
         inc(j);
        until (photos[j].ID=v_slips[i].Places[pos])
           or (j=num_photos-1);
        if not photos[j].Ignore then
        begin
         photos[j].Voting:=photos[j].Voting+IntToStr(pos+1);
         if comp=comp_title.Tag then fromy:=photos[j].Score;
         inc(photos[j].Score,m_scoring[pos]);
         if comp=comp_title.Tag then
          DrawALine(j,high,fromy,photos[j].Score);
        end;
       end;
      end;
      for entry:=0 to num_photos-1 do
       if  (Length(photos[entry].Voting)<high)
       and (not photos[entry].Ignore) then
       begin
        photos[entry].Voting:=photos[entry].Voting+'0';
        if comp=comp_title.Tag then
         DrawALine(entry,high,photos[entry].Score,photos[entry].Score);
       end;
     end;
  end;
  //Sort into order
  SetLength(p,num_photos);
  high:=0;
  //First, take a copy of all the scores
  for j:=0 to num_photos-1 do
  begin
   p[j]:=photos[j].Score;
   if  (competitions[comp].Ext_judge)
   and (StrToIntDef(photos[j].Voting,0)<>0) then
    p[j]:=0;
  end;
  //Then sort into order
  ArraySort(p);
  //Populate the Position field with 'NP', unless externally voted for
  for i:=0 to num_photos-1 do
//   if not photos[i].Ignore then
    if  (competitions[comp].Ext_judge)
    and (StrToIntDef(photos[i].Voting,0)<>0) then
    begin
     photos[i].Position:=photos[i].Voting;
     if StrToInt(photos[i].Voting)>high then
      high:=StrToInt(photos[i].Voting);
    end
    else
     photos[i].Position:='NP';
  //Now populate the Position field with the place
  for i:=0 to Length(p)-1 do
   for j:=0 to num_photos-1 do
//    if not photos[j].Ignore then
    begin
     s:=photos[j].Position;
     if photos[j].Score=p[i] then
      if s='NP' then
       photos[j].Position:=IntToStr(i+1+high)
      else
       if (Copy(s,Length(s),1)<>'=') then
        if not((competitions[comp].Ext_judge) and (photos[j].Voting<>'')) then
         photos[j].Position:=photos[j].Position+'=';
    end;
  if (not competitions[comp].Ext_judge) and (season.SplitEqual) then
  begin
   //Separate the equal places
   SetLength(p2,num_photos);
   for i:=0 to num_photos-1 do
//   if not photos[i].Ignore then
    begin
     for pos:=0 to season.m_places_to_score-1 do
      photos[i].Tally:=photos[i].Tally+IntToPadStr(pos_count[cat,i,pos],'0',2);
     s:=photos[i].Position;
     photos[i].Position:='NP';
     if Copy(s,Length(s),1)='=' then s:=Copy(s,1,Length(s)-1);
     entry:=StrToIntDef(s,0);
     photos[i].Tally:=IntToPadStr(100-entry,'0',3)+photos[i].Tally;
     p2[i]:=photos[i].Tally;
    end;
   ArraySort(p2);
   for i:=0 to Length(p2)-1 do
    for j:=0 to num_photos-1 do
     if photos[j].Tally=p2[i] then
     begin
      if photos[j].Position='NP' then
       photos[j].Position:=IntToStr(i+1)
      else
       if Copy(photos[j].Position,Length(photos[j].Position),1)<>'=' then
        photos[j].Position:=photos[j].Position+'=';
     end;
  end;
  //Move the photograph copies back
  for i:=0 to num_photos-1 do
   for j:=0 to Length(photographs)-1 do
    if  (photographs[j].Competition=comp)
    and (photographs[j].Category=cat)
    and (photographs[j].ID=photos[i].ID) then
    begin
     photographs[j]:=photos[i];
     if photographs[j].Ignore then
     begin
      photographs[j].Score:=0;
      photographs[j].Position:='';
      photographs[j].Tally:='';
      photographs[j].Voting:='';
     end;
    end;
  //Populate the controls
  if comp=comp_title.Tag then
   for pos:=0 to Length(panl_ID[cat])-1 do
    FillInPhotoControl(cat,pos+1,panl_ID[cat,pos].Tag);
  //Draw the legend and scale on the graph
  if comp=comp_title.Tag then DrawLegends;//(cat);
 end;
 if  (comp_title.Tag=comp)
 and (not competitions[comp].Ext_judge) then
 begin
  sb_vote_graph.Visible:=True;
  vote_graph_master.Visible:=True;
  vote_graph_master.Top:=0;
  vote_graph_master.Left:=0;
  DisplayActiveVoteGraph;
 end;
 //Count the photos for the authors
 UpdatePhotoCount;
end;

{-------------------------------------------------------------------------------
Updates the photo counts per member
-------------------------------------------------------------------------------}
procedure TMainForm.UpdatePhotoCount;
var
 i: Integer;
begin
 for i:=1 to Length(members)-1 do
 begin
  members[i].Num_photos:=CountPhotographs(i);
  edit_photocount[i-1].Text:=IntToStr(members[i].Num_photos);
  if members[i].Num_photos>0 then
   SB_deletemember[i-1].Enabled:=false
  else
   SB_deletemember[i-1].Enabled:=true;
 end;
end;

{-------------------------------------------------------------------------------
Adds a new member
-------------------------------------------------------------------------------}
procedure TMainForm.AddNewMember;
var
 OKtoadd: Boolean;
begin
 OKtoadd:=false;
 if Length(members)=1 then OKtoadd:=true;
 if Length(members)>1 then
  if (members[Length(members)-1].Forename<>'')
  and(members[Length(members)-1].Surname<>'') then OKtoadd:=true;
 if OKtoadd then
 begin
  SetLength(members,Length(members)+1);
  SetLength(MembersList,Length(members));
  SetLength(members[Length(members)-1].Score,season.Num_categories);
  SetLength(members[Length(members)-1].Tally,season.Num_categories);
  AddMemberControl(Length(members)-1);
  RePopulateMembers;
 end;
end;

{-------------------------------------------------------------------------------
Updates all the comboboxes with up-to-date members details
-------------------------------------------------------------------------------}
procedure TMainForm.RePopulateMembers;
var
 cat,i: Integer;
begin
 for cat:=0 to Length(cbox_author)-1 do
  for i:=0 to Length(cbox_author[cat])-1 do
  begin
   PopulateComboBox(cbox_author[cat,i],MembersList);
   cbox_author[cat,i].ItemIndex:=photographs[panl_ID[cat,i].Tag].Author;
  end;
end;

{-------------------------------------------------------------------------------
Adds a new member
-------------------------------------------------------------------------------}
procedure TMainForm.AddMemberControl(member: Integer);
var
 x: Integer;
begin
 x:=Length(edit_surname);
 SetLength(edit_surname,x+1);
 SetLength(edit_forename,x+1);
 SetLength(edit_photocount,x+1);
 SetLength(SB_deletemember,x+1);
 edit_forename[x]:=CreateEdit(pnl_ForenameTitle.Left,
                              add_btn_src.Top,
                              pnl_ForenameTitle.Width,false,SB_MembersList);
 edit_forename[x].Text:=members[member].Forename;
 edit_forename[x].Tag:=member;
 edit_forename[x].OnExit:=@season_titleExit;
 edit_forename[x].OnKeyPress:=@EditorKeyPress;
 edit_surname[x]:=CreateEdit(pnl_SurnameTitle.Left,
                             add_btn_src.Top,
                             pnl_SurnameTitle.Left,false,SB_MembersList);
 edit_surname[x].Text:=members[member].Surname;
 edit_surname[x].Tag:=member;
 edit_surname[x].OnExit:=@season_titleExit;
 edit_surname[x].OnKeyPress:=@EditorKeyPress;
 members[member].Num_photos:=0;
 edit_photocount[x]:=CreateEdit(pnl_PhotosTitle.Left,
                                add_btn_src.Top,
                                pnl_PhotosTitle.Width,true,SB_MembersList);
 edit_photocount[x].Text:=IntToStr(members[member].Num_photos);
 edit_photocount[x].Tag:=member;
 MembersList[member]:=members[member].Forename+' '+members[member].Surname;
 SB_deletemember[x]:=CreateSpeedButton(edit_surname[x].Top,member,SB_MembersList);
 SB_deletemember[x].Left:=pnl_PhotosTitle.Left+pnl_PhotosTitle.Width;
 SB_deletemember[x].Glyph:=del_btn_src.Glyph;
 SB_deletemember[x].OnClick:=@DeleteMember;
 If members[member].Num_photos>0 then
  SB_deletemember[x].Enabled:=false
 else
  SB_deletemember[x].Enabled:=true;
 add_btn_src.Top:=edit_surname[x].Top+edit_surname[x].Height;
end;

{-------------------------------------------------------------------------------
Open the ESCC website in the clients web browser
-------------------------------------------------------------------------------}
procedure TMainForm.WebLinkBtnClick(Sender: TObject);
begin
 OpenURL(PChar('http://www.eastsutherlandcc.org.uk'));
end;

{-------------------------------------------------------------------------------
Count number of photographs per author
-------------------------------------------------------------------------------}
function TMainForm.CountPhotographs(member: Integer): Integer;
var
 i: Integer;
begin
 Result:=0;
 for i:=0 to Length(photographs)-1 do
  if  (photographs[i].Author=member)
  and (not photographs[i].Ignore) then inc(Result);
end;

{-------------------------------------------------------------------------------
Find author index by name
-------------------------------------------------------------------------------}
function TMainForm.FindAuthor(S: String): Integer;
 function ForenameFuzzyMatch(fname,fnames: String): Boolean;
     const names: array[0..29] of String  = (
     '|Alan|Al|Allan|',
     '|Alexander|Sandy|Sander|Xander|Alex|Ali|',
     '|Alexandra|Alex|Ali|',
     '|Andrew|Andy|Drew|',
     '|Ann|Anne|Annabel|Annabelle|',
     '|Ashley|Ash|',
     '|Contessa|Tessa|',
     '|David|Dave|Davie|',
     '|Deborah|Deb|Debs|Debbie|Debra|',
     '|Elizabeth|Beth|Liz|Lizzie|Lizzy|',
     '|Emma|Em|',
     '|Gerald|Ger|Gel|Gez|Gerry|Gerard|Gezza|',
     '|Graeme|Graham|',
     '|Jennifer|Jen|Jenn|Jenny|',
     '|John|Jon|Johnathon|Jonathon',
     '|Louise|Lou|',
     '|Malcolm|Malc|',
     '|Margaret|Marge|Maggy|Maggie|Mag|Mags|Peg|Peggy|',
     '|Nicolas|Nic|Nick|Nik|Nicky|',
     '|Nicola|Nic|Nick|Nik|Nicky|',
     '|Patrick|Pat|Paddy|',
     '|Peter|Pete|',
     '|Rebecca|Bec|Becca|Beccy|Becky|Beck|Becka|Rebeccah|',
     '|Richard|Rich|Dick|Ricky|Dicky|',
     '|Ronnie|Ronald|Ron|',
     '|Sally|Sal|',
     '|Sandra|Sandy|',
     '|Sean|Shawn|Shaun|',
     '|Stanley|Stan|',
     '|William|Bill|Billy|Will|Willy|Wm|');
 var
  i: Integer;
 begin
  Result:=fname=fnames; //Will return true if a direct match, and not listed above
  for i:=0 to Length(names)-1 do
  begin
   if  (Pos('|'+fname+'|',names[i],1)>0)
   and (Pos('|'+fnames+'|',names[i],1)>0) then Result:=True;
  end;
 end;
var
 i: Integer;
 fname,sname,
 fnames,snames: String;
begin
 Result:=0;
 for i:=0 to Length(MembersList)-1 do
  if MembersList[i]=S then Result:=i;
 if Result=0 then //Try and find a match with alternate spellings
 begin
  //Split search name into Surname and Forename
  fname:=LeftStr(S,Pos(' ',S,1)-1);
  sname:=Copy(S,Pos(' ',S,1)+1);
  for i:=0 to Length(MembersList)-1 do
  begin
   //Split member name into Surname and Forename
   fnames:=LeftStr(MembersList[i],Pos(' ',MembersList[i],1)-1);
   snames:=Copy(MembersList[i],Pos(' ',MembersList[i],1)+1);
   if  (ForenameFuzzyMatch(fname,fnames))
   AND (((Copy(sname,1,2)='Mc')  AND (Copy(snames,1,3)='Mac'))
   OR   ((Copy(sname,1,3)='Mac') AND (Copy(snames,1,2)='Mc'))
   OR   ((Copy(sname,1,1)='W')   AND (Copy(snames,1,2)='Wh'))
   OR   ((Copy(sname,1,2)='Wh')  AND (Copy(snames,1,1)='W'))) then Result:=i
  end;
 end;
end;

{-------------------------------------------------------------------------------
User is deleting a competition (button click)
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteCompetitionClick(Sender: TObject);
var
 btn: TSpeedButton;
 R,comp: Integer;
begin
 if Sender is TSpeedButton then
  if season.Num_competitions>2 then //Cannot have less than 2 competitions
  begin
   btn:=Sender as TSpeedButton;
   R:=CustomMessageDlg(
      'Delete just the photographs for "'+open_btn[btn.Tag].Caption+'" '+
      'or Delete the competition as well?'+#13#10+
      'WARNING: THIS CANNOT BE UNDONE',
      mtConfirmation,[mbYes,mbNo,mbCancel],
      ['Photographs only','Competition too','Cancel'],
      'Confirm',mbCancel);
   //Confirm
   if (R=mrYes) or (R=mrNo) then
    if CustomMessageDlg('Are you sure?'+#13#10+
                        'WARNING: THIS CANNOT BE UNDONE',
                        mtConfirmation,[mbYes,mbNo],
                        ['Yes, delete','No'],
                        'Confirm',mbNo)=mrNo then R:=mrCancel;
   comp:=btn.Tag;//Competition Number
   if (R=mrYes) or (R=mrNo) then
   begin
    //Is the competition open? Then close it
    if comp_title.Tag=comp then CloseCompetition;
    //Delete the photographs
    DeleteCompetitionPhotographs(comp);
    //Delete the competition also
    if R=mrNo then DeleteCompetition(comp);
    //Save the data, unless user clicked on Cancel
    SaveSeasonFile;
   end;
  end
  else ShowMessage('Cannot have less than 2 competitions in a season');
end;

{-------------------------------------------------------------------------------
Delete all the photographs in a competition
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteCompetitionPhotographs(comp: Integer);
var
 i: Integer;
begin
 //This only deletes the entries in the arrays, not the controls
 //Go through the entire list of photos
 for i:=0 to Length(photographs)-1 do
  if photographs[i].Competition=comp then
  begin
   //Mark the Competition and Category fields as -1 and they'll get ignored
   photographs[i].Competition:=-1;
   photographs[i].Category:=-1;
   //This will ensure that the author photo count is correct
   photographs[i].Author:=0;
  end;
 UpdatePhotoCount;
end;

{-------------------------------------------------------------------------------
Delete a competition (assuming that the photographs have been deleted)
-------------------------------------------------------------------------------}
procedure TMainForm.DeleteCompetition(comp: Integer);
var
 i,j: Integer;
begin
 for j:=comp+1 to season.Num_competitions-1 do
 begin
  //Take the competitions above and shift them down one
  for i:=0 to Length(photographs)-1 do
   if photographs[i].Competition=j then
    photographs[i].Competition:=j-1;
  //Move the text to the previous index in the array
  competitions[j-1]:=competitions[j];
  //Move the 'open competition' button texts to the previous one
  open_btn[j-1].Caption:=open_btn[j].Caption;
  open_btn[j-1].Hint:=open_btn[j].Hint;
  //Update the judging image
  ChangeJudgeType(competitions[j-1].Ext_judge,judge_img[j-1]);
  //Update the delete button
  delcomp_btn[j-1].Visible:=True;
  //Is one of those being moved open, if so, update the tag
  if comp_title.Tag=j then comp_title.Tag:=j-1;
 end;
 //Remove the final buttons (i.e. move the New Competition button up)
 open_btn[season.Num_competitions-1].Caption:=
                                      open_btn[season.Num_competitions].Caption;
 open_btn[season.Num_competitions-1].Hint:=
                                      open_btn[season.Num_competitions].Hint;
 open_btn[season.Num_competitions-1].Visible:=True;
 judge_img[season.Num_competitions-1].Picture:=pic_judge.Picture;
 judge_img[season.Num_competitions-1].Visible:=False;
 delcomp_btn[season.Num_competitions-1].Visible:=False;
 //Free all the controls
 judge_img[season.Num_competitions].Free;
 open_btn[season.Num_competitions].Free;
 delcomp_btn[season.Num_competitions].Free;
 //Contract the arrays
 SetLength(judge_img,Length(judge_img)-1);
 SetLength(delcomp_btn,Length(delcomp_btn)-1);
 SetLength(open_btn,Length(open_btn)-1);
 SetLength(competitions,season.Num_competitions-1);
 //Update the counter
 dec(season.Num_competitions);//:=season.Num_competitions-1;
end;

{-------------------------------------------------------------------------------
Sort competitions into order
-------------------------------------------------------------------------------}
procedure TMainForm.SortCompetitions(opening: Boolean);
var
 compcopy: TCompetitionArray; //Temporary storage for competitions
 sorted: array of Boolean;    //Flagging array
 tt: array of Integer;        //Translation table
 i,j,k,m: Integer;
begin
 //Make space for the temporary arrays
 SetLength(compcopy,Length(competitions));
 SetLength(sorted,Length(competitions));
 SetLength(tt,Length(competitions));
 //Reset the flagging array
 for i:=0 to Length(competitions)-1 do sorted[i]:=False;
 //Reset the counter
 k:=0;
 //Iterate through the months
 for i:=0 to 11 do
  //Iterate through the competitions, for every month
  for j:=0 to Length(competitions)-1 do
  begin
   //Work out the month number, based on the season start month
   m:=(((season.Start_Month-1)+i)mod 12);
   //If the competition is in this month
   if competitions[j].Month=m then
   begin
    //Copy it to the new array
    compcopy[k]:=competitions[j];
    //and mark the flag
    sorted[k]:=True;
    //Take a note of the old competition number
    tt[j]:=k;
    //Increase the counter
    inc(k);
   end;
  end;
 //Copy the photographs across
 for i:=0 to Length(photographs)-1 do
  photographs[i].Competition:=tt[photographs[i].Competition];
 //And the voting slips
 for i:=0 to Length(v_slips)-1 do
  v_slips[i].Competition:=tt[v_slips[i].Competition];
 //Copy the temporary array to the permananent one
 competitions:=compcopy;
 //If the competition is open, then change the tag
 if comp_title.Tag>-1 then comp_title.Tag:=tt[comp_title.Tag];
 //Now update the controls
 for i:=0 to Length(open_btn)-1 do
  if i<Length(competitions) then
  begin
   open_btn[i].Caption:=competitions[i].Title;
   ChangeJudgeType(competitions[i].Ext_judge,judge_img[i]);
  end;
 //And save the file
 if not opening then SaveSeasonFile;
end;

{-------------------------------------------------------------------------------
Sort competitions into order
-------------------------------------------------------------------------------}
function TMainForm.FormatTally(S: String): String;
var
 pos: Integer;
begin
 Result:='';
 for pos:=1 to season.m_Places_to_score do
  Result:=Result+'-'+
          IntToStr(StrToIntDef(Copy(S,(pos*2)+2,2),0));
 Result:=Copy(Result,2);
end;

{-------------------------------------------------------------------------------
Fill in the photo control details
-------------------------------------------------------------------------------}
procedure TMainForm.FillInPhotoControl(cat,y,x: Integer);
begin
 if comp_title.Tag>=0 then
 begin
  PopulateComboBox(cbox_author[cat,y-1],MembersList);
  panl_ID[cat,y-1].Caption      :=photographs[x].ID;
  edit_title[cat,y-1].Text      :=photographs[x].Title;
  cbox_author[cat,y-1].ItemIndex:=photographs[x].Author;
  if not photographs[x].Ignore then
  begin
   edit_score[cat,y-1].Text      :=IntToStr(photographs[x].Score);
   if competitions[comp_title.Tag].Ext_judge then
    edit_voting[cat,y-1].Text     :=photographs[x].Voting
   else
    edit_voting[cat,y-1].Text     :=FormatTally(photographs[x].Tally);
   edit_place[cat,y-1].Text      :=photographs[x].Position;
  end
  else
  begin
   edit_score[cat,y-1].Text      :='';
   edit_voting[cat,y-1].Text     :='';
   edit_place[cat,y-1].Text      :='';
  end;
  //Tag the control to tie them to the index in the photographs array
  panl_ID[cat,y-1].Tag          :=x;
  edit_title[cat,y-1].Tag       :=x;
  cbox_author[cat,y-1].Tag      :=x;
  edit_score[cat,y-1].Tag       :=x;
  edit_voting[cat,y-1].Tag      :=x;
  edit_place[cat,y-1].Tag       :=x;
  //Mark the empty title and author entries
  MarkEmptyPhotos(cat,y);
 end;
end;

{-------------------------------------------------------------------------------
Display the active voting graph
-------------------------------------------------------------------------------}
procedure TMainForm.DisplayActiveVoteGraph;
begin
 if not competitions[comp_title.Tag].Ext_judge then
  if VSlipsPerComp(comp_title.Tag)>0 then
   if cat_pages.ActivePageIndex<season.Num_categories then
   begin
    vote_graph_master.Picture:=vote_graph[cat_pages.ActivePageIndex].Picture;
    vote_graph_master.Width:=vote_graph[cat_pages.ActivePageIndex].Width;
    vote_graph_master.Height:=vote_graph[cat_pages.ActivePageIndex].Height;
    if PhotosPerCat(comp_title.Tag,cat_pages.ActivePageIndex)=0 then
     vote_graph_master.Visible:=False
    else
     vote_graph_master.Visible:=True;
   end
   else
    vote_graph_master.Visible:=False;
end;

{-------------------------------------------------------------------------------
Print some text to the printer, and move the cursor down
-------------------------------------------------------------------------------}
procedure TMainForm.PrintLine(S,lfont: String;size,x: Integer;style: TFontStyles);
var
 S2: String;
 tw: Integer;
 centre: Boolean;
begin
 S2:='';
 Printer.Canvas.Brush.Style:=bsClear;
 Printer.Canvas.Font.Name:=lfont;
 Printer.Canvas.Font.Size:=size;
 Printer.Canvas.Font.Style:=style;
 if x=-1 then centre:=True else centre:=False;
 tw:=Printer.Canvas.TextWidth(S);
 while tw>Printer.PageWidth-left_margin-right_margin do
 begin
  S2:=Copy(S,Length(S),1)+S2;
  S:=Copy(S,1,Length(S)-1);
  tw:=Printer.Canvas.TextWidth(S);
 end;
 if centre then x:=(Printer.PageWidth-Printer.Canvas.TextWidth(S))div 2;
 Printer.Canvas.TextOut(x,Printer.Canvas.PenPos.Y,S);
 Printer.Canvas.MoveTo(0,
             Round(Printer.Canvas.TextHeight(S)*1.5)+Printer.Canvas.PenPos.Y);
 if S2<>'' then
 begin
  tw:=Printer.Canvas.TextWidth(S2);
  while tw>Printer.PageWidth-left_margin-right_margin do
  begin
   S2:=Copy(S,1,Length(S)-1);
   tw:=Printer.Canvas.TextWidth(S2);
  end;
  if centre then x:=(Printer.PageWidth-Printer.Canvas.TextWidth(S2))div 2;
  Printer.Canvas.TextOut(x,Printer.Canvas.PenPos.Y,S2);
  Printer.Canvas.MoveTo(0,
             Round(Printer.Canvas.TextHeight(S2)*1.5)+Printer.Canvas.PenPos.Y);
 end;
end;

{-------------------------------------------------------------------------------
Prints the header to a page
-------------------------------------------------------------------------------}
procedure TMainForm.PrintHeader(title: String;cat: Integer);
begin
 Printer.Canvas.Draw(left_margin,top_margin,ESCCLogo.Picture.Graphic);
 Printer.Canvas.MoveTo(left_margin,top_margin);
 Printer.Canvas.Font.Color:=clBlue;
 PrintLine(season.Title+' season','Arial',24,-1,[fsBold]);
 PrintLine(title+' Results','Arial',20,-1,[fsBold]);
 PrintLine(categories[cat]+' Category','Arial',16,-1,[fsBold]);
 Printer.Canvas.Font.Color:=clBlack;
 Printer.Canvas.Pen.Color:=clRed;
 Printer.Canvas.MoveTo(left_margin,Printer.Canvas.PenPos.Y);
 Printer.Canvas.LineTo(Printer.PageWidth-right_margin,Printer.Canvas.PenPos.Y);
 Printer.Canvas.MoveTo(left_margin,Printer.Canvas.PenPos.Y+50);
end;

{-------------------------------------------------------------------------------
Prints the footer to a page
-------------------------------------------------------------------------------}
procedure TMainForm.PrintFooter;
begin
 Printer.Canvas.Pen.Color:=clRed;
 Printer.Canvas.MoveTo(left_margin,Printer.PageHeight-bottom_margin-342);
 Printer.Canvas.LineTo(Printer.PageWidth-right_margin,Printer.PageHeight-bottom_margin-342);
 PrintLine('ESCC Competitions version '+AppVersion+' written by Gerald J Holdsworth',
           'Arial',8,-1,[fsBold,fsItalic]);
 PrintLine('©2021 Gerald J Holdsworth and East Sutherland Camera Club',
           'Arial',8,-1,[fsBold,fsItalic]);
 PrintLine('http://www.eastsutherlandcc.org.uk',
           'Arial',8,-1,[fsBold,fsItalic]);
end;

{-------------------------------------------------------------------------------
Output Results
-------------------------------------------------------------------------------}
procedure TMainForm.OutputResults(output,results: Integer);
//Output
// 1: Display on form
// 2: Save to CSV file
// 3: Print
//Results
// 0: Monthly
// 1: PoTY
type
 Tmem_pos = Record
  Pos: Integer;
  equal: Boolean;
  Name: String;
  Score: Integer;
  Tally: String;
 end;
var
 photo,cat,comp,author,place,i,j,pos,h,k: Integer;
 S,P,e,title: String;
 page: TTabSheet;
 SB: TScrollBox;
 pm: array of Integer;
 ps: array of String;
 c: array of Boolean;
 equal,test: Boolean;
 labels: array of array of TLabel;
 buttons: array of array of TSpeedButton;
 mem_pos: array of array of Tmem_pos;
 F: TextFile;
begin
 SB:=nil;
 h:=0;
 //Set up detail selection form
 //Enable/Disable controls
 DetailSelectionForm.cb_ID.Enabled      :=results=0;
 DetailSelectionForm.cb_Title.Enabled   :=results=0;
 DetailSelectionForm.cb_Author.Enabled  :=results=0;
 DetailSelectionForm.cb_Position.Enabled:=results=0;
 DetailSelectionForm.cb_Tally.Enabled   :=True;
 DetailSelectionForm.rg_SortBy.Enabled  :=results=0;
 if (results=0) and (output>1) then
 begin
  //Printing or Saving monthly results
  DetailSelectionForm.cb_ID.Checked      :=def_ID;
  DetailSelectionForm.cb_Title.Checked   :=def_Title;
  DetailSelectionForm.cb_Author.Checked  :=def_author;
  DetailSelectionForm.cb_Position.Checked:=def_position;
  DetailSelectionForm.cb_Tally.Checked   :=def_tally_monthly;
  DetailSelectionForm.rg_SortBy.ItemIndex:=def_sortby;
 end;
 if (results=0) and (output=1) then
 begin
  //Display monthly results - all should be true
  DetailSelectionForm.cb_ID.Checked      :=True;
  DetailSelectionForm.cb_Title.Checked   :=True;
  DetailSelectionForm.cb_Author.Checked  :=True;
  DetailSelectionForm.cb_Position.Checked:=True;
  DetailSelectionForm.cb_Tally.Checked   :=True;
  DetailSelectionForm.rg_SortBy.ItemIndex:=0;
 end;
 DetailSelectionForm.up_Top.Enabled     :=(results=1);
 //                                      OR (DetailSelectionForm.cb_Position.Checked);
 DetailSelectionForm.ed_Top.Enabled     :=(results=1);
 //                                      OR (DetailSelectionForm.cb_Position.Checked);
 if (results=1) and (output>1) then //Print/Save POY results
 begin
  DetailSelectionForm.cb_Tally.Checked   :=def_tally_annual;
  DetailSelectionForm.up_Top.Position    :=def_topPOY;
 end;
 if (results=1) and (output=1) then //Display POY results
 begin
  DetailSelectionForm.cb_Tally.Checked   :=True;
  DetailSelectionForm.up_Top.Position    :=99;
 end;
 //Show Detail Selection Form
 if output>1 then
  DetailSelectionForm.ShowModal;
 if results=0 then //results=0 is monthly results
  RecalculateResults(comp_title.Tag);
 if results=1 then //results=1 is POY results
 begin
  //Blank the scores
  for author:=0 to Length(members)-1 do
   for cat:=0 to season.Num_categories-1 do
   begin
    members[author].Score[cat]:=0;
    members[author].Tally[cat]:=IntToPadStr(0,'0',season.a_Places_to_score*2);
   end;
  //Recalculate the results for all the competitions
  for i:=0 to season.Num_competitions-1 do
   RecalculateResults(i);
  //Go through each photograph and collate the position tallies.
  ProgressBar1.Max:=Length(photographs)-1;
  for photo:=0 to Length(photographs)-1 do
  if not photographs[photo].Ignore then
   begin
    author:=photographs[photo].Author; //Get the author
    comp:=photographs[photo].Competition;//Get the competition
    cat:=photographs[photo].Category;  //Get the category
    S:=photographs[photo].Position;    //Get the position
    if Copy(S,Length(S),1)='=' then
      S:=Copy(S,1,Length(S)-1);        //Remove the '='
    if S<>'' then                      //If photo was placed
    begin
     place:=StrToIntDef(S,1)-1;        //Convert to an integer
     if ((photographs[photo].Score>0)       //Only take note if score is >0
     and (not competitions[comp].Ext_Judge))//Or judged externally
     or (competitions[comp].Ext_judge) then
      if (place<season.a_Places_to_score) then //and within the places to score
      begin
       //Get the number of times placed at this position
       i:=StrToInt(Copy(members[author].Tally[cat],(place*2)+1,2));
       //Increase it
       inc(i);
       //Then put it back
       members[author].Tally[cat]:=Copy(members[author].Tally[cat],0,place*2)
                                  +IntToPadStr(i,'0',2)
                                  +Copy(members[author].Tally[cat],((place+1)*2)+1);
      end;
    end;
    ProgressBar1.Position:=photo;
    ProgressBar1.Update;
   end;
  //Go through each author and add up the scores from the tallies
  for author:=0 to Length(members)-1 do
   for cat:=0 to season.Num_categories-1 do
   begin
    //Reset the counter to zero
    photo:=0;
    //Go through the tally from 1 to season.a_Places_to_score
    for place:=1 to season.a_Places_to_score do
    begin
     //If the counter is <season.ScoreEntries then add in the score for that place
     if photo<season.ScoreEntries then
     begin
      //Get the number of times in that position
      S:=Copy(members[author].Tally[cat],((place-1)*2)+1,2);
      pos:=StrToIntDef(S,0); //As an integer
      if pos+photo>season.ScoreEntries then //Only count if it is under the threshold
       i:=season.ScoreEntries-photo         //Otherwise just count upto the threshold
      else i:=pos;
      //Add it to the score (no_times_at_pos * score_for_pos)
      inc(members[author].Score[cat],a_scoring[place-1]*i);
      //Increase the counter
      inc(photo,pos); //This is NOT the total number of submissions
     end;
    end;
   end;
 end;
 //Save the results
 SaveSeasonFile;
 //Set up the form/file/printer
 title:='';
 if results=0 then
  title:=competitions[comp_title.Tag].Title+' Competition';
 if results=1 then
  title:='Photographers of the Year';
 if output=1 then
 begin
  //First clear the form, should it already contain data
  For i:=0 to ResultsForm.pages.PageCount-1 do
   ResultsForm.pages.ActivePage.Free;
  //Then fill in the headers
  ResultsForm.Caption:=title+' Results';
  if results=0 then
   ResultsForm.header.Caption:=comp_title.Text+
                          ' ('+MonthList[competitions[comp_title.Tag].Month+1]+')';
  if results=1 then
   ResultsForm.header.Caption:=title;
  //Make room for the controls
  SetLength(labels,season.Num_categories);
  if results=0 then
   SetLength(buttons,season.Num_categories);
 end;
 if output=2 then
 begin
  //Create the file
  AssignFile(F,csv_Save.FileName);
  ReWrite(F);
 end;
 if output=3 then
 begin
  //Setup the printer
  Printer.Title:='ESCC Competitions '+title+' Results';
  Printer.Copies:=1;
  h:=Printer.PageHeight;
  Printer.BeginDoc;
 end;
 //This is a local copy of the members array, so we can re-sort it
 //And it's an array per category
 if results=1 then
  SetLength(mem_pos,season.Num_categories);
 ProgressBar1.Max:=season.Num_categories*100;
 ProgressBar1.Position:=0;
 ProgressBar1.Update;
 //Set up the form/file
 for cat:=0 to season.Num_categories-1 do
 begin
  ProgressBar1.Position:=cat*100;
  ProgressBar1.Update;
  if output=1 then //Display in a form
  begin
   //Create the page and scroll box
   page:=CreatePage(ResultsForm.pages,categories[cat]);
   SB:=CreateScrollBox(page);
   if results=1 then SetLength(labels[cat],length(members));
  end;
  if output=2 then //Save to a file
  begin
   if results=0 then
   begin
    //Write out the category name, and column headers
    WriteLn(F,'"'+categories[cat]+' Category"');
    S:='';
    if DetailSelectionForm.cb_Position.Checked then
     S:=S+'"Position",';
    if DetailSelectionForm.cb_Title.Checked then
     S:=S+'"Photo Title",';
    if DetailSelectionForm.cb_Author.Checked then
     S:=S+'"Photo Author",';
    if DetailSelectionForm.cb_ID.Checked then
     S:=S+'"Photo ID",';
    S:=S+'"Score"';
    if DetailSelectionForm.cb_Tally.Checked then
     if not competitions[comp_title.Tag].Ext_judge then
      for i:=0 to season.m_Places_to_score-1 do
       S:=S+',"'+IntToPos(i+1)+'s"';
   end;
   if results=1 then
   begin
    WriteLn(F,'"'+categories[cat]+' Category"');
    S:='"Position","Photographer","Score"';
    if DetailSelectionForm.cb_Tally.Checked then
     for i:=0 to season.a_Places_to_score-1 do
      S:=S+',"'+IntToPos(i+1)+'s"';
   end;
   WriteLn(F,S);
  end;
  //Print the header for each category
  if output=3 then
   PrintHeader(title,cat);
  //Sort the photographs into title order, if required
  if (results=0) and (DetailSelectionForm.rg_SortBy.ItemIndex=1) then
  begin
   //Clear the array
   SetLength(ps,0);
   for k:=0 to Length(photographs)-1 do
    //Find the relevant photographs
    if  (photographs[k].Competition=comp_title.Tag)
    and (photographs[k].Category=cat)
    and (not photographs[k].Ignore) then
    begin
     //and add them to the array
     SetLength(ps,Length(ps)+1);
     ps[Length(ps)-1]:=photographs[k].Title;
    end;
    //Then sort them into order
   if Length(ps)>0 then ArraySortA(ps);
  end;
  if results=1 then //Sort the members into position order, for POY results
  begin
   SetLength(mem_pos[cat],Length(members));
   //set up array for sorting
   SetLength(pm,Length(members));
   //Set up array for checking if sorted
   SetLength(c,Length(members));
   for i:=1 to Length(members)-1 do
   begin
    //copy the scores
    pm[i-1]:=members[i].Score[cat];
    //and reset the checks
    c[i-1]:=false;
   end;
   //Sort the scores
   ArraySort(pm);
   //and update the placings in the local members array
   place:=0;
   for author:=0 to Length(pm)-1 do
    for i:=1 to Length(members)-1 do
     if  (pm[author]=members[i].Score[cat])
     and (not c[i-1])
     and (members[i].Score[cat]>0) then
     begin
      mem_pos[cat,place].Pos:=author+1;
      mem_pos[cat,place].Name:=MembersList[i];
      mem_pos[cat,place].Score:=members[i].Score[cat];
      mem_pos[cat,place].Tally:=IntToPadStr(100-author,'0',3)+members[i].Tally[cat];
      c[i-1]:=true;
      inc(place);
     end;
   //Split the equal places
   SetLength(ps,Length(mem_pos[cat]));
   //And reset the checks
   SetLength(c,Length(mem_pos[cat]));
   for i:=0 to Length(ps)-1 do
   begin
    ps[i]:=mem_pos[cat,i].Tally;
    c[i]:=false;
   end;
   ArraySort(ps);
   for place:=0 to Length(ps)-1 do
   begin
    equal:=false;
    for author:=0 to Length(mem_pos[cat])-1 do
     if  (ps[place]=mem_pos[cat,author].Tally)
     and (not c[author]) then
     begin
      mem_pos[cat,author].Pos:=place+1;
      mem_pos[cat,author].equal:=equal;
      //This marks them as equal placed, plus the one before
      if (equal) and (author>0) then
       mem_pos[cat,author-1].equal:=equal;
      equal:=True;
      c[author]:=True;
     end;
   end;
  end;
  //Output the results
  i:=0; //Control number
  //position/author number
  pos:=1;
  if results=0 then
   case DetailSelectionForm.rg_SortBy.ItemIndex of
    0,2: pos:=0;
   end;
  place:=0;
  if results=0 then place:=Length(photographs)-1;
  if results=1 then
   if DetailSelectionForm.up_Top.Position>Length(mem_pos[cat]) then
    place:=Length(mem_pos[cat])-1
   else
    place:=DetailSelectionForm.up_Top.Position-1;
  repeat
   //We'll go through all the photos and find those relevant
   for j:=0 to place do
   begin
    test:=false;
    if results=0 then
     test:=(photographs[j].Competition=comp_title.Tag) and (photographs[j].Category=cat);
    if results=1 then
     test:=(mem_pos[cat,j].Pos=pos) and (mem_pos[cat,j].Score>0);
    if test then
    begin
     P:='100';
     if (results=0) and (DetailSelectionForm.cb_Position.Checked) then
     begin
      //then pick out those that are at position pos
      if not photographs[j].Ignore then P:=photographs[j].Position;
      if Copy(P,Length(P),1)='=' then
      begin
       P:=Copy(P,1,Length(P)-1);
       e:=IntToPos(StrToIntDef(P,0))+'=';
      end
      else e:=IntToPos(StrToIntDef(P,0));
     end;
     S:='';
     case DetailSelectionForm.rg_SortBy.ItemIndex of
      0:test:=(StrToIntDef(P,0)=pos) and (results=0);//Sorted by position (monthly)
      1:test:=(photographs[j].Title=ps[pos-1]) and (results=0);//Sorted by title (monthly)
      2:test:=(photographs[j].Author=pos) and (results=0);//Sorted by author (monthly)
     else
      test:=false;
     end;
     if (test) or (results=1) then
     begin
      if (results=0) and (not photographs[j].Ignore) then
      begin
       if (output=1) or (output=3) then
       begin
        if DetailSelectionForm.cb_Title.Checked then
         S:=S+'"'+photographs[j].Title+'"';
        if  (DetailSelectionForm.cb_Title.Checked)
        and (DetailSelectionForm.cb_Author.Checked) then
         S:=S+' by ';
        if DetailSelectionForm.cb_Author.Checked then
         S:=S+MembersList[photographs[j].Author];
        if DetailSelectionForm.cb_ID.Checked then
         S:=S+' ('+photographs[j].ID+')';
        S:=S+' scored '+IntToStr(photographs[j].Score)+' points';
       end;
       if output=2 then
        begin
         if DetailSelectionForm.cb_Title.Checked then
          S:=S+'"'+photographs[j].Title+'",';
         if DetailSelectionForm.cb_Author.Checked then
          S:=S+'"'+MembersList[photographs[j].Author]+'",';
         if DetailSelectionForm.cb_ID.Checked then
          S:=S+'"'+photographs[j].ID+'",';
         S:=S+'"'+IntToStr(photographs[j].Score)+'"';
        end;
       //Position Tallies
       if DetailSelectionForm.cb_Tally.Checked then
        if not competitions[comp_title.Tag].Ext_judge then
         if (output=2) or (output=3) then
          for k:=0 to season.m_places_to_score-1 do
          begin
           if output=2 then
            S:=S+',"'+Copy(photographs[j].Tally,(k*2)+1+3,2)+'"';
           if output=3 then
           begin
            if k>0 then S:=S+', ' else S:=S+' (';
            S:=S+IntToPos(k+1)+'s:'
                +IntToStr(StrToIntDef((Copy(photographs[j].Tally,(k*2)+1+3,2)),0));
            if k=season.m_Places_to_score-1 then S:=S+')';
           end;
          end;
       //Positions
       if DetailSelectionForm.cb_Position.Checked then
       begin
        if (output=1) or (output=3) then S:=e+':'+S;
        if output=2 then S:='"'+e+'",'+S;
       end;
      end;
      //Annual results
      if results=1 then
      begin
       if (output=1) or (output=3) then
       begin
        S:=IntToPos(pos);
        if mem_pos[cat,j].equal then S:=S+'=';
        S:=S+' '+mem_pos[cat,j].Name
            +' scored '+IntToStr(mem_pos[cat,j].Score)
            +' points';
        if DetailSelectionForm.cb_Tally.Checked then
         for k:=0 to season.a_Places_to_score-1 do
          S:=S+' '+IntToPos(k+1)+'s: '
              +IntToStr(StrToIntDef(Copy(mem_pos[cat,j].Tally,(k*2)+1+3,2),0));
       end;
       if output=2 then
       begin
        S:='"'+IntToPos(pos);
        if mem_pos[cat,j].equal then S:=S+'=';
        S:=S+'","'+mem_pos[cat,j].Name+'",'
            +'"'+IntToStr(mem_pos[cat,j].Score)+'"';
        if DetailSelectionForm.cb_Tally.Checked then
         for k:=0 to season.a_Places_to_score-1 do
          S:=S+',"'+Copy(mem_pos[cat,j].Tally,(k*2)+1+3,2)+'"';
       end;
       mem_pos[cat,j].Pos:=0;
      end;
      if output=1 then
      begin
       //Create the button, if required
       if results=0 then
        if not competitions[comp_title.Tag].Ext_judge then
        begin
         SetLength(buttons[cat],i+1);
         buttons[cat,i]:=CreateSpeedButton(i*20,j,SB);
         buttons[cat,i].Glyph:=ResultsForm.detail_results_btn.Glyph;
         buttons[cat,i].OnClick:=@ShowTally;
        end;
       //Create the label and increase the counter
       SetLength(labels[cat],i+1);
       labels[cat,i]:=CreateLabel(S,20,i*20,SB);
      end;
      if output=2 then
       WriteLn(F,S);
      if output=3 then
      begin
       PrintLine(S,'Arial',10,left_margin,[]);
       if Printer.Canvas.PenPos.Y>h-bottom_margin-442 then
       begin
        PrintFooter;
        Printer.NewPage;
        PrintHeader(title,cat);
       end;
      end;
      inc(i);
     end;
    end;
   end;
   inc(pos);
   //continue until we have all our places (which could be more than what is expected)
   test:=false;
   if results=0 then
   begin
    if output=1 then
    begin
     test:=pos>=season.m_Places_to_score+1;
     ProgressBar1.Position:=Round((pos/season.m_Places_to_score)*100)+(cat*100);
    end
    else
    begin
     test:=i>=Length(panl_ID[cat]);
     ProgressBar1.Position:=Round((i/Length(panl_ID[cat]))*100)+(cat*100);
    end;
   end;
   if results=1 then
   begin
    test:=pos=Length(mem_pos[cat]);
    ProgressBar1.Position:=Round((pos/Length(mem_pos[cat]))*100)+(cat*100);
   end;
   ProgressBar1.Update;
  until test;
  //End of category, so start a new page (if not on the last)
  if output=3 then
  begin
   PrintFooter;
   if cat<season.Num_categories-1 then Printer.NewPage;
  end;
 end;
 //Reset the progress bar
 ProgressBar1.Position:=0;
 ProgressBar1.Update;
 //Show the form or close down the file/print job
 if output=1 then
 begin
  ResultsForm.ShowModal;
  for i:=0 to ResultsForm.pages.PageCount-1 do
   ResultsForm.pages.ActivePage.Free;
 end;
 if output=2 then CloseFile(F);
 if output=3 then Printer.EndDoc;
end;

end.
