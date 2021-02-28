unit AboutUnit;

{$MODE objfpc}{$H+}

interface

uses Forms,StdCtrls,ExtCtrls,Controls;

type
  TAboutForm = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    procedure FormClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

uses MainUnit;

procedure TAboutForm.FormClick(Sender: TObject);
begin
 ModalResult:=mrOK;
end;

procedure TAboutForm.Label3Click(Sender: TObject);
begin
 MainForm.WebLinkBtnClick(Sender);
 FormClick(Sender);
end;

end.
 
