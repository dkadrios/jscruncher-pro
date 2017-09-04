object requestEvalCodeDlg: TrequestEvalCodeDlg
  Left = 442
  Top = 380
  BorderStyle = bsDialog
  Caption = 'Request Evaluation Code'
  ClientHeight = 107
  ClientWidth = 280
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
    Left = 16
    Top = 8
    Width = 132
    Height = 13
    Caption = 'Enter a valid email address.'
  end
  object Label2: TLabel
    Left = 16
    Top = 23
    Width = 210
    Height = 13
    Caption = 'Your evaluation code will be emailed to you.'
  end
  object PDJXPEdit1: TPDJXPEdit
    Left = 16
    Top = 41
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object PDJXPButton1: TPDJXPButton
    Left = 60
    Top = 70
    Width = 75
    Height = 25
    Default = True
    Caption = 'OK'
    TabOrder = 1
    ModalResult = 1
  end
  object PDJXPButton2: TPDJXPButton
    Left = 144
    Top = 70
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 2
    ModalResult = 1
  end
end
