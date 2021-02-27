unit SettingsUnit;

{$MODE Delphi}

interface

uses
  {Winapi.Windows,Winapi.Messages,System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics,Vcl.Controls,Vcl.Forms,Vcl.Dialogs,}Global{, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls};

type
  TSettingsForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    cb_ID: TCheckBox;
    cb_Title: TCheckBox;
    cb_Author: TCheckBox;
    cb_Position: TCheckBox;
    cb_Tally_m: TCheckBox;
    cb_Tally_a: TCheckBox;
    rg_SortBy: TRadioGroup;
    GroupBox2: TGroupBox;
    cb_Tabulate_m: TCheckBox;
    cb_Tabulate_a: TCheckBox;
    ud_Top_a: TUpDown;
    ed_Top_a: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.lfm}

{-------------------------------------------------------------------------------
Create the form
-------------------------------------------------------------------------------}
procedure TSettingsForm.FormCreate(Sender: TObject);
begin
 //Extract/create the registry settings
 def_ID           :=GetRegValB('Print_ID',           c_def_ID);
 def_title        :=GetRegValB('Print_Title',        c_def_title);
 def_author       :=GetRegValB('Print_Author',       c_def_author);
 def_position     :=GetRegValB('Print_Position',     c_def_position);
 def_tally_monthly:=GetRegValB('Print_Tally_Monthly',c_def_tally_monthly);
 def_tally_annual :=GetRegValB('Print_Tally_Annual', c_def_tally_annual);
 def_tabulate_m   :=GetRegValB('Tabulate_Monthly',   c_def_tabulate_m);
 def_tabulate_a   :=GetRegValB('Tabulate_POY',       c_def_tabulate_a);
 def_sortby       :=GetRegValI('SortBy',             c_def_sortby);
 def_topPOY       :=GetRegValI('Top_POY',            c_def_topPOY);
end;

{-------------------------------------------------------------------------------
Show the form
-------------------------------------------------------------------------------}
procedure TSettingsForm.FormShow(Sender: TObject);
begin
 //Set the tick boxes
 cb_ID.Checked      :=def_ID;
 cb_Title.Checked   :=def_Title;
 cb_Author.Checked  :=def_author;
 cb_Position.Checked:=def_position;
 cb_Tally_m.Checked :=def_tally_monthly;
 cb_Tally_a.Checked :=def_tally_annual;
 rg_SortBy.ItemIndex:=def_sortby;
 ud_Top_a.Position  :=def_topPOY;
end;

{-------------------------------------------------------------------------------
OK has been clicked
-------------------------------------------------------------------------------}
procedure TSettingsForm.BitBtn1Click(Sender: TObject);
begin
 //Get the tick box values and store them
 def_ID:=           cb_ID.Checked;
 def_Title:=        cb_Title.Checked;
 def_author:=       cb_Author.Checked;
 def_position:=     cb_Position.Checked;
 def_tally_monthly:=cb_Tally_m.Checked;
 def_tally_annual:= cb_Tally_a.Checked;
 def_sortby:=       rg_SortBy.ItemIndex;
 def_topPOY:=       ud_Top_a.Position;
 //Then save to the registry
 SetRegValB('Print_ID',           def_ID);
 SetRegValB('Print_Title',        def_title);
 SetRegValB('Print_Author',       def_author);
 SetRegValB('Print_Position',     def_position);
 SetRegValB('Print_Tally_Monthly',def_tally_monthly);
 SetRegValB('Print_Tally_Annual', def_tally_annual);
 SetRegValB('Tabulate_Monthly',   def_tabulate_m);
 SetRegValB('Tabulate_POY',       def_tabulate_a);
 SetRegValI('SortBy',             def_sortby);
 SetRegValI('SortBy',             def_topPOY);
end;

end.
