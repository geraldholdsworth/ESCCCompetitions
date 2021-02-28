object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 300
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 262
    Width = 256
    Height = 38
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 281
    object BitBtn1: TBitBtn
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 262
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 281
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 254
      Height = 116
      Align = alTop
      Caption = 'Details to include when printing or saving results'
      TabOrder = 0
      object cb_ID: TCheckBox
        Left = 8
        Top = 16
        Width = 149
        Height = 17
        Caption = 'ID (monthly only)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object cb_Title: TCheckBox
        Left = 8
        Top = 32
        Width = 149
        Height = 17
        Caption = 'Title (monthly only)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object cb_Author: TCheckBox
        Left = 8
        Top = 48
        Width = 149
        Height = 17
        Caption = 'Author (monthly only)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object cb_Position: TCheckBox
        Left = 8
        Top = 64
        Width = 149
        Height = 17
        Caption = 'Position (monthly only)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object cb_Tally_m: TCheckBox
        Left = 8
        Top = 80
        Width = 149
        Height = 17
        Caption = 'Position Tally (monthly)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object cb_Tally_a: TCheckBox
        Left = 8
        Top = 96
        Width = 149
        Height = 17
        Caption = 'Position Tally (PotY)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object rg_SortBy: TRadioGroup
      Left = 1
      Top = 193
      Width = 254
      Height = 68
      Align = alClient
      Caption = 'Field to sort by (monthly only)'
      Items.Strings = (
        'Position'
        'Title'
        'Author')
      TabOrder = 1
      ExplicitTop = 211
      ExplicitHeight = 69
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 117
      Width = 254
      Height = 76
      Align = alTop
      Caption = 'Format when printing'
      TabOrder = 2
      object Label1: TLabel
        Left = 8
        Top = 52
        Width = 125
        Height = 13
        Caption = 'In PotY, only print the top'
      end
      object cb_Tabulate_m: TCheckBox
        Left = 8
        Top = 16
        Width = 149
        Height = 17
        Caption = 'Tabulate Results (monthly)'
        Enabled = False
        TabOrder = 0
      end
      object cb_Tabulate_a: TCheckBox
        Left = 8
        Top = 32
        Width = 149
        Height = 17
        Caption = 'Tabulate Results (PotY)'
        Enabled = False
        TabOrder = 1
      end
      object ed_Top_a: TEdit
        Left = 136
        Top = 47
        Width = 17
        Height = 21
        ReadOnly = True
        TabOrder = 3
        Text = '10'
      end
      object ud_Top_a: TUpDown
        Left = 153
        Top = 47
        Width = 16
        Height = 21
        Associate = ed_Top_a
        Min = 4
        Max = 99
        Position = 10
        TabOrder = 2
      end
    end
  end
end
