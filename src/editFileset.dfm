object editFilesetDlg: TeditFilesetDlg
  Left = 360
  Top = 177
  BorderStyle = bsDialog
  Caption = 'Item Properties'
  ClientHeight = 221
  ClientWidth = 471
  Color = 16185078
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 33
    Top = 23
    Width = 57
    Height = 13
    Caption = 'Input folder'
  end
  object Label2: TLabel
    Left = 33
    Top = 56
    Width = 65
    Height = 13
    Caption = 'Output folder'
  end
  object Label3: TLabel
    Left = 33
    Top = 87
    Width = 24
    Height = 13
    Caption = 'Mask'
  end
  object Label4: TLabel
    Left = 33
    Top = 148
    Width = 73
    Height = 13
    Caption = 'Filename prefix'
  end
  object Label5: TLabel
    Left = 33
    Top = 180
    Width = 72
    Height = 13
    Caption = 'Filename suffix'
  end
  object PDJXPButton1: TPDJXPButton
    Left = 219
    Top = 182
    Width = 75
    Height = 25
    Default = True
    Caption = 'OK'
    TabOrder = 0
    ModalResult = 1
  end
  object PDJXPButton2: TPDJXPButton
    Left = 301
    Top = 182
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    ModalResult = 2
  end
  object edtInputFolder: TPDJXPEditBtn
    Left = 114
    Top = 20
    Width = 280
    Height = 21
    TabOrder = 2
    Text = 'edtInputFolder'
    EButtons = <
      item
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000000000000000000000000000000000008000FF8000FF
          8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FFC4CCD0B8BF
          C3B7BEC28000FF8000FF8000FFC0C8CCB6BDC1B6BDC1B6BDC1B6BDC1B6BDC1B6
          BDC1B6BDC1B6BDC1B2B9BD93999C595C5E5A5E60B6BDC18000FFC0C8CC828789
          50535546494A46494A46494A46494A46494A46494A46494A665C5C8D7F9F6183
          A946494AAEB5B98000FF71A3BC1D82B51B81B3187EB0167CAE1379AB1076A80D
          73A50B71A33B799E8E81A04A8DDC359CDE3D42448B9193C2CACE1F84B745AADD
          D5F8FF7AD7FF6FD4FF6FD4FF6FD4FF6FD4FF7FC9ED9488A84C8CD852BBFF0B71
          A6234A5E626668BAC2C52489BC2A8FC2D9FCFFAFECFF96C8D8CACCC1C5C7B6AD
          B9B893A5B25E93D054BDFF75DAFF147AAC0D5C854A4D4EB1B8BB288DC02E93C6
          86CFF3CCC7C9F4EEE5FFFFEAFFFFD9FFF5C3DCB59990C5DA7FE6FF85EBFF379C
          CF1B81AB4143449095982A8FC24CB1E43C9FD1DAC8B2FFFFFCFFFFF9FFFFE0FF
          F4C0FFE9B7B0CECD91F7FF91F7FF57BCEF157BA72A47565C60612D92C56CD1FC
          2489BCE3D2B2FFFFE6FFFFE8FFFFD9FFEDB8FFEDBED9D2BB99FFFF99FFFF60C5
          F847ACC8115A7F3D40412F94C77BE0FF46ABD5DEC5A5FFFFD0FFF9C9FFF4C2FF
          E9C2FFF7D1E8CFC3FFFFFFFFFFFF81E6FF79DEE9056596474A4B3196C985EBFF
          6FD4F2828B94FCE8B6FFEDB6FFF0C0FFFFF7EBDCD1518FB42489BC2085B81C81
          B41B81B3056B9DACB9BE3398CB91F7FF8EF4FF90EAF4B9BFB8EBCDADE6CCA9DD
          C5B8E8D9D9FFFFFFFFFFFFFFFFFF167CAE595C5EB6BDC18000FF3499CCFFFFFF
          99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
          B0B6BDC18000FF8000FF8000FF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2A3
          AAAD8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
          3499CC3398CB3196C92F94C7B6BDC18000FF8000FF8000FF8000FF8000FF8000
          FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
          00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF}
        NumGlyphs = 1
        Margin = -1
        Spacing = 4
        Hint = 'Browse...'
        OnClick = edtInputFolderEButtons0Click
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
  object edtOutputFolder: TPDJXPEditBtn
    Left = 114
    Top = 52
    Width = 280
    Height = 21
    TabOrder = 3
    Text = 'edtOutputFolder'
    EButtons = <
      item
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000000000000000000000000000000000008000FF8000FF
          8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FFC4CCD0B8BF
          C3B7BEC28000FF8000FF8000FFC0C8CCB6BDC1B6BDC1B6BDC1B6BDC1B6BDC1B6
          BDC1B6BDC1B6BDC1B2B9BD93999C595C5E5A5E60B6BDC18000FFC0C8CC828789
          50535546494A46494A46494A46494A46494A46494A46494A665C5C8D7F9F6183
          A946494AAEB5B98000FF71A3BC1D82B51B81B3187EB0167CAE1379AB1076A80D
          73A50B71A33B799E8E81A04A8DDC359CDE3D42448B9193C2CACE1F84B745AADD
          D5F8FF7AD7FF6FD4FF6FD4FF6FD4FF6FD4FF7FC9ED9488A84C8CD852BBFF0B71
          A6234A5E626668BAC2C52489BC2A8FC2D9FCFFAFECFF96C8D8CACCC1C5C7B6AD
          B9B893A5B25E93D054BDFF75DAFF147AAC0D5C854A4D4EB1B8BB288DC02E93C6
          86CFF3CCC7C9F4EEE5FFFFEAFFFFD9FFF5C3DCB59990C5DA7FE6FF85EBFF379C
          CF1B81AB4143449095982A8FC24CB1E43C9FD1DAC8B2FFFFFCFFFFF9FFFFE0FF
          F4C0FFE9B7B0CECD91F7FF91F7FF57BCEF157BA72A47565C60612D92C56CD1FC
          2489BCE3D2B2FFFFE6FFFFE8FFFFD9FFEDB8FFEDBED9D2BB99FFFF99FFFF60C5
          F847ACC8115A7F3D40412F94C77BE0FF46ABD5DEC5A5FFFFD0FFF9C9FFF4C2FF
          E9C2FFF7D1E8CFC3FFFFFFFFFFFF81E6FF79DEE9056596474A4B3196C985EBFF
          6FD4F2828B94FCE8B6FFEDB6FFF0C0FFFFF7EBDCD1518FB42489BC2085B81C81
          B41B81B3056B9DACB9BE3398CB91F7FF8EF4FF90EAF4B9BFB8EBCDADE6CCA9DD
          C5B8E8D9D9FFFFFFFFFFFFFFFFFF167CAE595C5EB6BDC18000FF3499CCFFFFFF
          99FFFF99FFFF99FFFF99FFFFFFFFFF258ABD2287BA1F84B71D82B51B81B3187E
          B0B6BDC18000FF8000FF8000FF3499CCFFFFFFFFFFFFFFFFFFFFFFFF2A8FC2A3
          AAAD8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF
          3499CC3398CB3196C92F94C7B6BDC18000FF8000FF8000FF8000FF8000FF8000
          FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF80
          00FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF8000FF}
        NumGlyphs = 1
        Margin = -1
        Spacing = 4
        Hint = 'Browse...'
        OnClick = edtInputFolderEButtons0Click
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
  object cbSubDirs: TPDJXPCheckBox
    Left = 112
    Top = 115
    Width = 137
    Height = 17
    Caption = 'Include subdirectories'
    Checked = False
    TabOrder = 4
  end
  object edtPrefix: TPDJXPEdit
    Left = 114
    Top = 144
    Width = 50
    Height = 21
    TabOrder = 5
    Text = 'edtPrefix'
  end
  object edtPostfix: TPDJXPEdit
    Left = 114
    Top = 176
    Width = 50
    Height = 21
    TabOrder = 6
    Text = 'edtPostfix'
  end
  object cbMask: TPDJXPComboBox
    Left = 114
    Top = 83
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Text = 'cbMask'
    ItemIndex = -1
  end
  object PDJXPButton3: TPDJXPButton
    Left = 384
    Top = 182
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 8
    OnClick = PDJXPButton3Click
  end
end
