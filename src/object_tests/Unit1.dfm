object Form1: TForm1
  Left = 168
  Top = 170
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 224
    Top = 8
    Width = 32
    Height = 13
    Cursor = crHandPoint
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label1Click
  end
  object Label2: TLabel
    Left = 128
    Top = 8
    Width = 91
    Height = 13
    Caption = 'Project being used:'
  end
  object Label3: TLabel
    Left = 216
    Top = 252
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Button1: TButton
    Left = 28
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Load Project'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 28
    Top = 68
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 212
    Top = 36
    Width = 397
    Height = 209
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object ProgressBar1: TProgressBar
    Left = 216
    Top = 272
    Width = 289
    Height = 16
    TabOrder = 3
  end
  object Button3: TButton
    Left = 28
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 4
    OnClick = Button3Click
  end
end
