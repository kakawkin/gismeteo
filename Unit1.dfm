object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 680
  ClientWidth = 991
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 32
    Width = 975
    Height = 548
    Stretch = True
  end
  object Image2: TImage
    Left = 120
    Top = 152
    Width = 489
    Height = 305
    Stretch = True
    OnMouseDown = Image2MouseDown
    OnMouseMove = Image2MouseMove
    OnMouseUp = Image2MouseUp
  end
  object Image3: TImage
    Left = 215
    Top = 160
    Width = 42
    Height = 100
    Stretch = True
  end
  object Label1: TLabel
    Left = 615
    Top = 589
    Width = 45
    Height = 13
    Caption = #1052#1072#1089#1096#1090#1072#1073
  end
  object Label2: TLabel
    Left = 768
    Top = 589
    Width = 64
    Height = 13
    Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
  end
  object Memo1: TMemo
    Left = 8
    Top = 586
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object TrackBar1: TTrackBar
    Left = 559
    Top = 608
    Width = 162
    Height = 28
    TabOrder = 1
    OnChange = TrackBar1Change
  end
  object ColorBox1: TColorBox
    Left = 727
    Top = 608
    Width = 145
    Height = 22
    TabOrder = 2
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 888
    Top = 584
  end
  object XMLDocument: TXMLDocument
    Left = 952
    Top = 584
  end
  object Timer2: TTimer
    Interval = 200
    Left = 920
    Top = 584
  end
end
