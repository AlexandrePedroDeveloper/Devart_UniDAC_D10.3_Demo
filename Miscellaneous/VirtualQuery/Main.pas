unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Buttons, Grids, DBGrids, ToolWin, ComCtrls, MemDS, MemData,
  DBAccess, DBClient, VirtualDataSet, VirtualTable, VirtualQuery, ExtCtrls,
  DBCtrls;

type
  TfmMain = class(TForm)
    DBGrid: TDBGrid;
    btClose: TSpeedButton;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    VirtualTable: TVirtualTable;
    VirtualDataSet: TVirtualDataSet;
    VirtualQuery: TVirtualQuery;
    DBNavigator: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    NoteData: TStringList;
    procedure OnGetRecordCount(Sender: TObject; out Count: Integer);
    procedure OnGetFieldValue(Sender: TObject; Field: TField; RecNo: Integer; out Value: Variant);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  VirtualTable.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Producer.xml');

  ClientDataSet.FieldDefs.Add('ID', ftInteger);
  ClientDataSet.FieldDefs.Add('ProducerID', ftInteger);
  ClientDataSet.FieldDefs.Add('ModelName', ftString, 64);
  ClientDataSet.CreateDataSet;
  ClientDataSet.Open;
  ClientDataSet.AppendRecord([9800, 10, 'Galaxy S7 Edge']);
  ClientDataSet.AppendRecord([9830, 10, 'Galaxy Note 5']);
  ClientDataSet.AppendRecord([1001, 20, 'iPhone 6']);
  ClientDataSet.AppendRecord([1356, 20, 'iPhone 6 Plus']);
  ClientDataSet.AppendRecord([3582, 40, 'Lumia 950 XL Dual Sim']);

  NoteData := TStringList.Create;
  NoteData.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NoteData.txt');

  VirtualDataSet.FieldDefs.Add('ID', ftInteger);
  VirtualDataSet.FieldDefs.Add('Specification', ftString, 512);
  VirtualDataSet.OnGetRecordCount := OnGetRecordCount;
  VirtualDataSet.OnGetFieldValue := OnGetFieldValue;

  VirtualTable.Open;
  ClientDataSet.Open;
  VirtualDataSet.Open;
  VirtualQuery.Open;

  VirtualQuery.FieldByName('ProducerName').ReadOnly := True;
  VirtualQuery.FieldByName('ModelName').ReadOnly := False;
  VirtualQuery.FieldByName('Specification').ReadOnly := False;
  VirtualQuery.UpdatingTable := 'Model';
  DataSource.DataSet := VirtualQuery;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  NoteData.Free;
end;

procedure TfmMain.OnGetFieldValue(Sender: TObject; Field: TField;
  RecNo: Integer; out Value: Variant);
const
  Delimeter = ' ; ';
var
  Row: String;
begin
  Row := NoteData.Strings[RecNo-1];
  case Field.FieldNo of
    1: Value := StrToInt(Copy(Row, 0, Pos(Delimeter, Row)-1));
    2: Value := Copy(Row, Pos(Delimeter, Row)+Length(Delimeter), Length(Row));
  end;
end;

procedure TfmMain.OnGetRecordCount(Sender: TObject; out Count: Integer);
begin
  Count := NoteData.Count;
end;

procedure TfmMain.btCloseClick(Sender: TObject);
begin
  Close;
end;

end.
