object ConfirmationDlg: TConfirmationDlg
  Left = 424
  Top = 222
  BorderStyle = bsDialog
  Caption = 'Information'
  ClientHeight = 158
  ClientWidth = 370
  Color = 16185078
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBox1: TPDJXPCheckBox
    Left = 9
    Top = 134
    Width = 184
    Height = 17
    Caption = 'Continue to show this message'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object Button1: TPDJXPButton
    Left = 212
    Top = 128
    Width = 69
    Height = 23
    Cancel = True
    Default = True
    Caption = 'OK'
    TabOrder = 1
    ModalResult = 1
  end
  object PDJXPButton1: TPDJXPButton
    Left = 293
    Top = 128
    Width = 69
    Height = 23
    Caption = '&No'
    TabOrder = 2
    ModalResult = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 370
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 10
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 10
      Top = 10
      Width = 350
      Height = 101
      Align = alClient
      AutoSize = False
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
end
