object backgroundTaskDlg: TbackgroundTaskDlg
  Left = 333
  Top = 159
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'JSCruncher Pro'
  ClientHeight = 278
  ClientWidth = 439
  Color = 16185078
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 10
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 16
    Top = 43
    Width = 405
    Height = 13
    AutoSize = False
    Caption = 'Label2'
  end
  object ProgressBar1: TPDJXPProgressBar
    Left = 15
    Top = 26
    Width = 406
    Height = 16
    ParentColor = False
    Min = 0
    Max = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 237
    Width = 439
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object PDJXPButton1: TPDJXPButton
      Left = 340
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Default = True
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = PDJXPButton1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 64
    Width = 439
    Height = 173
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    Visible = False
    object Shape1: TShape
      Left = 23
      Top = 29
      Width = 391
      Height = 141
      Brush.Style = bsClear
      Pen.Color = 14655868
    end
    object pnlErrorMessages: TPanel
      Left = 20
      Top = 2
      Width = 396
      Height = 23
      BevelOuter = bvNone
      BorderWidth = 3
      ParentColor = True
      TabOrder = 0
      object pnlErrorsFound: TmxOutlookPanel
        Left = 3
        Top = 3
        Width = 390
        Height = 17
        Align = alClient
        Background.AlphaBlend = 255
        Background.Color = 13434879
        Background.Gradient.BeginColor = clBtnFace
        Background.Gradient.DrawStyle = gtLeftToRight
        Background.Gradient.Direction = gdNormal
        Background.Gradient.EndColor = clBlue
        Pen.Color = clNavy
        DrawBorder = True
        object Label5: TLabel
          Left = 18
          Top = 2
          Width = 116
          Height = 13
          Caption = 'Errors found during run.'
          Transparent = True
        end
        object Image1: TImage
          Left = 2
          Top = 2
          Width = 13
          Height = 13
          AutoSize = True
          Picture.Data = {
            07544269746D61703E020000424D3E0200000000000036000000280000000D00
            00000D0000000100180000000000080200000000000000000000000000000000
            0000CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
            CCFFFFCCFFFFCCFFFF00CCFFFFCCFFFFCCFFFFCCFFFF80000080000080000080
            0000800000CCFFFFCCFFFFCCFFFFCCFFFF00CCFFFFCCFFFF8000008000008000
            00800000800000800000800000800000800000CCFFFFCCFFFF00CCFFFFCCFFFF
            800000800000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800000800000CCFFFFCCFF
            FF00CCFFFF800000800000800000800000FFFFFFFFFFFFFFFFFF800000800000
            800000800000CCFFFF00CCFFFF800000800000800000800000FFFFFFFFFFFFFF
            FFFF800000800000800000800000CCFFFF00CCFFFF8000008000008000008000
            00FFFFFFFFFFFFFFFFFF800000800000800000800000CCFFFF00CCFFFF800000
            800000800000FFFFFFFFFFFFFFFFFFFFFFFF800000800000800000800000CCFF
            FF00CCFFFF800000800000800000800000800000800000800000800000800000
            800000800000CCFFFF00CCFFFFCCFFFF800000800000800000FFFFFFFFFFFFFF
            FFFF800000800000800000CCFFFFCCFFFF00CCFFFFCCFFFF8000008000008000
            00800000800000800000800000800000800000CCFFFFCCFFFF00CCFFFFCCFFFF
            CCFFFFCCFFFF800000800000800000800000800000CCFFFFCCFFFFCCFFFFCCFF
            FF00CCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFFCCFFFF
            CCFFFFCCFFFFCCFFFF00}
        end
      end
    end
    object tgMessages: TtsGrid
      Left = 24
      Top = 30
      Width = 389
      Height = 139
      BorderStyle = bsNone
      CheckBoxStyle = stCheck
      Cols = 3
      Ctl3D = False
      DefaultColWidth = 130
      Enabled = False
      ExportDelimiter = ','
      GridMode = gmListBox
      HeadingColor = 16185078
      HeadingFont.Charset = DEFAULT_CHARSET
      HeadingFont.Color = clWindowText
      HeadingFont.Height = -11
      HeadingFont.Name = 'MS Sans Serif'
      HeadingFont.Style = []
      HeadingParentFont = False
      ParentCtl3D = False
      ParentShowHint = False
      RowBarOn = False
      Rows = 0
      SelectionType = sltColor
      ShowHint = False
      TabOrder = 1
      Version = '2.20.26'
      XMLExport.Version = '1.0'
      XMLExport.DataPacketVersion = '2.0'
      OnCellLoaded = tgMessagesCellLoaded
      OnDblClick = tgMessagesDblClick
      ColProperties = <
        item
          DataCol = 1
          Col.Heading = 'Category'
          Col.ReadOnly = True
          Col.Width = 150
        end
        item
          DataCol = 2
          Col.Heading = 'Filename'
          Col.ReadOnly = True
          Col.Width = 150
        end
        item
          DataCol = 3
          Col.Heading = 'Line'
          Col.Width = 259
        end>
    end
  end
  object oneshot: TTimer
    Enabled = False
    Interval = 100
    OnTimer = oneshotTimer
    Left = 72
    Top = 4
  end
end
