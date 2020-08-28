object fmMain: TfmMain
  Left = 436
  Top = 142
  Width = 800
  Height = 600
  Caption = 'VirtualDataSetDemo'
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 0
    Top = 249
    Width = 784
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object pnDept: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 249
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      784
      249)
    object btClose: TSpeedButton
      Left = 100
      Top = 5
      Width = 95
      Height = 22
      Caption = 'Close'
      OnClick = btCloseClick
    end
    object btOpen: TSpeedButton
      Left = 5
      Top = 5
      Width = 95
      Height = 22
      Caption = 'Open'
      OnClick = btOpenClick
    end
    object DBGridDept: TDBGrid
      Left = 0
      Top = 31
      Width = 784
      Height = 217
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DeptDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DBNavigatorDept: TDBNavigator
      Left = 540
      Top = 5
      Width = 240
      Height = 22
      DataSource = DeptDataSource
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
  object pnEmp: TPanel
    Left = 0
    Top = 252
    Width = 784
    Height = 310
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      784
      310)
    object DBGridEmp: TDBGrid
      Left = 0
      Top = 32
      Width = 784
      Height = 277
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = EmpDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DBNavigatorEmp: TDBNavigator
      Left = 540
      Top = 5
      Width = 240
      Height = 22
      DataSource = EmpDataSource
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
  object DeptDataSet: TVirtualDataSet
    OnGetRecordCount = DeptDataSetGetRecordCount
    OnGetFieldValue = DeptDataSetGetFieldValue
    OnInsertRecord = DeptDataSetInsertRecord
    Left = 320
    Top = 184
  end
  object EmpDataSet: TVirtualDataSet
    OnGetRecordCount = EmpDataSetGetRecordCount
    OnGetFieldValue = EmpDataSetGetFieldValue
    OnModifyRecord = EmpDataSetModifyRecord
    OnDeleteRecord = EmpDataSetDeleteRecord
    Left = 312
    Top = 356
  end
  object DeptDataSource: TDataSource
    DataSet = DeptDataSet
    Left = 408
    Top = 184
  end
  object EmpDataSource: TDataSource
    DataSet = EmpDataSet
    Left = 408
    Top = 356
  end
end
