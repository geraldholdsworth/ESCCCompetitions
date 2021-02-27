object DetailSelectionForm: TDetailSelectionForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Detail Selection'
  ClientHeight = 267
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 229
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 254
      Height = 100
      Align = alTop
      Caption = 'Details to include when printing or saving results'
      TabOrder = 0
      object cb_ID: TCheckBox
        Left = 8
        Top = 16
        Width = 149
        Height = 17
        Caption = 'ID'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object cb_Title: TCheckBox
        Left = 8
        Top = 32
        Width = 149
        Height = 17
        Caption = 'Title'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
      object cb_Author: TCheckBox
        Left = 8
        Top = 48
        Width = 149
        Height = 17
        Caption = 'Author'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
      end
      object cb_Position: TCheckBox
        Left = 8
        Top = 64
        Width = 149
        Height = 17
        Caption = 'Position'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 3
      end
      object cb_Tally: TCheckBox
        Left = 8
        Top = 80
        Width = 149
        Height = 17
        Caption = 'Position Tally'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
      end
    end
    object rg_SortBy: TRadioGroup
      Left = 1
      Top = 160
      Width = 254
      Height = 68
      Align = alClient
      Caption = 'Field to sort by'
      ItemIndex = 0
      Items.Strings = (
        'Position'
        'Title'
        'Author')
      TabOrder = 1
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 101
      Width = 254
      Height = 59
      Align = alTop
      Caption = 'Format when printing'
      TabOrder = 2
      object Label1: TLabel
        Left = 8
        Top = 34
        Width = 85
        Height = 13
        Caption = 'Only print the top'
      end
      object cb_Tabulate: TCheckBox
        Left = 8
        Top = 16
        Width = 149
        Height = 17
        Caption = 'Tabulate Results'
        Enabled = False
        TabOrder = 0
      end
      object ed_Top: TEdit
        Left = 99
        Top = 32
        Width = 17
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        Text = '10'
      end
      object up_Top: TUpDown
        Left = 116
        Top = 32
        Width = 16
        Height = 21
        Associate = ed_Top
        Enabled = False
        Min = 4
        Max = 99
        Position = 10
        TabOrder = 2
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 229
    Width = 256
    Height = 38
    Align = alBottom
    TabOrder = 1
    object OKbtn: TBitBtn
      Left = 9
      Top = 5
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
  end
end
