unit ImportOnlineUnit;

{$MODE Delphi}

interface

{uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons;}

type
  TImportOnlineForm = class(TForm)
    http_escc: TIdHTTP;
    CompList: TTreeView;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lb_seasonname: TLabel;
    lb_compname: TLabel;
    lb_numvotes: TLabel;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CompListClick(Sender: TObject);
    function GetString(request: String): String;
    function GetInteger(request: String): Integer;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    SelectedCompetition: Integer;
    SelectedSeason     : Integer;
    Categories         : array of String;
    Photographs        : array of array of String;
    Authors            : array of array of String;
    VoteSlips          : array of String;
  end;

const
 website='http://www.eastsutherlandcc.org.uk/onlinecomps.php';

var
  ImportOnlineForm: TImportOnlineForm;

implementation

{$R *.lfm}

procedure TImportOnlineForm.CompListClick(Sender: TObject);
var
 Node   : TTreeNode;
 comp,
 season,
 votes  : Integer;
begin
 Node:=CompList.Selected;
 SpeedButton1.Enabled:=False;
 if Node<>nil then
 begin
  lb_seasonname.Caption:='';
  lb_compname.Caption  :='';
  lb_numvotes.Caption  :='';
  if Node.Level=1 then
  begin
   lb_seasonname.Caption:=Node.Parent.Text;
   lb_compname.Caption  :=Node.Text;
   comp:=Node.Index;
   season:=Node.Parent.Index;
   votes:=GetInteger('request=no_votes'+
                     '&comp_no='+IntToStr(comp)+
                     '&season_no='+IntToStr(season));
   lb_numvotes.Caption:=IntToStr(votes);
   //Can only import if there are some votes
   if votes>0 then
   begin
    SpeedButton1.Enabled:=True;
    SelectedCompetition:=comp;
    SelectedSeason:=season;
   end;
  end;
 end;
end;

procedure TImportOnlineForm.FormShow(Sender: TObject);
var
 season,
 comp,
 numseasons,
 numcomps   : Integer;
 Node       : TTreeNode;
begin
 SpeedButton1.Enabled:=False;
 //Clear the list
 CompList.Items.Clear;
 lb_seasonname.Caption:='';
 lb_compname.Caption  :='';
 lb_numvotes.Caption  :='';
 Screen.Cursor:=crHourGlass;
 Application.ProcessMessages;
 //First, find out how many seasons
 numseasons:=GetInteger('request=no_seasons');
 //If there are any seasons
 if numseasons>0 then
 begin
  //Iterate through them
  for season:=0 to numseasons-1 do
  begin
   //Get the season names
   Node:=CompList.Items.AddChild(nil,GetString('request=season_name'+
                                               '&season_no='+IntToStr(season)));
   //How many online competitions for this season?
   numcomps:=GetInteger('request=no_comps'+
                        '&season_no='+IntToStr(season));
   //If more than one
   if numcomps>0 then
   begin
    //Iterate through them
    for comp:=0 to numcomps-1 do
     CompList.Items.AddChild(Node,GetString('request=comp_name'+
                                            '&comp_no='+IntToStr(comp)+
                                            '&season_no='+IntToStr(season)));
   end;
  end;
 end;
 Screen.Cursor:=crDefault;
end;

function TImportOnlineForm.GetString(request: String): String;
begin
 Result:=http_escc.Get(website+'?'+request);
end;

function TImportOnlineForm.GetInteger(request: String): Integer;
begin
 Result:=StrToIntDef(GetString(request),0);
end;

procedure TImportOnlineForm.SpeedButton1Click(Sender: TObject);
var
 num_cats,
 cat,
 num_photos,
 photo,
 num_votes,
 vote       : Integer;
begin
 Screen.Cursor:=crHourGlass;
 Application.ProcessMessages;
 //Reset the arrays
 SetLength(Categories,0);
 SetLength(Photographs,0);
 SetLength(Authors,0);
 SetLength(VoteSlips,0);
 //Fill the array with the category details
 //Get the number of categories
 num_cats:=GetInteger('request=no_cats'+
                      '&season_no='+IntToStr(SelectedSeason)+
                      '&comp_no='+IntToStr(SelectedCompetition));
 //Get the category names
 if num_cats>0 then
 begin
  //Set up the arrays
  SetLength(Categories,num_cats);
  SetLength(Photographs,num_cats);
  SetLength(Authors,num_cats);
  //Get the category names
  for cat:=0 to num_cats-1 do
  begin
   Categories[cat]:=GetString('request=cat_name'+
                              '&cat_no='+IntToStr(cat)+
                              '&season_no='+IntToStr(SelectedSeason)+
                              '&comp_no='+IntToStr(SelectedCompetition));
   //Fill the array with the photo details
   num_photos:=GetInteger('request=no_photos'+
                          '&cat_no='+IntToStr(cat)+
                          '&season_no='+IntToStr(SelectedSeason)+
                          '&comp_no='+IntToStr(SelectedCompetition));
   SetLength(Photographs[cat],num_photos);
   //Fill the array with the author details
   SetLength(Authors[cat],num_photos);
   if num_photos>0 then
    for photo:=0 to num_photos-1 do
    begin
     Photographs[cat,photo]:=
                           GetString('request=photo_title'+
                                     '&photo_no='+IntToStr(photo)+
                                     '&cat_no='+IntToStr(cat)+
                                     '&season_no='+IntToStr(SelectedSeason)+
                                     '&comp_no='+IntToStr(SelectedCompetition));
     Authors[cat,photo]:=GetString('request=author'+
                                   '&photo_no='+IntToStr(photo)+
                                   '&cat_no='+IntToStr(cat)+
                                   '&season_no='+IntToStr(SelectedSeason)+
                                   '&comp_no='+IntToStr(SelectedCompetition));
    end;
  end;
  //Fill the array with the voting details
  num_votes:=GetInteger('request=no_votes'+
                        '&season_no='+IntToStr(SelectedSeason)+
                        '&comp_no='+IntToStr(SelectedCompetition));
  if num_votes>0 then
  begin
   SetLength(VoteSlips,num_votes);
   for vote:=0 to num_votes-1 do
    VoteSlips[vote]:=GetString('request=vote'+
                               '&vote_no='+IntToStr(vote)+
                               '&season_no='+IntToStr(SelectedSeason)+
                               '&comp_no='+IntToStr(SelectedCompetition));
  end;
 end;
 //Close the form
 Screen.Cursor:=crDefault;
 ModalResult:=mrOK;
end;

procedure TImportOnlineForm.SpeedButton2Click(Sender: TObject);
begin
 ModalResult:=mrCancel;
end;

end.
