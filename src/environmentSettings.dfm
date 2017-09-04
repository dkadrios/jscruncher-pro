object environmentSettingsDlg: TenvironmentSettingsDlg
  Left = 436
  Top = 77
  HelpContext = 1
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 291
  ClientWidth = 404
  Color = 16185078
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TPDJXPButton
    Left = 226
    Top = 255
    Width = 80
    Height = 25
    Default = True
    Caption = 'OK'
    TabOrder = 0
    ModalResult = 1
  end
  object Button2: TPDJXPButton
    Left = 313
    Top = 255
    Width = 80
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    ModalResult = 2
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 397
    Height = 245
    ActivePage = xpTabSheet3
    OwnerDraw = True
    ParentShowHint = False
    ShowHint = True
    Style = tsButtons
    TabOrder = 2
    OnDrawTab = PageControl1DrawTab
    object xpTabSheet1: TTabSheet
      Caption = 'Obfuscation'
      object Shape1: TShape
        Left = 1
        Top = 1
        Width = 387
        Height = 212
        Align = alClient
        Pen.Style = psClear
      end
      object Shape29: TShape
        Left = 388
        Top = 1
        Width = 1
        Height = 212
        Align = alRight
        Pen.Color = clSilver
      end
      object Shape5: TShape
        Left = 0
        Top = 1
        Width = 1
        Height = 212
        Align = alLeft
        Pen.Color = clSilver
      end
      object Shape6: TShape
        Left = 0
        Top = 0
        Width = 389
        Height = 1
        Align = alTop
        Pen.Color = clSilver
      end
      object Shape7: TShape
        Left = 0
        Top = 213
        Width = 389
        Height = 1
        Align = alBottom
        Pen.Color = clSilver
      end
      object GroupBox3: TPDJXPGroupBox
        Left = 10
        Top = 128
        Width = 361
        Height = 61
        Caption = ' Where to Save Log Files '
        Color = clWhite
        ParentColor = False
        TabOrder = 0
        object editLog: TPDJXPEditBtn
          Left = 14
          Top = 24
          Width = 334
          Height = 21
          ParentColor = True
          ReadOnly = True
          TabOrder = 0
          EButtons = <
            item
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000010000846300008C6B
                180052392900FF9C29009C7B310039393900AD8C3900AD8C4200BD944A005A5A
                5A0063636300D6B56B0073737300E7BD7300DEA57B00E7BD7B0084848400EFCE
                84008C8C8C0094949400FFD694009C9C9C00FFE79C00A5A5A500ADADAD00FFF7
                AD00B5B5B500C6C6C600FFFFC600CECECE0052BDD60052C6D600CED6D600ADDE
                D600DEDEDE00E7E7E7008400FF0052DEFF0000F7FF0063F7FF009CF7FF0052FF
                FF009CFFFF00ADFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00242424242424
                2424240124242424242424242424242424240003012424242424180C02020505
                1A00030E03010C0C0517132B2828251E000E0E0E0E0301251F05132B2B2B2B00
                0E1C1C0E0E0E03012505132B2B2B0F0101011C1C0E0101010F0C132B2B2B2B2B
                2B041C1C19041A28250513202B2B2B2B2B071C1C0E1428252105132B2B2B2B2B
                080E191C07282828250918202B202B2B0816190D142B2B2B2B0A1A2B202B2B06
                0E140F2B2B2B2B2B2B0C1B202B200B0B0B0B111B1B211E1E1E101D1A1A1A1D21
                21252525252525251E242022262626261E231212121212121224241529272727
                261A242424242424242424241512121215242424242424242424}
              NumGlyphs = 1
              Margin = -1
              Spacing = 4
              Hint = 'browse...'
              OnClick = btnBrowseRepClick
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Enabled = True
              ParentFont = True
              AllowAllUp = False
              GroupIndex = 0
              Down = False
              RepeatAction = False
              Visible = True
            end>
        end
      end
      object GroupBox2: TPDJXPGroupBox
        Left = 10
        Top = 14
        Width = 361
        Height = 97
        Caption = 'Map Files'
        Color = clWhite
        ParentColor = False
        TabOrder = 1
        object Label1: TLabel
          Left = 13
          Top = 24
          Width = 40
          Height = 13
          Caption = 'Location'
        end
        object Label2: TLabel
          Left = 16
          Top = 60
          Width = 85
          Height = 13
          Caption = 'User-defined map'
        end
        object editMap: TPDJXPEditBtn
          Left = 57
          Top = 21
          Width = 295
          Height = 21
          ParentColor = True
          ReadOnly = True
          TabOrder = 0
          EButtons = <
            item
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000010000846300008C6B
                180052392900FF9C29009C7B310039393900AD8C3900AD8C4200BD944A005A5A
                5A0063636300D6B56B0073737300E7BD7300DEA57B00E7BD7B0084848400EFCE
                84008C8C8C0094949400FFD694009C9C9C00FFE79C00A5A5A500ADADAD00FFF7
                AD00B5B5B500C6C6C600FFFFC600CECECE0052BDD60052C6D600CED6D600ADDE
                D600DEDEDE00E7E7E7008400FF0052DEFF0000F7FF0063F7FF009CF7FF0052FF
                FF009CFFFF00ADFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00242424242424
                2424240124242424242424242424242424240003012424242424180C02020505
                1A00030E03010C0C0517132B2828251E000E0E0E0E0301251F05132B2B2B2B00
                0E1C1C0E0E0E03012505132B2B2B0F0101011C1C0E0101010F0C132B2B2B2B2B
                2B041C1C19041A28250513202B2B2B2B2B071C1C0E1428252105132B2B2B2B2B
                080E191C07282828250918202B202B2B0816190D142B2B2B2B0A1A2B202B2B06
                0E140F2B2B2B2B2B2B0C1B202B200B0B0B0B111B1B211E1E1E101D1A1A1A1D21
                21252525252525251E242022262626261E231212121212121224241529272727
                261A242424242424242424241512121215242424242424242424}
              NumGlyphs = 1
              Margin = -1
              Spacing = 4
              Hint = 'browse...'
              OnClick = btnBrowseRepClick
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Enabled = True
              ParentFont = True
              AllowAllUp = False
              GroupIndex = 0
              Down = False
              RepeatAction = False
              Visible = True
            end>
        end
        object editUserDefinedMap: TPDJXPEditBtn
          Left = 107
          Top = 56
          Width = 144
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = 'editUserDefinedMap'
          EButtons = <
            item
              Glyph.Data = {
                36050000424D3605000000000000360400002800000010000000100000000100
                0800000000000001000000000000000000000001000000010000846300008C6B
                180052392900FF9C29009C7B310039393900AD8C3900AD8C4200BD944A005A5A
                5A0063636300D6B56B0073737300E7BD7300DEA57B00E7BD7B0084848400EFCE
                84008C8C8C0094949400FFD694009C9C9C00FFE79C00A5A5A500ADADAD00FFF7
                AD00B5B5B500C6C6C600FFFFC600CECECE0052BDD60052C6D600CED6D600ADDE
                D600DEDEDE00E7E7E7008400FF0052DEFF0000F7FF0063F7FF009CF7FF0052FF
                FF009CFFFF00ADFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00242424242424
                2424240124242424242424242424242424240003012424242424180C02020505
                1A00030E03010C0C0517132B2828251E000E0E0E0E0301251F05132B2B2B2B00
                0E1C1C0E0E0E03012505132B2B2B0F0101011C1C0E0101010F0C132B2B2B2B2B
                2B041C1C19041A28250513202B2B2B2B2B071C1C0E1428252105132B2B2B2B2B
                080E191C07282828250918202B202B2B0816190D142B2B2B2B0A1A2B202B2B06
                0E140F2B2B2B2B2B2B0C1B202B200B0B0B0B111B1B211E1E1E101D1A1A1A1D21
                21252525252525251E242022262626261E231212121212121224241529272727
                261A242424242424242424241512121215242424242424242424}
              NumGlyphs = 1
              Margin = -1
              Spacing = 4
              Hint = 'browse...'
              OnClick = SpeedButton1Click
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Enabled = True
              ParentFont = True
              AllowAllUp = False
              GroupIndex = 0
              Down = False
              RepeatAction = False
              Visible = True
            end>
        end
      end
    end
    object xpTabSheet2: TTabSheet
      Caption = 'Confirmations / Popups'
      object Shape2: TShape
        Left = 1
        Top = 1
        Width = 387
        Height = 212
        Align = alClient
        Pen.Style = psClear
      end
      object Shape8: TShape
        Left = 388
        Top = 1
        Width = 1
        Height = 212
        Align = alRight
        Pen.Color = clSilver
      end
      object Shape9: TShape
        Left = 0
        Top = 1
        Width = 1
        Height = 212
        Align = alLeft
        Pen.Color = clSilver
      end
      object Shape10: TShape
        Left = 0
        Top = 213
        Width = 389
        Height = 1
        Align = alBottom
        Pen.Color = clSilver
      end
      object Shape11: TShape
        Left = 0
        Top = 0
        Width = 389
        Height = 1
        Align = alTop
        Pen.Color = clSilver
      end
      object cbAddsToMapFile: TPDJXPCheckBox
        Left = 16
        Top = 20
        Width = 244
        Height = 17
        Caption = '"Adds this item to the user defined map file..."'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 0
      end
      object cbCombineStrings: TPDJXPCheckBox
        Left = 16
        Top = 40
        Width = 277
        Height = 17
        Caption = '"Form feeds must be removed to combine strings..."'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 1
      end
      object cbShowCompressionSettingsDialog: TPDJXPCheckBox
        Left = 16
        Top = 162
        Width = 297
        Height = 17
        Caption = 'Show compression settings dialog before compressing'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 2
      end
      object cbInputSameAsOutputWithPrefix: TPDJXPCheckBox
        Left = 16
        Top = 60
        Width = 181
        Height = 17
        Caption = '"Output folder same as input..."'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 3
      end
      object cbInputSameAsOutputWithoutPrefix: TPDJXPCheckBox
        Left = 16
        Top = 80
        Width = 269
        Height = 17
        Caption = '"Output folder same as input WITHOUT prefix..."'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 4
      end
      object cbInputFolderMissing: TPDJXPCheckBox
        Left = 16
        Top = 100
        Width = 145
        Height = 17
        Caption = '"Input folder missing..."'
        Checked = False
        Color = clWhite
        ParentColor = False
        TabOrder = 5
      end
    end
    object xpTabSheet3: TTabSheet
      Caption = 'Miscellaneous'
      object Label3: TLabel
        Left = 15
        Top = 12
        Width = 171
        Height = 13
        Caption = 'Name of default "user defined" map'
        Color = clWhite
        ParentColor = False
      end
      object SpeedButton1: TPDJXPSpeedButton
        Left = 220
        Top = 28
        Width = 21
        Height = 21
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Shape3: TShape
        Left = 1
        Top = 1
        Width = 387
        Height = 212
        Align = alClient
        Pen.Style = psClear
      end
      object Shape12: TShape
        Left = 0
        Top = 1
        Width = 1
        Height = 212
        Align = alLeft
        Pen.Color = clSilver
      end
      object Shape13: TShape
        Left = 0
        Top = 0
        Width = 389
        Height = 1
        Align = alTop
        Pen.Color = clSilver
      end
      object Shape14: TShape
        Left = 0
        Top = 213
        Width = 389
        Height = 1
        Align = alBottom
        Pen.Color = clSilver
      end
      object Shape15: TShape
        Left = 388
        Top = 1
        Width = 1
        Height = 212
        Align = alRight
        Pen.Color = clSilver
      end
      object GroupBox4: TPDJXPGroupBox
        Left = 10
        Top = 7
        Width = 361
        Height = 56
        Color = clWhite
        ParentColor = False
        TabOrder = 0
        object cbPlaySounds: TPDJXPCheckBox
          Left = 15
          Top = 22
          Width = 174
          Height = 17
          Caption = 'Enable feedback with sounds'
          Checked = False
          TabOrder = 0
        end
      end
    end
  end
  object PDJXPButton1: TPDJXPButton
    Left = 12
    Top = 255
    Width = 80
    Height = 25
    Caption = '&Help'
    TabOrder = 3
    OnClick = PDJXPButton1Click
  end
end
