unit DetailSelectionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TDetailSelectionForm = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    cb_ID: TCheckBox;
    cb_Title: TCheckBox;
    cb_Author: TCheckBox;
    cb_Position: TCheckBox;
    cb_Tally: TCheckBox;
    rg_SortBy: TRadioGroup;
    Panel1: TPanel;
    OKbtn: TBitBtn;
    GroupBox2: TGroupBox;
    cb_Tabulate: TCheckBox;
    ed_Top: TEdit;
    up_Top: TUpDown;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DetailSelectionForm: TDetailSelectionForm;

implementation

{$R *.dfm}

end.
