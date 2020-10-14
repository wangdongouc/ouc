unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Data.Win.ADODB, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, IdComponent, IdBaseComponent, IdUDPBase,
  IdUDPServer, IdGlobal, IdSocketHandle,DateUtils, Vcl.Samples.Spin, IdIPWatch,StrUtils,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeFunci, VCLTee.Series,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, IdCustomTCPServer, IdTCPServer;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ADOConnection1: TADOConnection;
    Timer1: TTimer;
    ListView1: TListView;
    ImageList1: TImageList;
    DBGridNode: TDBGrid;
    GB_Room: TGroupBox;
    Label1: TLabel;
    DBEditNodeName: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEditNodeID: TDBEdit;
    DBEditIP: TDBEdit;
    BtnSyn: TButton;
    BtnParam: TButton;
    GroupBox2: TGroupBox;
    DBGridData: TDBGrid;
    Timer2: TTimer;
    TabSheet5: TTabSheet;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox5: TGroupBox;
    Label11: TLabel;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    BtnReset: TButton;
    ComboBoxNodes: TComboBox;
    DateTimePickerStartDate: TDateTimePicker;
    IdUDPServer1: TIdUDPServer;
    BtnSearch: TButton;
    LabelPort: TLabel;
    LabelIP: TLabel;
    LabelDBIP: TLabel;
    BtnTest: TButton;
    BtnNode: TButton;
    BtnServer: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Memo1: TMemo;
    ADOQueryNode: TADOQuery;
    DataSourceNodes: TDataSource;
    BtnLog: TButton;
    BtnClear: TButton;
    DBEditLongitude: TDBEdit;
    Label2: TLabel;
    DBEditLatitude: TDBEdit;
    Label8: TLabel;
    DBEditPosX: TDBEdit;
    Label12: TLabel;
    DBEditPosY: TDBEdit;
    Label13: TLabel;
    Label18: TLabel;
    DBEditRemark: TDBEdit;
    Label19: TLabel;
    DBComboBox1: TDBComboBox;
    ADOQueryData: TADOQuery;
    DataSourceData: TDataSource;
    DateTimePickerStartTime: TDateTimePicker;
    DateTimePickerEndTime: TDateTimePicker;
    DateTimePickerEndDate: TDateTimePicker;
    Label14: TLabel;
    Label15: TLabel;
    CheckBoxNode: TCheckBox;
    CheckBoxTime: TCheckBox;
    ADOQueryAppend: TADOQuery;
    DBEditPort: TDBEdit;
    Label21: TLabel;
    DBEditInterval: TDBEdit;
    Label22: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DBChart1: TDBChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TFastLineSeries;
    TeeFunction1: TAverageTeeFunction;
    Series4: TFastLineSeries;
    TeeFunction2: TAverageTeeFunction;
    Series5: TLineSeries;
    Label23: TLabel;
    DBEditRoute: TDBEdit;
    procedure Timer1Timer(Sender: TObject);
    procedure IdUDPServer1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1Click(Sender: TObject);
    procedure IdUDPServer1UDPException(AThread: TIdUDPListenerThread;
      ABinding: TIdSocketHandle; const AMessage: string;
      const AExceptionClass: TClass);
    procedure BtnServerClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure CheckBoxNodeClick(Sender: TObject);
    procedure CheckBoxTimeClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
    procedure BtnNodeClick(Sender: TObject);
    procedure BtnTestClick(Sender: TObject);
    procedure BtnSynClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
    Node_Type=record
    NodeID:integer;
    NodeName:string;
    IPv6:string;
    Route:string;
    Port:integer;
    PosX:integer;
    PosY:integer;
    Longitude:double;
    Latitude:double;
    NoPant:integer;
  end;

const
  cPort:integer=3000;

var
  Form1: TForm1;
  TimerCount:integer;
  TimerInterval:integer;
  NodeCount:integer;
  Nodes:Array[0..32] of Node_Type;
  NodeID:integer;
  NodeName:string;
  Card:int64;
implementation

{$R *.dfm}

procedure TForm1.ADOConnection1AfterConnect(Sender: TObject);
var
  i:integer;
begin

  AdoqueryNode.Open;
  while not AdoqueryNode.Eof do
  begin
    Nodes[NodeCount].NodeID:=AdoqueryNode.FieldByName('NodeID').AsInteger;
    Nodes[NodeCount].NodeName:=AdoqueryNode.FieldByName('NodeName').AsString;
    Nodes[NodeCount].IPv6:=AdoqueryNode.FieldByName('IPv6').AsString;
    Nodes[NodeCount].Route:=AdoqueryNode.FieldByName('Route').AsString;
    Nodes[NodeCount].Port:=AdoqueryNode.FieldByName('Port').AsInteger;
    Nodes[NodeCount].PosX:=AdoqueryNode.FieldByName('PosX').AsInteger;
    Nodes[NodeCount].PosY:=AdoqueryNode.FieldByName('PosY').AsInteger;
    Nodes[NodeCount].Longitude:=AdoqueryNode.FieldByName('Longitude').AsFloat;
    Nodes[NodeCount].Latitude:=AdoqueryNode.FieldByName('Latitude').AsFloat;
    Nodes[NodeCount].NoPant:=0;
    ComboBoxNodes.Items.Add(Nodes[NodeCount].NodeName);
    NodeCount:=NodeCount+1;
    AdoqueryNode.Next;
  end;
  AdoqueryNode.First;
  ListView1.Clear;
  for i:=0 to NodeCount-1 do
  begin
    with listview1.items.add do
    begin
      caption:=Nodes[i].NodeName;
      imageindex:=0
    end;
  end;
//  ComboBox4.ItemIndex:=0;
  Statusbar1.Panels[1].Text:='节点数量:'+IntToStr(NodeCount);
end;

procedure TForm1.BtnClearClick(Sender: TObject);
var
  filename:string;
begin
  filename:=DateTimeToStr(now);
  filename:=StringReplace(filename,':','',[rfReplaceAll]);
  filename:=StringReplace(filename,'/','',[rfReplaceAll]);
  filename:=StringReplace(filename,' ','',[rfReplaceAll])+'.txt';
  memo1.Lines.SaveToFile(filename);
  memo1.Lines.Clear;
end;

procedure TForm1.BtnNodeClick(Sender: TObject);
begin
  Memo1.Lines.Add( '['+DateTimeToStr(now)+'] Send start command to: '+DBEditNodeName.Text+'  '+DBEditIP.Text);
  IdUDPServer1.Send(DBEditRoute.Text,StrToInt(DBEditPort.Text),'start');
end;

procedure TForm1.BtnResetClick(Sender: TObject);
begin
  Memo1.Lines.Add( '['+DateTimeToStr(now)+'] Send reset command to: '+DBEditNodeName.Text+'  '+DBEditIP.Text);
  IdUDPServer1.Send(DBEditRoute.Text,StrToInt(DBEditPort.Text),'reset');
end;

procedure TForm1.BtnSearchClick(Sender: TObject);
var
  sql:string;
begin
  if CheckBoxNode.Checked or CheckBoxTime.Checked then
  begin
    sql:='select * from collect_data where NodeID >0 ';
    if CheckBoxNode.Checked then
    begin
      if ComboBoxNodes.ItemIndex>0 then
         sql:=sql+'and NodeName='''+ComboBoxNodes.Text+'''';
    end;
    if CheckBoxTime.Checked then
    begin

    end;
    AdoQueryData.SQL.Clear;
    AdoQueryData.SQL.Add(sql);
    AdoQueryData.Open;
  end
  else
    ShowMessage('请选择检索项');
end;

procedure TForm1.BtnServerClick(Sender: TObject);
begin
  if IdUDPServer1.Active then
  begin
     IdUDPServer1.Active:=false;
     BtnServer.Caption:='开启服务';
     BtnNode.Enabled:=false;
     BtnReset.Enabled:=false;
     BtnSyn.Enabled:=false;
     BtnTest.Enabled:=false;
     BtnParam.Enabled:=false;
     BtnLog.Enabled:=false;
  end
  else
  begin
     IdUDPServer1.Active:=true;
     BtnServer.Caption:='关闭服务';
     BtnNode.Enabled:=true;
     BtnReset.Enabled:=true;
     BtnSyn.Enabled:=true;
     BtnTest.Enabled:=true;
     BtnParam.Enabled:=true;
     BtnLog.Enabled:=true;
  end;
end;

procedure TForm1.BtnSynClick(Sender: TObject);
begin
  Memo1.Lines.Add( '['+DateTimeToStr(now)+'] Send timesyn command to: '+DBEditNodeName.Text+'  '+DBEditIP.Text);
  IdUDPServer1.Send(DBEditRoute.Text,StrToInt(DBEditPort.Text),DateTimeToStr(now));
end;

procedure TForm1.BtnTestClick(Sender: TObject);
begin
  Memo1.Lines.Add( '['+DateTimeToStr(now)+'] Send test command to: '+DBEditNodeName.Text+'  '+DBEditIP.Text);
  IdUDPServer1.Send(LabelDBIP.Caption,StrToInt(DBEditPort.Text),'route');
end;

procedure TForm1.CheckBoxNodeClick(Sender: TObject);
begin
  if CheckBoxNode.Checked then
  begin
    ComboBoxNodes.Enabled:=true;
  end
  else
    ComboBoxNodes.Enabled:=false;
end;

procedure TForm1.CheckBoxTimeClick(Sender: TObject);
begin
  if CheckBoxTime.Checked then
  begin
    DateTimePickerStartDate.Enabled:=true;
    DateTimePickerEndDate.Enabled:=true;
    DateTimePickerStartTime.Enabled:=true;
    DateTimePickerEndTime.Enabled:=true;
  end
  else
  begin
    DateTimePickerStartDate.Enabled:=false;
    DateTimePickerEndDate.Enabled:=false;
    DateTimePickerStartTime.Enabled:=false;
    DateTimePickerEndTime.Enabled:=false;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  filename:string;
begin
  filename:=DateTimeToStr(now);
  filename:=StringReplace(filename,':','',[rfReplaceAll]);
  filename:=StringReplace(filename,'/','',[rfReplaceAll]);
  filename:=StringReplace(filename,' ','',[rfReplaceAll])+'.txt';
  memo1.Lines.SaveToFile(filename);
  memo1.Lines.Clear;
  IdUDPServer1.Active:= false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IdIPWatch: TIdIPWatch;
begin
  if IdUDPServer1.Active then
  begin
     BtnServer.Caption:='关闭服务';
     BtnNode.Enabled:=true;
     BtnReset.Enabled:=true;
     BtnSyn.Enabled:=true;
     BtnTest.Enabled:=true;
     BtnParam.Enabled:=true;
     BtnLog.Enabled:=true;
  end
  else
  begin
     BtnServer.Caption:='开启服务';
     BtnNode.Enabled:=false;
     BtnReset.Enabled:=false;
     BtnSyn.Enabled:=false;
     BtnTest.Enabled:=false;
     BtnParam.Enabled:=false;
     BtnLog.Enabled:=false;
  end;

  LabelIP.caption:=IdUDPServer1.Binding.IP;
  LabelPort.caption:=inttostr(IdUDPServer1.Binding.Port);

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ADOConnection1.Connected:=true;

end;

procedure TForm1.IdUDPServer1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Statusbar1.Panels[0].Text:=AStatusText;
end;

procedure TForm1.IdUDPServer1UDPException(AThread: TIdUDPListenerThread;
  ABinding: TIdSocketHandle; const AMessage: string;
  const AExceptionClass: TClass);
begin
  Statusbar1.Panels[0].Text:=AMessage;
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  buf:array [1..1024] of char;
  i,paramcount:integer;
  recs:string;
  params: TStringList;

begin
  for i := 1 to length(AData) do
  begin
       buf[i]:=chr(AData[i-1]);
       recs:=recs+buf[i];
  end;
  Statusbar1.Panels[0].Text:= '['+DateTimeToStr(now)+'] '+ABinding.PeerIP+'   '+inttostr(ABinding.PeerPort);
  Memo1.Lines.Add( '['+DateTimeToStr(now)+'] Received From: '+ABinding.PeerIP+'   '+inttostr(ABinding.PeerPort)+' '+inttostr(length(AData))+'Bytes');
  Memo1.Lines.Add(recs);
  if (length(recs)>24) then
  begin
    params:=TStringList.Create;
    paramcount:=ExtractStrings(['|',':'],['#',' '],PChar(recs),params);
    if paramcount>7 then
    begin
      NodeID:=0;
      for i := 0 to NodeCount-1 do
      begin
        if Pos(params[7],Nodes[i].IPv6)>0 then
        begin
          ListView1.Items[i].ImageIndex:=1;
          Nodes[i].NoPant :=0;
          NodeID:=Nodes[i].NodeID;
          NodeName:=Nodes[i].NodeName;
        end;
      end;
    end;



    if (NodeID>0) and (paramcount>16)then
    begin
      params:=TStringList.Create;
      paramcount:=ExtractStrings(['|',':'],['#',' '],PChar(recs),params);
      AdoQueryAppend.Open;
      AdoQueryAppend.Append;
      AdoQueryAppend.Fields[1].AsInteger:=NodeID;
      AdoQueryAppend.Fields[2].AsString:=NodeName;
      for i := 0 to 9 do
        if (i mod 2)=0 then
           AdoQueryAppend.Fields[i+3].AsString:=Params[i+8]
        else
          AdoQueryAppend.Fields[i+3].AsFloat:=StrToFloat(Params[i+8]);
      AdoQueryAppend.Fields[13].AsDateTime:=now;
      AdoQueryAppend.Post;
      params.Free;
    end;
  end;

  //IdUDPServer1.Send(ABinding.PeerIP,ABinding.PeerPort,'received');
end;

procedure TForm1.ListView1Click(Sender: TObject);
var
  i:integer;
begin
  AdoqueryNode.First;
  for i:=0 to ListView1.ItemIndex-1 do
  begin
    AdoqueryNode.Next;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
  buf:array [0..31 ]of Byte;
begin
  StatusBar1.Panels[2].Text:='当前时间:'+DateTimeToStr(now());
  Inc(TimerCount);
  for i := 0 to NOdeCount-1 do
  begin
    Inc(Nodes[i].NoPant);
    if Nodes[i].NoPant>15 then
      ListView1.Items[i].ImageIndex:=0;
  end;

end;

end.
