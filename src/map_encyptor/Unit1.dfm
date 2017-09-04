object Form1: TForm1
  Left = 192
  Top = 138
  BorderStyle = bsDialog
  Caption = 'Map Encryptor'
  ClientHeight = 212
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 257
    Height = 41
    AutoSize = False
    Caption = 
      'If you open a .jmap file, this will spit out a .jmapx file.  If ' +
      'you open a .jmapx file, it will spit out a .jmap one.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 20
    Top = 112
    Width = 245
    Height = 5
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 12
    Top = 124
    Width = 257
    Height = 40
    AutoSize = False
    Caption = 
      'You can also open a .jmap or .jmapx file and have it be sorted. ' +
      ' The output file is the same as the input.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 16
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Convert...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Sort...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Map Files|*.jmap|Encrypted map files|*.jmapx'
    Left = 112
    Top = 68
  end
end
