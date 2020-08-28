unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DBCtrls, Buttons, ToolWin, ExtCtrls, Grids, DBGrids, Math,
  DB, MemDS, VirtualDataSet;

type
  TfmMain = class(TForm)
    pnDept: TPanel;
    Splitter: TSplitter;
    pnEmp: TPanel;
    btOpen: TSpeedButton;
    btClose: TSpeedButton;
    DBGridDept: TDBGrid;
    DBGridEmp: TDBGrid;
    DBNavigatorDept: TDBNavigator;
    DBNavigatorEmp: TDBNavigator;
    DeptDataSet: TVirtualDataSet;
    EmpDataSet: TVirtualDataSet;
    DeptDataSource: TDataSource;
    EmpDataSource: TDataSource;
    procedure btCloseClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EmpDataSetGetFieldValue(Sender: TObject; Field: TField;
      RecNo: Integer; out Value: Variant);
    procedure DeptDataSetGetFieldValue(Sender: TObject; Field: TField;
      RecNo: Integer; out Value: Variant);
    procedure EmpDataSetGetRecordCount(Sender: TObject; out Count: Integer);
    procedure DeptDataSetGetRecordCount(Sender: TObject; out Count: Integer);
    procedure DeptDataSetInsertRecord(Sender: TObject; var RecNo: Integer);
    procedure EmpDataSetModifyRecord(Sender: TObject; var RecNo: Integer);
    procedure EmpDataSetDeleteRecord(Sender: TObject; RecNo: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    DeptList, EmpList : TList;
  end;

  TDept = class
  private
    FDeptNo: Integer;
    FDName: String;
    FLoc: String;
  public
    constructor Create(const DeptNo: Integer; const DName: string; const Loc: string);

    property DeptNo: Integer read FDeptNo write FDeptNo;
    property DName: string read FDName write FDName;
    property Loc: string read FLoc write FLoc;
  end;

  TEmp = class
  private
    FEmpNo: Integer;
    FEName: String;
    FJob: String;
    FMgr: Variant;
    FHireDate: TDateTime;
    FSal: Real;
    FComm: Variant;
    FDeptNo: Integer;
  public
    constructor Create(const EmpNo: Integer; const EName, Job: String; const Mgr: Variant;
      const HireDate: TDateTime; const Sal: Real; const Comm: Variant; DeptNo: Integer);

    property EmpNo: Integer read FEmpNo write FEmpNo;
    property EName: String read FEName write FEName;
    property Job: String read FJob write FJob;
    property Mgr: Variant read FMgr write FMgr;
    property HireDate: TDateTime read FHireDate write FHireDate;
    property Sal: Real read FSal write FSal;
    property Comm: Variant read FComm write FComm;
    property DeptNo: Integer read FDeptNo write FDeptNo;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ TDept }

constructor TDept.Create(const DeptNo: Integer; const DName, Loc: string);
begin
  inherited Create;
  FDeptNo := DeptNo;
  FDName := DName;
  FLoc := Loc;
end;

{ TEmp }

constructor TEmp.Create(const EmpNo: Integer; const EName, Job: String; const Mgr: Variant; 
  const HireDate: TDateTime; const Sal: Real; const Comm: Variant; DeptNo: Integer);
begin
  inherited Create;
  FEmpNo := EmpNo;
  FEName := EName;
  FJob := Job;
  FMgr := Mgr;
  FHireDate := HireDate;
  FSal := Sal;
  FComm := Comm;
  FDeptNo := DeptNo;
end;

function CompareDeptByDeptNo(Item1, Item2 : Pointer): Integer;
begin
  if TDept(Item1).DeptNo >  TDept(Item2).DeptNo then
    Result := 1
  else if TDept(Item1).DeptNo < TDept(Item2).DeptNo then
    Result := -1
  else
    Result := 0;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  DateFormat: TFormatSettings;
begin
  DeptList := TList.Create;
  DeptList.Add(TDept.Create(10, 'ACCOUNTING', 'NEW YORK'));
  DeptList.Add(TDept.Create(40, 'OPERATIONS', 'BOSTON'));
  DeptList.Add(TDept.Create(20, 'RESEARCH', 'DALLAS'));
  DeptList.Add(TDept.Create(30, 'SALES', 'CHICAGO'));
  DeptList.Sort(CompareDeptByDeptNo);

  DateFormat.DateSeparator := '-';
  DateFormat.ShortDateFormat := 'dd-mm-yyyy';

  EmpList := TList.Create;
  EmpList.Add(TEmp.Create(7369, 'SMITH', 'CLERK', 7902, StrToDateTime('17-12-1980', DateFormat), 800, NULL, 20));
  EmpList.Add(TEmp.Create(7499, 'ALLEN','SALESMAN',7698, StrToDateTime('20-2-1981', DateFormat), 1600, 300, 30));
  EmpList.Add(TEmp.Create(7521, 'WARD', 'SALESMAN', 7698, StrToDateTime('22-2-1981', DateFormat), 1250, 500, 30));
  EmpList.Add(TEmp.Create(7566, 'JONES', 'MANAGER', 7839, StrToDateTime('2-4-1981', DateFormat), 2975, NULL, 20));
  EmpList.Add(TEmp.Create(7654, 'MARTIN', 'SALESMAN', 7698, StrToDateTime('28-9-1981', DateFormat), 1250, 1400, 30));
  EmpList.Add(TEmp.Create(7698, 'BLAKE', 'MANAGER',7839, StrToDateTime('1-5-1981', DateFormat), 2850, NULL, 30));
  EmpList.Add(TEmp.Create(7782, 'CLARK', 'MANAGER', 7839, StrToDateTime('9-6-1981', DateFormat), 2450, NULL, 10));
  EmpList.Add(TEmp.Create(7788, 'SCOTT', 'ANALYST', 7566, StrToDateTime('13-7-1987', DateFormat), 3000, NULL, 20));
  EmpList.Add(TEmp.Create(7839, 'KING', 'PRESIDENT', NULL, StrToDateTime('17-11-1981', DateFormat), 5000, NULL, 10));
  EmpList.Add(TEmp.Create(7844, 'TURNER', 'SALESMAN', 7698, StrToDateTime('8-9-1981', DateFormat), 1500, 0, 30));
  EmpList.Add(TEmp.Create(7876, 'ADAMS', 'CLERK', 7788, StrToDateTime('13-7-1987', DateFormat), 1100, NULL, 20));
  EmpList.Add(TEmp.Create(7900, 'JAMES', 'CLERK', 7698, StrToDateTime('3-12-1981', DateFormat), 950, NULL, 30));
  EmpList.Add(TEmp.Create(7902, 'FORD', 'ANALYST', 7566, StrToDateTime('3-12-1981', DateFormat), 3000, NULL, 20));
  EmpList.Add(TEmp.Create(7934, 'MILLER', 'CLERK', 7782, StrToDateTime('23-1-1982', DateFormat), 1300, NULL, 10));

  DeptDataSet.FieldDefs.Add('DeptNo', ftInteger);
  DeptDataSet.FieldDefs.Add('DName', ftString, 14);
  DeptDataSet.FieldDefs.Add('Loc', ftString, 13);

  EmpDataSet.FieldDefs.Add('EmpNo', ftInteger);
  EmpDataSet.FieldDefs.Add('EName', ftString, 10);
  EmpDataSet.FieldDefs.Add('Job', ftString, 9);
  EmpDataSet.FieldDefs.Add('Mgr', ftInteger);
  EmpDataSet.FieldDefs.Add('HireDate', ftDate);
  EmpDataSet.FieldDefs.Add('Sal', ftFloat);
  EmpDataSet.FieldDefs.Add('Comm', ftFloat);
  EmpDataSet.FieldDefs.Add('DeptNo', ftInteger);

  EmpDataSet.MasterFields := 'DeptNo';
  EmpDataSet.DetailFields := 'DeptNo';

  EmpDataSet.MasterSource := DeptDataSource;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  DeptDataSet.Close;
  DeptDataSet.FieldDefs.Clear;
  EmpDataSet.Close;
  EmpDataSet.FieldDefs.Clear;

  for i := DeptList.Count-1 downto 0 do
    TDept(DeptList.Items[i]).Free;
  DeptList.Free;

  for i := EmpList.Count-1 downto 0 do
    TEmp(EmpList.Items[i]).Free;
  EmpList.Free;
end;

procedure TfmMain.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.btOpenClick(Sender: TObject);
begin
  DeptDataSet.Open;
  EmpDataSet.Open;
end;

procedure TfmMain.DeptDataSetGetFieldValue(Sender: TObject;
  Field: TField; RecNo: Integer; out Value: Variant);
var
  DeptItem: TDept;
begin
  DeptItem := TDept(DeptList.Items[RecNo-1]);
  case Field.FieldNo of
    1: Value := DeptItem.DeptNo;
    2: Value := DeptItem.DName;
    3: Value := DeptItem.Loc;
  end;
end;

procedure TfmMain.DeptDataSetGetRecordCount(Sender: TObject; out Count: Integer);
begin
  Count := DeptList.Count;
end;

procedure TfmMain.DeptDataSetInsertRecord(Sender: TObject; var RecNo: Integer);
var
  NewItem: TDept;
begin
  NewItem := TDept.Create(DeptDataSet.FieldByName('DeptNo').AsInteger, DeptDataSet.FieldByName('DName').AsString, DeptDataSet.FieldByName('Loc').AsString);
  DeptList.Insert(0, NewItem);
  DeptList.Sort(CompareDeptByDeptNo);
  RecNo := DeptList.IndexOf(NewItem) + 1;
end;

procedure TfmMain.EmpDataSetDeleteRecord(Sender: TObject; RecNo: Integer);
begin
  TEmp(EmpList.Items[RecNo-1]).Free;
  EmpList.Delete(RecNo-1);
end;

procedure TfmMain.EmpDataSetGetFieldValue(Sender: TObject; Field: TField;
  RecNo: Integer; out Value: Variant);
var
  EmpItem: TEmp;
begin
  EmpItem := TEmp(EmpList.Items[RecNo-1]);
  case Field.FieldNo of
    1: Value := EmpItem.EmpNo;
    2: Value := EmpItem.EName;
    3: Value := EmpItem.Job;
    4: Value := EmpItem.Mgr;
    5: Value := EmpItem.HireDate;
    6: Value := EmpItem.Sal;
    7: Value := EmpItem.Comm;
    8: Value := EmpItem.DeptNo;
  end;
end;

procedure TfmMain.EmpDataSetGetRecordCount(Sender: TObject; out Count: Integer);
begin
  Count := EmpList.Count;
end;

procedure TfmMain.EmpDataSetModifyRecord(Sender: TObject; var RecNo: Integer);
var
  Item: TEmp;
begin
  Item := TEmp(EmpList.Items[RecNo-1]);
  Item.FEmpNo := EmpDataSet.FieldByName('EmpNo').AsInteger;
  Item.FEName := EmpDataSet.FieldByName('EName').AsString;
  Item.FJob := EmpDataSet.FieldByName('Job').AsString;
  Item.FMgr := EmpDataSet.FieldByName('Mgr').AsVariant;
  Item.FHireDate := EmpDataSet.FieldByName('HireDate').AsDateTime;
  Item.FSal := EmpDataSet.FieldByName('Sal').AsFloat;
  Item.FComm := EmpDataSet.FieldByName('Comm').AsVariant;
  Item.FDeptNo := EmpDataSet.FieldByName('DeptNo').AsInteger;
end;

end.
