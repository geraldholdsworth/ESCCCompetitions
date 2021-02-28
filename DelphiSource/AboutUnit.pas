unit AboutUnit;

interface

uses Forms,StdCtrls,ExtCtrls,jpeg,Controls,Classes,Vcl.Imaging.pngimage,ShellApi,
Dialogs,SysUtils;

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

{$R *.dfm}

uses MainUnit,Global;

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
 
