object fmMain: TfmMain
  Left = 216
  Top = 133
  Width = 800
  Height = 480
  Caption = 'VirtualQuery'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    784
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object btClose: TSpeedButton
    Left = 650
    Top = 5
    Width = 128
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Close'
    OnClick = btCloseClick
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 32
    Width = 784
    Height = 410
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator: TDBNavigator
    Left = 5
    Top = 5
    Width = 232
    Height = 22
    DataSource = DataSource
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
    TabOrder = 1
  end
  object DataSource: TDataSource
    Left = 112
    Top = 88
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 168
  end
  object VirtualTable: TVirtualTable
    Left = 112
    Top = 168
    Data = {03000000000000000000}
  end
  object VirtualDataSet: TVirtualDataSet
    Left = 168
    Top = 168
  end
  object VirtualQuery: TVirtualQuery
    SourceDataSets = <
      item
        TableName = 'Producer'
        DataSet = VirtualTable
      end
      item
        TableName = 'Model'
        DataSet = ClientDataSet
      end
      item
        SchemaName = 'Txt'
        TableName = 'Info'
        DataSet = VirtualDataSet
      end>
    SQL.Strings = (
      '  Select Producer.Name As ProducerName,'
      '         Model.ModelName, '
      '         Txt.Info.Specification '
      '    From Model '
      '         LEFT JOIN Producer ON Model.ProducerID = Producer.ID '
      '         LEFT JOIN Txt.Info ON Model.ID = Txt.Info.ID '
      'Order By 1, 2')
    Left = 56
    Top = 88
  end
end
