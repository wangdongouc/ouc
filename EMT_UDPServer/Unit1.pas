unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, IdGlobal,
  IdSocketHandle, Vcl.ComCtrls, Data.Win.ADODB, System.ImageList, Vcl.ImgList,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    IdUDPServer1: TIdUDPServer;
    Memo1: TMemo;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ListView1: TListView;
    ImageList1: TImageList;
    Timer1: TTimer;
    ADOQuery2: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure IdUDPServer1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  type
    Terminal_Type=record
    TerminalName:string;
    DeviceID:integer;
    Pant:integer;
  end;
var


  Form1: TForm1;
  TerminalCount:integer;
  Terminal:Array[0..255] of Terminal_Type;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  IdUDPServer1.DefaultPort:= 8080;
  IdUDPServer1.Active:= true;
  TerminalCount:=0;

  Adoquery2.Open;
  while not Adoquery2.Eof do
  begin

    Terminal[TerminalCount].TerminalName:=Adoquery2.FieldByName('RoomName').AsString;
    Terminal[TerminalCount].DeviceID:=Adoquery2.FieldByName('DeviceId').AsInteger;
    Terminal[TerminalCount].Pant:=0;
    TerminalCount:=TerminalCount+1;
    Adoquery2.Next;
  end;
  ListView1.Clear;
  for i:=0 to TerminalCount-1 do
  begin
    with listview1.items.add do
    begin
      caption:=Terminal[i].TerminalName;
      imageindex:=0;
    end;
  end;
  Statusbar1.Panels[1].Text:='设备:'+IntToStr(TerminalCount);
end;

procedure TForm1.IdUDPServer1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Statusbar1.Panels[0].Text:=AStatusText;
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  str:string;
  strcnt:integer;
  ts:TStringList;
  i,devid:integer;
begin
  str:=Trim(BytesToString(AData));
  str:=StringReplace(str,'AirInspection:','',[rfReplaceAll]);
  if length(str)>0 then
  begin
    if Memo1.Lines.Count>50 then
      Memo1.Clear;
    Memo1.Lines.Add(str);
    ts:=TStringList.Create;
    try
      strcnt:=ExtractStrings(['|'],[' '],PChar(str),ts);
      devid:=StrToInt(ts[0]);
      for i:=0 to TerminalCount-1 do
      begin
        if Terminal[i].DeviceID=devid then
        begin
          listview1.items[i].ImageIndex:=1;
       end;
      end;
      if strcnt=8 then
      begin
        Adoquery1.Append;
        Adoquery1.FieldValues['DeviceID']:=ts[0];
        Adoquery1.FieldValues['PM1']:=ts[1];
        Adoquery1.FieldValues['PM25']:=ts[2];
        Adoquery1.FieldValues['PM10']:=ts[3];
        Adoquery1.FieldValues['Temperature']:=ts[4];
        Adoquery1.FieldValues['Humidity']:=ts[5];
        Adoquery1.FieldValues['CO2']:=ts[6];
        Adoquery1.FieldValues['InspectTime']:=ts[7];
        Adoquery1.Post;

      end;
    finally
      ts.Free;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  StatusBar1.Panels[2].Text:= '当前时间:'+DateTimeToStr(now());
  for i:=0 to TerminalCount-1 do
  begin
    Terminal[i].Pant:= Terminal[i].Pant +1;
    if Terminal[i].Pant>100 then
    begin
      listview1.items[i].ImageIndex:=0;
      Terminal[i].Pant:= 0;
    end;
  end;
end;

end.
