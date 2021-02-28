unit DetailSelectionUnit;

{$MODE objfpc}{$H+}

interface

uses
  SysUtils,Classes,Graphics,Controls,Forms,StdCtrls,Buttons,ExtCtrls,ComCtrls;

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

{$R *.lfm}

end.
