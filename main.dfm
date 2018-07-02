object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 614
  ClientWidth = 974
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 974
    Height = 573
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      'Loaded')
    TabIndex = 0
    object DBGrid1: TDBGrid
      Left = 4
      Top = 24
      Width = 277
      Height = 545
      Align = alLeft
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 281
      Top = 24
      Width = 280
      Height = 545
      Align = alLeft
      DataSource = DataSource2
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Memo1: TMemo
      Left = 561
      Top = 24
      Width = 409
      Height = 545
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 573
    Width = 974
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 106
      Height = 25
      Caption = 'Load Conference'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 128
      Top = 8
      Width = 66
      Height = 25
      Caption = 'Load YHC'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 200
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Match'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 880
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button4'
      ModalResult = 8
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 278
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Match Snd'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object CDS: TClientDataSet
    Aggregates = <>
    FileName = 
      'D:\data\clients\YourHouseCouncil\data\contact_export_080515_1310' +
      '.csv'
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 760
    Top = 240
  end
  object DataSource1: TDataSource
    DataSet = CDS
    Left = 736
    Top = 152
  end
  object CDS2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 752
    Top = 488
  end
  object DataSource2: TDataSource
    DataSet = CDS2
    Left = 664
    Top = 416
  end
end
