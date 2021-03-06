object SeasonDetailForm: TSeasonDetailForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'SeasonDetailForm'
  ClientHeight = 423
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 33
    Align = alTop
    TabOrder = 0
    object season_title: TEdit
      Left = 1
      Top = 1
      Width = 415
      Height = 24
      Align = alTop
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Default'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = 'Season'
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 33
    Width = 417
    Height = 334
    ActivePage = ann_comp_tab
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object ann_comp_tab: TTabSheet
      Caption = 'Photographers Of The Year'
      object Label1: TLabel
        Left = 1
        Top = 3
        Width = 129
        Height = 13
        Caption = 'Number of places to score:'
      end
      object Label7: TLabel
        Left = 231
        Top = 3
        Width = 115
        Height = 13
        Caption = 'Only count best results:'
      end
      object ud_a_num_score: TUpDown
        Tag = 1
        Left = 169
        Top = 0
        Width = 16
        Height = 21
        Associate = ed_a_num_score
        Min = 3
        Position = 4
        TabOrder = 0
        OnChangingEx = ud_a_num_scoreChangingEx
      end
      object ed_a_num_score: TEdit
        Left = 136
        Top = 0
        Width = 33
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
        Text = '4'
      end
      object sb_a_num_places: TScrollBox
        Left = 0
        Top = 27
        Width = 185
        Height = 254
        TabOrder = 2
        object a_pos_pan: TPanel
          Left = 0
          Top = 0
          Width = 82
          Height = 20
          Caption = 'Position'
          TabOrder = 0
        end
        object a_sco_pan: TPanel
          Left = 82
          Top = 0
          Width = 82
          Height = 20
          Caption = 'Score'
          TabOrder = 1
        end
      end
      object ScrollBox1: TScrollBox
        Left = 191
        Top = 27
        Width = 215
        Height = 254
        TabOrder = 3
      end
      object rb_total_a: TRadioButton
        Left = 3
        Top = 286
        Width = 75
        Height = 17
        Caption = 'Total Score'
        Checked = True
        Enabled = False
        TabOrder = 4
        TabStop = True
      end
      object rb_average_a: TRadioButton
        Left = 84
        Top = 286
        Width = 101
        Height = 17
        Caption = 'Average Score'
        Enabled = False
        TabOrder = 5
      end
      object ud_score_entries: TUpDown
        Tag = 1
        Left = 385
        Top = 0
        Width = 16
        Height = 21
        Associate = ed_score_entries
        Min = 3
        Position = 100
        TabOrder = 6
      end
      object ed_score_entries: TEdit
        Left = 352
        Top = 0
        Width = 33
        Height = 21
        NumbersOnly = True
        TabOrder = 7
        Text = '100'
      end
    end
    object mon_comp_tab: TTabSheet
      Caption = 'Monthly Competition'
      ImageIndex = 1
      object Label2: TLabel
        Left = 1
        Top = 3
        Width = 129
        Height = 13
        Caption = 'Number of places to score:'
      end
      object Label3: TLabel
        Left = 203
        Top = 3
        Width = 117
        Height = 13
        Caption = 'Number of competitions:'
      end
      object ud_m_num_score: TUpDown
        Tag = 2
        Left = 169
        Top = 0
        Width = 16
        Height = 21
        Associate = ed_m_num_score
        Min = 3
        Max = 9
        Position = 4
        TabOrder = 0
        OnChangingEx = ud_a_num_scoreChangingEx
      end
      object ed_m_num_score: TEdit
        Left = 136
        Top = 0
        Width = 33
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
        Text = '4'
      end
      object ud_num_comps: TUpDown
        Tag = 3
        Left = 372
        Top = 0
        Width = 16
        Height = 21
        Associate = ed_num_comps
        Min = 2
        Max = 12
        Position = 4
        TabOrder = 2
        OnChangingEx = ud_a_num_scoreChangingEx
      end
      object ed_num_comps: TEdit
        Left = 339
        Top = 0
        Width = 33
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 3
        Text = '4'
      end
      object sb_m_num_places: TScrollBox
        Left = 0
        Top = 27
        Width = 185
        Height = 254
        TabOrder = 4
        object m_pos_pan: TPanel
          Left = 0
          Top = 0
          Width = 82
          Height = 20
          Caption = 'Position'
          TabOrder = 0
        end
        object m_sco_pan: TPanel
          Left = 82
          Top = 0
          Width = 82
          Height = 20
          Caption = 'Score'
          TabOrder = 1
        end
      end
      object sb_num_comps: TScrollBox
        Left = 191
        Top = 27
        Width = 215
        Height = 254
        TabOrder = 5
        object comp_mon_pan: TPanel
          Left = 0
          Top = 0
          Width = 78
          Height = 20
          Caption = 'Month'
          TabOrder = 0
        end
        object comp_tit_pan: TPanel
          Left = 78
          Top = 0
          Width = 78
          Height = 20
          Caption = 'Title'
          TabOrder = 1
        end
        object external_pan: TPanel
          Left = 156
          Top = 0
          Width = 29
          Height = 20
          Caption = 'Ext?'
          TabOrder = 2
        end
      end
      object rb_total_m: TRadioButton
        Left = 3
        Top = 286
        Width = 81
        Height = 17
        Caption = 'Total Score'
        Checked = True
        Enabled = False
        TabOrder = 6
        TabStop = True
      end
      object rb_average_m: TRadioButton
        Left = 84
        Top = 286
        Width = 108
        Height = 17
        Caption = 'Average Score'
        Enabled = False
        TabOrder = 7
      end
    end
    object category_tab: TTabSheet
      Caption = 'Categories'
      ImageIndex = 2
      object Label4: TLabel
        Left = 1
        Top = 3
        Width = 107
        Height = 13
        Caption = 'Number of categories:'
      end
      object sb_num_cats: TScrollBox
        Left = 0
        Top = 27
        Width = 185
        Height = 254
        TabOrder = 0
      end
      object ed_num_cats: TEdit
        Left = 136
        Top = 0
        Width = 33
        Height = 21
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 1
        Text = '4'
      end
      object ud_num_cats: TUpDown
        Tag = 4
        Left = 169
        Top = 0
        Width = 16
        Height = 21
        Associate = ed_num_cats
        Min = 1
        Max = 6
        Position = 4
        TabOrder = 2
        OnChangingEx = ud_a_num_scoreChangingEx
      end
      object ScrollBox2: TScrollBox
        Left = 191
        Top = 27
        Width = 215
        Height = 251
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 395
    Width = 417
    Height = 28
    Align = alBottom
    TabOrder = 2
    object CreateBtn: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Action1'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object CancelBtn: TBitBtn
      Left = 81
      Top = 0
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object SaveAsDefault: TBitBtn
      Left = 162
      Top = 0
      Width = 113
      Height = 25
      Caption = 'Save As Default'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF3706360000020B0F1313171A13161A14
        161B14161B13161A13171A0D1114000002280527FF00FFFF00FFFF00FFFF00FF
        310535553C2289613B825D3A825D3A825D3A825D3A825D3A825D3A89613B5D41
        25240528FF00FFFF00FFFF00FFFF00FF3307399E6830D8C2B1CFC2B9CFC1B8CF
        C1B8CFC1B8CFC1B8CFC1B9D7C3B4AA723826072CFF00FFFF00FFFF00FFFF00FF
        34083A9D6A35F7E8D9F0EBE5F0E8E0F0E7DFF0E8E0F0E8E1F0EBE4F7EADEAA76
        3F27082CFF00FFFF00FFFF00FFFF00FF360B3EA06A2FED9A3FE4943EE69F52E7
        A359E7A256E69E4FE4943EEC9A40AD72312A0B32FF00FFFF00FFFF00FFFF00FF
        380C3FA36E32F29D3EE79232F3C797F7D8B7EFB778EFB778E79437F09C3DB176
        352C0D33FF00FFFF00FFFF00FFFF00FF35123DA67236F7A445EC9A3DF1AF64F1
        B36CED9D40ED9E42ED9C3FF6A244B47B392D0F35FF00FFFF00FFFF00FFFF00FF
        000000AA7638FDAF53F6C07EF5BB75F5B86FF4B160F6BC76F7C180FDB35BB87E
        3A2F1137FF00FFFF00FFFF00FFFF00FFFF00FFAE7B3CFEB254F5B366F5B263F6
        B261F5AE5AF5AD59F4AE5CFEB357BC843F381240FF00FFFF00FFFF00FFFF00FF
        000000473CA17462E58372E28473E37E6CE37A68E48170E48575E47260E54C3F
        AE461841FF00FFFF00FFFF00FFFF00FF4D1A454039BC9F97FFA7A0FFA8A2FF97
        8FFFB0ABFFA59EFFB4AEFF7B71FF463FCA3B1B33FF00FFFF00FFFF00FFFF00FF
        4E204A3F3A776158B6564DB64F45B65A52B65D55B6544CB65951B6564CB6423E
        8041263CFF00FFFF00FFFF00FFFF00FF592A5A393A3334352D35362D36372D35
        362D34352D35362D34352D36372E3C3C36000000FF00FFFF00FFFF00FFFF00FF
        623A625050504E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E0000
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000
        0000000000000000000000000000FF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = SaveAsDefaultClick
    end
    object AutoFillBtn: TBitBtn
      Left = 276
      Top = 0
      Width = 137
      Height = 25
      Caption = 'Autofill Placings'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C8807FF7777777777FF700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = AutoFillBtnClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 367
    Width = 417
    Height = 28
    Align = alBottom
    TabOrder = 3
    object Label5: TLabel
      Left = 6
      Top = 6
      Width = 99
      Height = 13
      Caption = 'Season Start Month:'
    end
    object Label6: TLabel
      Left = 287
      Top = 6
      Width = 79
      Height = 13
      Caption = 'Entries included:'
    end
    object cb_start_month: TComboBox
      Left = 108
      Top = 2
      Width = 81
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object ed_a_comp_entries: TEdit
      Left = 372
      Top = 1
      Width = 20
      Height = 21
      Enabled = False
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 1
      Text = '2'
    end
    object ud_a_comp_entries: TUpDown
      Tag = 1
      Left = 392
      Top = 1
      Width = 16
      Height = 21
      Associate = ed_a_comp_entries
      Enabled = False
      Min = 1
      Max = 9
      Position = 2
      TabOrder = 2
    end
    object cb_splitequal: TCheckBox
      Left = 200
      Top = 5
      Width = 75
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Split Equals:'
      TabOrder = 3
    end
  end
end
