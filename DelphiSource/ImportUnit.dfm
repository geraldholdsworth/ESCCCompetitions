object ImportForm: TImportForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Import CSV File'
  ClientHeight = 320
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 8
      Width = 86
      Height = 13
      Caption = 'Column Contents:'
    end
    object SpeedButton1: TSpeedButton
      Left = 376
      Top = 5
      Width = 73
      Height = 22
      Caption = 'Import File'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 455
      Top = 5
      Width = 74
      Height = 22
      Caption = 'Discard File'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      NumGlyphs = 2
      OnClick = SpeedButton2Click
    end
    object cb_ColContents: TComboBox
      Left = 92
      Top = 5
      Width = 101
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Don'#39't Import'
      OnChange = cb_ColContentsChange
      Items.Strings = (
        'Don'#39't Import'
        'Author'
        'Title'
        'Score'
        'Position')
    end
    object cb_Headers: TCheckBox
      Left = 199
      Top = 7
      Width = 106
      Height = 17
      Caption = 'First row is header'
      TabOrder = 1
      OnClick = cb_HeadersClick
    end
  end
  object sg_Columns: TStringGrid
    Left = 0
    Top = 33
    Width = 541
    Height = 287
    Align = alClient
    DefaultColWidth = 128
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goFixedColClick, goFixedRowClick]
    TabOrder = 1
    OnFixedCellClick = sg_ColumnsFixedCellClick
    ColWidths = (
      128
      128
      128
      128
      128)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
end
