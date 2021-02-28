unit ResultsUnit;

{$MODE objfpc}{$H+}

interface

uses
  Controls,Forms,Buttons,ComCtrls,ExtCtrls,Classes;

type
  TResultsForm = class(TForm)
    header: TPanel;
    pages: TPageControl;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    detail_results_btn: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultsForm: TResultsForm;

implementation

{$R *.lfm}

procedure TResultsForm.BitBtn1Click(Sender: TObject);
begin
 ModalResult:=mrOK;
end;

end.
