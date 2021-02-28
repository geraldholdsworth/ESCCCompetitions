unit SeasonDetailUnit;

interface

uses
  SysUtils,Forms,ComCtrls,StdCtrls,ExtCtrls,Buttons,Global,Controls,Classes,
  Dialogs;

type
  TSeasonDetailForm = class(TForm)
    Panel1: TPanel;
    season_title: TEdit;
    PageControl1: TPageControl;
    ann_comp_tab: TTabSheet;
    Label1: TLabel;
    ud_a_num_score: TUpDown;
    ed_a_num_score: TEdit;
    mon_comp_tab: TTabSheet;
    ud_m_num_score: TUpDown;
    ed_m_num_score: TEdit;
    Label2: TLabel;
    ud_num_comps: TUpDown;
    ed_num_comps: TEdit;
    Label3: TLabel;
    category_tab: TTabSheet;
    sb_a_num_places: TScrollBox;
    a_pos_pan: TPanel;
    a_sco_pan: TPanel;
    Panel2: TPanel;
    CreateBtn: TBitBtn;
    CancelBtn: TBitBtn;
    sb_m_num_places: TScrollBox;
    m_pos_pan: TPanel;
    m_sco_pan: TPanel;
    sb_num_comps: TScrollBox;
    comp_mon_pan: TPanel;
    comp_tit_pan: TPanel;
    external_pan: TPanel;
    sb_num_cats: TScrollBox;
    Label4: TLabel;
    ed_num_cats: TEdit;
    ud_num_cats: TUpDown;
    SaveAsDefault: TBitBtn;
    Panel3: TPanel;
    Label5: TLabel;
    cb_start_month: TComboBox;
    Label6: TLabel;
    ed_a_comp_entries: TEdit;
    ud_a_comp_entries: TUpDown;
    AutoFillBtn: TBitBtn;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    rb_total_a: TRadioButton;
    rb_average_a: TRadioButton;
    rb_average_m: TRadioButton;
    rb_total_m: TRadioButton;
    ud_score_entries: TUpDown;
    ed_score_entries: TEdit;
    Label7: TLabel;
    cb_splitequal: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ShowHideControls(h: Integer;var panels: array of TPanel;
      var edits: array of TEdit); overload;
    procedure ud_a_num_scoreChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
    procedure FormShow(Sender: TObject);
    procedure SaveAsDefaultClick(Sender: TObject);
    procedure AutoFillBtnClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    procedure ShowHideControls(h: Integer;var panels: array of TComboBox;
      var edits: array of TEdit); overload;
    procedure ShowHideControls(h: Integer;var panels: array of TEdit); overload;
  public
    a_scoring_pos: array[1..100] of TPanel;
    m_scoring_pos: array[1..9]   of TPanel;
    a_scoring_sco: array[1..100] of TEdit;
    m_scoring_sco: array[1..9]   of TEdit;
    cats:          array[1..6]   of TEdit;
    comps_month:   array[1..12]  of TComboBox;
    comps_title:   array[1..12]  of TEdit;
    comps_ext:     array[1..12]  of TCheckBox;
    existing:      Boolean;
  end;

var
  SeasonDetailForm: TSeasonDetailForm;

implementation

uses MainUnit;

{$R *.dfm}

{-------------------------------------------------------------------------------
Save as Default settings
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.SaveAsDefaultClick(Sender: TObject);
var
 i: Integer;
begin
 //First reset the arrays
 SetLength(def_categories,0);
 SetLength(def_a_scores,0);
 SetLength(def_m_scores,0);
 //Get the values from the form, into the default variables
 def_num_categories   :=ud_num_cats.Position;
 SetLength(def_categories,def_num_categories+1);
 for i:=1 to def_num_categories do
  def_categories[i]   :=cats[i].Text;
 def_a_places_to_score:=ud_a_num_score.Position;
 SetLength(def_a_scores,def_a_places_to_score+1);
 for i:=1 to def_a_places_to_score do
  def_a_scores[i]     :=StrToIntDef(a_scoring_sco[i].Text,0);
 def_m_places_to_score:=ud_m_num_score.Position;
 SetLength(def_m_scores,def_m_places_to_score+1);
 for i:=1 to def_m_places_to_score do
  def_m_scores[i]     :=StrToIntDef(m_scoring_sco[i].Text,0);
 def_num_competitions :=def_num_competitions;
 def_start_month      :=cb_start_month.ItemIndex+1;
 def_inc_entries      :=ud_a_comp_entries.Position;
 def_score_entries    :=ud_score_entries.Position;
 def_scoretotalm      :=rb_total_m.Checked;
 def_scoretotala      :=rb_total_a.Checked;
 def_splitequal       :=cb_splitequal.Checked;
 //Now save to the registry
 SetRegValI('Num_categories',def_num_categories);
 for i:=1 to def_num_categories do
  SetRegValS('Categories\'+IntToStr(i),def_categories[i]);
 SetRegValI('A_places_to_score',  def_a_places_to_score);
 SetRegValA('Annual Scores',      def_a_scores);
 SetRegValI('M_places_to_score',  def_m_places_to_score);
 SetRegValA('Monthly Scores',     def_m_scores);
 SetRegValI('Num_competitions',   def_num_competitions);
 SetRegValI('Start_Month',        def_start_month);
 SetRegValI('Included_Entries',   def_inc_entries);
 SetRegValI('Scored_Entries',     def_score_entries);
 SetRegValB('Score_Total_Monthly',def_scoretotalm);
 SetRegValB('Score_Total_POY',    def_scoretotala);
 SetRegValB('SplitEquals',        def_splitequal);
 //And report to the user
 ShowMessage('New default settings saved to the registry');
 ModalResult:=mrCancel;
end;

{-------------------------------------------------------------------------------
Autofill placings - calculates scores based on number of placings
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.AutoFillBtnClick(Sender: TObject);
var
 i: Integer;
begin
 //Points awarded towards Photographer of the Year
 if PageControl1.ActivePage=ann_comp_tab then
 for i:=1 to ud_a_num_score.Position do
  a_scoring_sco[i].Text:=IntToStr((ud_a_num_score.Position-i)+1);
 //Points awarded for Monthly Competition
 if PageControl1.ActivePage=mon_comp_tab then
 for i:=1 to ud_m_num_score.Position do
  m_scoring_sco[i].Text:=IntToStr((ud_m_num_score.Position-i)+1);
end;

{-------------------------------------------------------------------------------
Create Form - creates all the controls, even if most are not used
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.FormCreate(Sender: TObject);
var
 i: Integer;
begin
 //Create controls for Annual Scoring
 for i:=1 to High(a_scoring_pos) do
 begin
  a_scoring_pos[i]:=CreatePanel(IntToPos(i),
                                a_pos_pan.Left,
                                20*i,
                                a_pos_pan.Width,sb_a_num_places);
  a_scoring_pos[i].Height:=20;
  a_scoring_sco[i]:=CreateEdit(a_sco_pan.Left,
                               20*i,
                               a_sco_pan.Width,
                               false,sb_a_num_places);
  a_scoring_pos[i].Visible:=false;
  a_scoring_sco[i].Visible:=false;
 end;
 ud_a_num_score.Max:=High(a_scoring_pos);
 //Create controls for Manual Scoring
 for i:=1 to High(m_scoring_pos) do
 begin
  m_scoring_pos[i]:=CreatePanel(IntToPos(i),
                                m_pos_pan.Left,
                                20*i,
                                m_pos_pan.Width,sb_m_num_places);
  m_scoring_pos[i].Height:=20;
  m_scoring_sco[i]:=CreateEdit(m_sco_pan.Left,
                               20*i,
                               m_sco_pan.Width,
                               false,sb_m_num_places);
  m_scoring_pos[i].Visible:=false;
  m_scoring_sco[i].Visible:=false;
 end;
 ud_m_num_score.Max:=High(m_scoring_pos);
 //Create controls for Number of Competitions
 for i:=1 to High(comps_month) do
 begin
  comps_month[i]:=CreateComboBox(comp_mon_pan.Left,
                                 20*i,
                                 comp_mon_pan.Width,sb_num_comps);
  comps_month[i].Height:=20;
  MainForm.PopulateComboBox(comps_month[i],MonthList);
  //Remove 'Annual' from the selection
  comps_month[i].Items.Delete(12);
  comps_month[i].ItemIndex:=0;
  comps_month[i].Visible:=false;
  comps_title[i]:=CreateEdit(comp_tit_pan.Left,
                             20*i,
                             comp_tit_pan.Width,
                             false,sb_num_comps);
  comps_title[i].Height:=20;
  comps_title[i].Text:='';
  comps_title[i].Visible:=false;
  comps_ext[i]:=CreateCheckBox(external_pan.Left+((external_pan.Width-17)div 2),
                               20*i,sb_num_comps);
  comps_ext[i].Visible:=false;
 end;
 //Create controls for Categories
 for i:=1 to High(cats) do
 begin
  cats[i]:=CreateEdit(0,20*(i-1),sb_num_cats.Width-22,false,sb_num_cats);
  cats[i].Height:=20;
  cats[i].Visible:=false;
 end;
 existing:=False;
 //Populate Season Start Month combo box
 for i:=1 to 12 do cb_start_month.Items.Add(MonthList[i]);
end;

{-------------------------------------------------------------------------------
Show/Hide Controls
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.ShowHideControls(h: Integer;var panels: array of TPanel;
 var edits: array of TEdit) overload;
var
 i: Integer;
 v: Boolean;
begin
 for i:=Low(panels) to High(panels) do
 begin
  if i<h then v:=true else v:=false;
  panels[i].Visible:=v;
  edits[i].Visible:=v;
 end;
end;
procedure TSeasonDetailForm.ShowHideControls(h: Integer;var panels: array of TComboBox;
 var edits: array of TEdit) overload;
var
 i: Integer;
 v: Boolean;
begin
 for i:=Low(panels) to High(panels) do
 begin
  if i<h then v:=true else v:=false;
  panels[i].Visible:=v;
  edits[i].Visible:=v;
  comps_ext[i+1].Visible:=v;
 end;
end;
procedure TSeasonDetailForm.ShowHideControls(h: Integer;var panels: array of TEdit) overload;
var
 i: Integer;
begin
 for i:=Low(panels) to High(panels) do
  if i<h then panels[i].Visible:=true else panels[i].Visible:=false;
end;

{-------------------------------------------------------------------------------
Initialise Form
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.FormShow(Sender: TObject);
var
 i: Integer;
begin
 //Season Title
 if existing then
  season_title.Text:=MainForm.season.Title
 else
  season_title.Text:='Season';
 //Start month for season...need to set this parameter for calculations later on
 if not existing then
  MainForm.season.Start_Month:=def_start_month;
 cb_start_month.ItemIndex:=MainForm.season.Start_Month-1;
 //Number of entries to include in annual competition
 if existing then
  ud_a_comp_entries.Position:=MainForm.season.IncEntries
 else
  ud_a_comp_entries.Position:=def_inc_entries;
 //Split the Equal places?
 if existing then
  cb_splitequal.Checked:=MainForm.season.SplitEqual
 else
  cb_splitequal.Checked:=def_splitequal;
 //Annual Scoring Setup
 if existing then
 begin //Places to score and total/average
  ud_a_num_score.Position:=MainForm.season.a_Places_to_score;
  rb_total_a.Checked:=MainForm.season.ScoreTotala;
 end
 else
 begin
  ud_a_num_score.Position:=def_a_places_to_score;
  rb_total_a.Checked:=def_scoretotala;
 end;
 rb_average_a.Checked:=not rb_total_a.Checked;
 //Fill in the scoring system
 for i:=1 to High(a_scoring_pos) do
 begin
  a_scoring_sco[i].Text:='0';
  if i<=ud_a_num_score.Position then
   if existing then
    a_scoring_sco[i].Text:=IntToStr(MainForm.a_scoring[i-1])
   else
    a_scoring_sco[i].Text:=IntToStr(def_a_scores[i]);
 end;
 //Best Of X
 if existing then
  ud_score_entries.Position:=MainForm.season.ScoreEntries
 else
  ud_score_entries.Position:=def_score_entries;
 ShowHideControls(ud_a_num_score.Position,a_scoring_pos,a_scoring_sco);
 //Monthly Scoring Setup
 if existing then
 begin //Places to score and total/average
  ud_m_num_score.Position:=MainForm.season.m_Places_to_score;
  rb_total_m.Checked:=MainForm.season.ScoreTotalm;
 end
 else
 begin
  ud_m_num_score.Position:=def_m_places_to_score;
  rb_total_m.Checked:=def_scoretotalm;
 end;
 rb_average_m.Checked:=not rb_total_m.Checked;
 //Fill in the scoring system
 for i:=1 to High(m_scoring_pos) do
 begin
  m_scoring_sco[i].Text:='0';
  if i<=ud_m_num_score.Position then
   if existing then
    m_scoring_sco[i].Text:=IntToStr(MainForm.m_scoring[i-1])
   else
    m_scoring_sco[i].Text:=IntToStr(def_m_scores[i]);
 end;
 ShowHideControls(ud_m_num_score.Position,m_scoring_pos,m_scoring_sco);
 //Competition Titles
 if existing then
  ud_num_comps.Position:=MainForm.season.Num_competitions
 else
  ud_num_comps.Position:=def_num_competitions;
 for i:=1 to High(comps_month) do
 begin
  comps_month[i].ItemIndex:=GetMonthNumber(i);
  comps_title[i].Text:='Competition '+IntToStr(i);
  comps_ext[i].Checked:=false;
  if i<=ud_num_comps.Position then
   if existing then
   begin
    comps_month[i].ItemIndex:=MainForm.competitions[i-1].Month;
    comps_title[i].Text:=MainForm.competitions[i-1].Title;
    comps_ext[i].Checked:=MainForm.competitions[i-1].Ext_judge;
   end;
 end;
 ShowHideControls(ud_num_comps.Position,comps_month,comps_title);
 //Categories
 if existing then
  ud_num_cats.Position:=MainForm.season.Num_categories
 else
  ud_num_cats.Position:=def_num_categories;
 for i:=1 to High(cats) do
 begin
  cats[i].Text:='New Category';
  if i<=ud_num_cats.Position then
   if existing then
    cats[i].Text:=MainForm.categories[i-1]
   else
    cats[i].Text:=def_categories[i]
  else
   if i<=Length(c_def_categories) then
    cats[i].Text:=c_def_categories[i];
 end;
 ShowHideControls(ud_num_cats.Position,cats);
 //Sheet user sees when opening
 PageControl1.ActivePage:=ann_comp_tab;
 AutoFillBtn.Enabled:=True;
 //Control has focus at start
 season_title.SetFocus;
 //Whether user can save as default settings
 SaveAsDefault.Enabled:=not existing;
 //Change the 'Create' button text to reflect the action
 if existing then CreateBtn.Caption:='Update' else CreateBtn.Caption:='Create';
end;

{-------------------------------------------------------------------------------
Enable/Disable autofill button
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.PageControl1Change(Sender: TObject);
begin
 if PageControl1.ActivePageIndex<2 then
  AutoFillBtn.Enabled:=True
 else
  AutoFillBtn.Enabled:=False;
end;

{-------------------------------------------------------------------------------
Up/Down control is changing
-------------------------------------------------------------------------------}
procedure TSeasonDetailForm.ud_a_num_scoreChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
var
 c: TUpDown;
begin
 if Sender is TUpDown then
 begin
  c:=Sender as TUpDown;
  if (NewValue>=c.Min)
  and (NewValue<=c.Max) then
  begin
   if c.Tag=1 then ShowHideControls(NewValue,a_scoring_pos,a_scoring_sco);
   if c.Tag=2 then ShowHideControls(NewValue,m_scoring_pos,m_scoring_sco);
   if c.Tag=3 then ShowHideControls(NewValue,comps_month,comps_title);
   if c.Tag=4 then ShowHideControls(NewValue,cats);
  end;
 end;
end;

end.
