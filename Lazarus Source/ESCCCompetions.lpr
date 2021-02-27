program ESCCCompetions;

{$MODE Delphi}

uses
  Forms, Interfaces,
  MainUnit in 'MainUnit.pas' {MainForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  VotingUnit in 'VotingUnit.pas' {VotingForm},
  SeasonDetailUnit in 'SeasonDetailUnit.pas' {SeasonDetailForm},
  ResultsUnit in 'ResultsUnit.pas' {ResultsForm},
  Global in 'Global.pas',
  ImportUnit in 'ImportUnit.pas' {ImportForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm},
  DetailSelectionUnit in 'DetailSelectionUnit.pas' {DetailSelectionForm},
  ImportOnlineUnit in 'ImportOnlineUnit.pas' {ImportOnlineForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ESCC Competitions';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TVotingForm, VotingForm);
  Application.CreateForm(TSeasonDetailForm, SeasonDetailForm);
  Application.CreateForm(TResultsForm, ResultsForm);
  Application.CreateForm(TImportForm, ImportForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TDetailSelectionForm, DetailSelectionForm);
  Application.CreateForm(TImportOnlineForm, ImportOnlineForm);
  Application.Run;
end.
