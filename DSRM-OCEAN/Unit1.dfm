object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #28023#27915#20256#24863#22120#25968#25454#37319#38598#31243#24207
  ClientHeight = 726
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 707
    Width = 674
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 674
    Height = 425
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #33410#28857#31649#29702
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 666
        Height = 120
        Align = alTop
        Columns = <>
        LargeImages = ImageList1
        ReadOnly = True
        SmallImages = ImageList1
        TabOrder = 0
        OnClick = ListView1Click
      end
      object DBGridNode: TDBGrid
        Left = 0
        Top = 259
        Width = 666
        Height = 113
        Align = alClient
        DataSource = DataSourceNodes
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NodeName'
            Title.Caption = #33410#28857#21517#31216
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IPv6'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Port'
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Status'
            Title.Caption = #29366#24577
            Width = 36
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Longitude'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Latitude'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PosX'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PosY'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Interval'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Remark'
            Visible = True
          end>
      end
      object GB_Room: TGroupBox
        Left = 0
        Top = 120
        Width = 666
        Height = 139
        Align = alTop
        Caption = #33410#28857#35774#32622
        TabOrder = 2
        object Label1: TLabel
          Left = 12
          Top = 50
          Width = 60
          Height = 13
          Caption = #33410#28857#21517#31216#65306
        end
        object Label4: TLabel
          Left = 12
          Top = 23
          Width = 47
          Height = 13
          Caption = #33410#28857'ID'#65306
        end
        object Label5: TLabel
          Left = 12
          Top = 77
          Width = 22
          Height = 13
          Caption = 'IP'#65306
        end
        object Label2: TLabel
          Left = 492
          Top = 23
          Width = 59
          Height = 13
          Caption = 'Longitude'#65306
        end
        object Label8: TLabel
          Left = 500
          Top = 50
          Width = 51
          Height = 13
          Caption = 'Latitude'#65306
        end
        object Label12: TLabel
          Left = 347
          Top = 23
          Width = 35
          Height = 13
          Caption = 'PosX'#65306
        end
        object Label13: TLabel
          Left = 347
          Top = 50
          Width = 35
          Height = 13
          Caption = 'PosY'#65306
        end
        object Label18: TLabel
          Left = 184
          Top = 23
          Width = 36
          Height = 13
          Caption = #29366#24577#65306
        end
        object Label19: TLabel
          Left = 515
          Top = 77
          Width = 36
          Height = 13
          Caption = #22791#27880#65306
        end
        object Label21: TLabel
          Left = 184
          Top = 77
          Width = 32
          Height = 13
          Caption = 'Port'#65306
        end
        object Label22: TLabel
          Left = 184
          Top = 50
          Width = 36
          Height = 13
          Caption = #38388#38548#65306
        end
        object Label23: TLabel
          Left = 346
          Top = 77
          Width = 41
          Height = 13
          Caption = 'Route'#65306
        end
        object DBEditNodeName: TDBEdit
          Left = 78
          Top = 46
          Width = 80
          Height = 21
          DataField = 'NodeName'
          DataSource = DataSourceNodes
          TabOrder = 0
        end
        object DBEditNodeID: TDBEdit
          Left = 78
          Top = 19
          Width = 80
          Height = 21
          DataField = 'NodeID'
          DataSource = DataSourceNodes
          Enabled = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEditIP: TDBEdit
          Left = 78
          Top = 73
          Width = 80
          Height = 21
          DataField = 'IPv6'
          DataSource = DataSourceNodes
          TabOrder = 2
        end
        object BtnSyn: TButton
          Left = 255
          Top = 100
          Width = 75
          Height = 25
          Caption = #33410#28857#23545#26102
          TabOrder = 3
          OnClick = BtnSynClick
        end
        object BtnParam: TButton
          Left = 417
          Top = 100
          Width = 75
          Height = 25
          Caption = #19979#21457#21442#25968
          TabOrder = 4
        end
        object BtnReset: TButton
          Left = 174
          Top = 100
          Width = 75
          Height = 25
          Caption = #37325#21551#33410#28857
          TabOrder = 5
          OnClick = BtnResetClick
        end
        object BtnTest: TButton
          Left = 336
          Top = 100
          Width = 75
          Height = 25
          Caption = #27979#35797#33410#28857
          TabOrder = 6
          OnClick = BtnTestClick
        end
        object BtnNode: TButton
          Left = 93
          Top = 100
          Width = 75
          Height = 25
          Caption = #24320#21551#33410#28857
          TabOrder = 7
          OnClick = BtnNodeClick
        end
        object BtnServer: TButton
          Left = 12
          Top = 100
          Width = 75
          Height = 25
          Caption = #24320#21551#26381#21153
          TabOrder = 8
          OnClick = BtnServerClick
        end
        object BtnLog: TButton
          Left = 498
          Top = 100
          Width = 75
          Height = 25
          Caption = #35835#21462#26085#24535
          TabOrder = 9
        end
        object BtnClear: TButton
          Left = 579
          Top = 100
          Width = 75
          Height = 25
          Caption = #28165#31354#21015#34920
          TabOrder = 10
          OnClick = BtnClearClick
        end
        object DBEditLongitude: TDBEdit
          Left = 557
          Top = 19
          Width = 80
          Height = 21
          DataField = 'Longitude'
          DataSource = DataSourceNodes
          TabOrder = 11
        end
        object DBEditLatitude: TDBEdit
          Left = 557
          Top = 46
          Width = 80
          Height = 21
          DataField = 'Latitude'
          DataSource = DataSourceNodes
          TabOrder = 12
        end
        object DBEditPosX: TDBEdit
          Left = 388
          Top = 19
          Width = 80
          Height = 21
          DataField = 'PosX'
          DataSource = DataSourceNodes
          TabOrder = 13
        end
        object DBEditPosY: TDBEdit
          Left = 388
          Top = 46
          Width = 80
          Height = 21
          DataField = 'PosY'
          DataSource = DataSourceNodes
          TabOrder = 14
        end
        object DBEditRemark: TDBEdit
          Left = 557
          Top = 73
          Width = 80
          Height = 21
          DataField = 'Remark'
          DataSource = DataSourceNodes
          TabOrder = 15
        end
        object DBComboBox1: TDBComboBox
          Left = 236
          Top = 19
          Width = 80
          Height = 21
          DataField = 'Status'
          DataSource = DataSourceNodes
          Items.Strings = (
            #27491#24120
            #26242#20572
            #25925#38556)
          TabOrder = 16
        end
        object DBEditPort: TDBEdit
          Left = 236
          Top = 73
          Width = 80
          Height = 21
          DataField = 'Port'
          DataSource = DataSourceNodes
          TabOrder = 17
        end
        object DBEditInterval: TDBEdit
          Left = 236
          Top = 46
          Width = 80
          Height = 21
          DataField = 'Interval'
          DataSource = DataSourceNodes
          TabOrder = 18
        end
        object DBEditRoute: TDBEdit
          Left = 388
          Top = 73
          Width = 80
          Height = 21
          DataField = 'Route'
          DataSource = DataSourceNodes
          TabOrder = 19
        end
      end
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 372
        Width = 666
        Height = 25
        DataSource = DataSourceNodes
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbRefresh]
        Align = alBottom
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = #30417#27979#35760#24405
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 666
        Height = 121
        Align = alTop
        Caption = #35760#24405#35814#32454#24773#20917
        TabOrder = 0
        object Label14: TLabel
          Left = 271
          Top = 66
          Width = 14
          Height = 13
          Caption = 'to:'
        end
        object Label15: TLabel
          Left = 84
          Top = 66
          Width = 26
          Height = 13
          Caption = 'from:'
        end
        object ComboBoxNodes: TComboBox
          Left = 116
          Top = 24
          Width = 145
          Height = 21
          Enabled = False
          ItemIndex = 0
          TabOrder = 0
          Text = #20840#37096
          Items.Strings = (
            #20840#37096)
        end
        object BtnSearch: TButton
          Left = 480
          Top = 81
          Width = 75
          Height = 25
          Caption = 'Search..'
          TabOrder = 1
          OnClick = BtnSearchClick
        end
        object DateTimePickerEndTime: TDateTimePicker
          Left = 291
          Top = 85
          Width = 145
          Height = 21
          Date = 43187.864450497680000000
          Time = 43187.864450497680000000
          Enabled = False
          Kind = dtkTime
          TabOrder = 2
        end
        object DateTimePickerEndDate: TDateTimePicker
          Left = 291
          Top = 58
          Width = 145
          Height = 21
          Date = 43187.864450497680000000
          Time = 43187.864450497680000000
          Enabled = False
          TabOrder = 3
        end
        object CheckBoxNode: TCheckBox
          Left = 16
          Top = 26
          Width = 49
          Height = 17
          Caption = #33410#28857
          TabOrder = 4
          OnClick = CheckBoxNodeClick
        end
        object CheckBoxTime: TCheckBox
          Left = 16
          Top = 64
          Width = 49
          Height = 17
          Caption = #26102#38388
          TabOrder = 5
          OnClick = CheckBoxTimeClick
        end
      end
      object DateTimePickerStartDate: TDateTimePicker
        Left = 116
        Top = 58
        Width = 145
        Height = 21
        Date = 43187.864450497680000000
        Time = 43187.864450497680000000
        Enabled = False
        TabOrder = 1
      end
      object DateTimePickerStartTime: TDateTimePicker
        Left = 116
        Top = 85
        Width = 145
        Height = 21
        Date = 43187.864450497680000000
        Time = 43187.864450497680000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 2
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 121
        Width = 666
        Height = 276
        ActivePage = TabSheet3
        Align = alClient
        TabOrder = 3
        object TabSheet3: TTabSheet
          Caption = #25968#25454#21015#34920
          object DBNavigator2: TDBNavigator
            Left = 0
            Top = 223
            Width = 658
            Height = 25
            DataSource = DataSourceData
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh, nbApplyUpdates]
            Align = alBottom
            TabOrder = 0
          end
          object DBGridData: TDBGrid
            Left = 0
            Top = 0
            Width = 658
            Height = 223
            Align = alClient
            DataSource = DataSourceData
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'NodeName'
                Title.Caption = #33410#28857
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CollectTime'
                Title.Caption = #26102#38388
                Width = 110
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataName1'
                Title.Caption = #21442#25968'1'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataValue1'
                Title.Caption = #25968#20540'1'
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataName2'
                Title.Caption = #21442#25968'2'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataValue2'
                Title.Caption = #25968#20540'2'
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataName3'
                Title.Caption = #21442#25968'3'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataValue3'
                Title.Caption = #25968#20540'3'
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataName4'
                Title.Caption = #21442#25968'4'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataValue4'
                Title.Caption = #25968#20540'4'
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataName5'
                Title.Caption = #21442#25968'5'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DataValue5'
                Title.Caption = #25968#20540'5'
                Width = 48
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NodeID'
                Title.Caption = #33410#28857#32534#21495
                Width = 55
                Visible = True
              end>
          end
        end
        object TabSheet4: TTabSheet
          Caption = #25968#25454#22270#24418
          ImageIndex = 1
          object DBChart1: TDBChart
            Left = 0
            Top = 0
            Width = 658
            Height = 248
            Title.Text.Strings = (
              #25968#25454#21464#21270)
            View3D = False
            Align = alClient
            TabOrder = 0
            AutoSize = True
            DefaultCanvas = 'TGDIPlusCanvas'
            ColorPaletteIndex = 21
            object Series1: TLineSeries
              DataSource = ADOQueryData
              Title = #28201#24230
              Brush.BackColor = clDefault
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              XValues.ValueSource = 'CollectTime'
              YValues.Name = 'Y'
              YValues.Order = loNone
              YValues.ValueSource = 'DataValue1'
            end
            object Series2: TLineSeries
              DataSource = ADOQueryData
              Title = #28287#24230
              Brush.BackColor = clDefault
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              XValues.ValueSource = 'CollectTime'
              YValues.Name = 'Y'
              YValues.Order = loNone
              YValues.ValueSource = 'DataValue2'
            end
            object Series3: TFastLineSeries
              DataSource = ADOQueryData
              Title = #20809#29031#24230
              LinePen.Color = 12109166
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              XValues.ValueSource = 'CollectTime'
              YValues.Name = 'Y'
              YValues.Order = loNone
              YValues.ValueSource = 'DataValue3'
              object TeeFunction1: TAverageTeeFunction
                CalcByValue = False
              end
            end
            object Series4: TFastLineSeries
              DataSource = ADOQueryData
              Title = 'TDS'
              LinePen.Color = 11129064
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              XValues.ValueSource = 'CollectTime'
              YValues.Name = 'Y'
              YValues.Order = loNone
              YValues.ValueSource = 'DataValue4'
              object TeeFunction2: TAverageTeeFunction
                CalcByValue = False
              end
            end
            object Series5: TLineSeries
              DataSource = DataSourceData
              Title = #27978#24230
              Brush.BackColor = clDefault
              Pointer.InflateMargins = True
              Pointer.Style = psRectangle
              XValues.DateTime = True
              XValues.Name = 'X'
              XValues.Order = loAscending
              XValues.ValueSource = 'CollectTime'
              YValues.Name = 'Y'
              YValues.Order = loNone
              YValues.ValueSource = 'DataValue5'
            end
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #36816#34892#35774#32622
      ImageIndex = 4
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 666
        Height = 89
        Align = alTop
        Caption = #26412#26426#31471#21475
        TabOrder = 0
        object Label9: TLabel
          Left = 16
          Top = 24
          Width = 38
          Height = 13
          Caption = #26412#26426'IP:'
        end
        object Label10: TLabel
          Left = 16
          Top = 56
          Width = 28
          Height = 13
          Caption = #31471#21475':'
        end
        object LabelPort: TLabel
          Left = 80
          Top = 56
          Width = 45
          Height = 13
          Caption = 'LabelPort'
        end
        object LabelIP: TLabel
          Left = 80
          Top = 24
          Width = 35
          Height = 13
          Caption = 'LabelIP'
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 178
        Width = 666
        Height = 89
        Align = alTop
        Caption = 'RPL'#26381#21153#22120#37197#32622
        TabOrder = 1
        object Label11: TLabel
          Left = 16
          Top = 24
          Width = 106
          Height = 13
          Caption = 'RPL Border Router IP:'
        end
        object LabelDBIP: TLabel
          Left = 152
          Top = 24
          Width = 100
          Height = 13
          Caption = 'BBBB:0:0:0:0:0:0:20'
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 89
        Width = 666
        Height = 89
        Align = alTop
        Caption = #25968#25454#24211#37197#32622
        TabOrder = 2
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 74
          Height = 13
          Caption = 'SQLSERVER IP:'
        end
        object Label6: TLabel
          Left = 16
          Top = 56
          Width = 28
          Height = 13
          Caption = #29992#25143':'
        end
        object Label7: TLabel
          Left = 256
          Top = 56
          Width = 28
          Height = 13
          Caption = #23494#30721':'
        end
        object Label16: TLabel
          Left = 104
          Top = 24
          Width = 84
          Height = 13
          Caption = '222.195.226.140'
        end
        object Label17: TLabel
          Left = 104
          Top = 56
          Width = 11
          Height = 13
          Caption = 'sa'
        end
        object Label20: TLabel
          Left = 304
          Top = 56
          Width = 54
          Height = 13
          Caption = '*********'
        end
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 425
    Width = 674
    Height = 282
    Align = alClient
    TabOrder = 2
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=X!wszdls403;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=Monitor;Data Source=2001:da8:270:' +
      '2021::cb'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    AfterConnect = ADOConnection1AfterConnect
    Left = 16
    Top = 456
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 88
    Top = 456
  end
  object ImageList1: TImageList
    Height = 48
    Width = 48
    Left = 16
    Top = 520
    Bitmap = {
      494C010102003400C80030003000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000C00000003000000001002000000000000090
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFF5F5F5FFFFFF
      FFFFFAFAFAFFFAFAFAFFFFFFFFFFFFFFFFFFFAFAFAFFF5F5F5FFD0D0D0FFD7D7
      D7FFEEEEEEFFFFFFFFFFFCFCFCFFF5F5F5FFFBFBFBFFF8F8F8FFFBFBFBFFF8F8
      F8FFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
      FDFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFEFEFEFFFBFBFBFFFEFE
      FEFFFDFDFDFFFAFAFAFFFDFDFDFFFEFEFEFFFEFEFEFFFEFEFEFFFCFCFCFFFCFC
      FCFFFCFCFCFFFCFCFCFFFDFDFDFFFDFDFDFFFBFBFBFFFCFCFCFFFBFBFBFFFCFC
      FCFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFEFEFEFFFEFEFEFFFEFEFEFFFCFC
      FCFFFDFDFDFFFEFEFEFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7FFFFFFFFFFF6F6
      F6FFBFBFBFFF838383FF3F3F3FFF1B1B1BFF2F2F2FFF303030FF515151FF8C8C
      8CFF5C5C5CFF424242FF242424FF2D2D2DFF828282FFD9D9D9FFFEFEFEFFFCFC
      FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFCFCFCFFF9F9F9FFF7F7F7FFF6F6F6FFF2F2F2FFEFEFEFFFEDED
      EDFFE9E9E9FFE6E6E6FFE4E4E4FFE0E0E0FFDDDDDDFFD7D7D7FFD0D0D0FFD0D0
      D0FFD7D7D7FFD6D6D6FFD5D5D5FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4
      D4FFD4D4D4FFD4D4D4FFD6D6D6FFD8D8D8FFD9D9D9FFE1E1E1FFE2E2E2FFE4E4
      E4FFE8E8E8FFEAEAEAFFECECECFFF0F0F0FFF3F3F3FFF6F6F6FFF9F9F9FFFDFD
      FDFFFDFDFDFFFEFEFEFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF323232FF9B9B
      9BFFCBCBCBFFE0E0E0FFE1E1E1FFEBEBEBFFE6E6E6FFE6E6E6FFE6E6E6FFDADA
      DAFFE0E0E0FFE1E1E1FFE5E5E5FFE7E7E7FFDFDFDFFFD2D2D2FFBDBDBDFFAFAF
      AFFFE5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFFFFFFFFFCFCFCFFFAFAFAFFF5F5F5FFEFEFEFFFEBEBEBFFE8E8
      E8FFE3E3E3FFDFDFDFFFDBDBDBFFD6D6D6FFD2D2D2FFCACACAFFAEAEAEFFC3C3
      C3FFCDCDCDFFCFCFCFFFD2D2D2FFCFCFCFFFCFCFCFFFCFCFCFFFD0D0D0FFD0D0
      D0FFD0D0D0FFCCCCCCFFB5B5B5FFAAAAAAFFD6D6D6FFD1D1D1FFD9D9D9FFDBDB
      DBFFE1E1E1FFE5E5E5FFE7E7E7FFEDEDEDFFF2F2F2FFF6F6F6FFFAFAFAFFFEFE
      FEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFF999999FFADAD
      ADFFA5A5A5FFA3A3A3FFA9A9A9FFB3B3B3FFC1C1C1FFD3D3D3FFEBEBEBFFF3F3
      F3FFF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFBFBFBFFF9F9F9FFF7F7F7FFF5F5
      F5FFF2F2F2FFF0F0F0FFEDEDEDFFEAEAEAFFE8E8E8FFE7E7E7FFDBDBDBFFBBBB
      BBFFB2B2B2FFAFAFAFFFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFB1B1
      B1FFB1B1B1FFAFAFAFFFC7C7C7FFDADADAFFE2E2E2FFEBEBEBFFEBEBEBFFECEC
      ECFFF0F0F0FFF3F3F3FFF4F4F4FFF6F6F6FFFBFBFBFFFDFDFDFFFFFFFFFFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8A8A8AFFCBCB
      CBFFC9C9C9FFCBCBCBFFC9C9C9FFC8C8C8FFD4D4D4FFFFFFFFFFFDFDFDFFFBFB
      FBFFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFD
      FDFFA1A1A1FFA3A3A3FFA1A1A1FFA4A4A4FFA4A4A4FFA5A5A5FFA6A6A6FFA9A9
      A9FFAAAAAAFFB5B5B5FFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBDBDBFFC2C2
      C2FFB8B8B8FFB9B9B9FFB9B9B9FFBCBCBCFFC3C3C3FFFFFFFFFFFDFDFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFBFBFBFFFFFF
      FFFFBCBCBCFFC1C1C1FFC0C0C0FFBEBEBEFFBFBFBFFFBFBFBFFFC0C0C0FFC0C0
      C0FFC0C0C0FFD0D0D0FFFDFDFDFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFDFEFFFFFDFEFFFFFFFFFFF9F7F8FFFFFFFFFF7E7C
      7DFF9E9C9DFF9B999AFFA6A4A5FFA5A3A4FFAAA8A9FFC3C1C2FFF7F5F6FFFEFC
      FDFFFFFFFFFFFFFDFEFFFDFBFCFFFCFAFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFD
      FDFFFCFCFCFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFF909090FF8E8E8EFF919191FF8F8F8FFF8E8E8EFF8D8D8DFF8C8C8CFF8B8B
      8BFF8B8B8BFFC1C1C1FFFBFBFBFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFFDFDFDFFFFFF
      FFFFFEFEFEFFFFFFFFFFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFF8181
      81FF8B8B8BFF8A8A8AFF8D8D8DFF8F8F8FFF8D8D8DFF9A9A9AFFFFFFFFFFFFFF
      FFFFFAFAFAFFFBFBFBFFFBFBFBFFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFEFE
      FEFFFDFDFDFFF1F1F1FFCBCBCBFFB9B9B9FFBBBBBBFFBBBBBBFFBCBCBCFFBCBC
      BCFFBCBCBCFFBCBCBCFFBDBDBDFFBDBDBDFFBDBDBDFFBDBDBDFFBDBDBDFFBDBD
      BDFF747474FF707070FF717171FF6E6E6EFF6E6E6EFF6E6E6EFF6F6F6FFF6E6E
      6EFF6E6E6EFF999999FFBABABAFFBFBFBFFFBCBCBCFFBDBDBDFFBDBDBDFFBCBC
      BCFFBCBCBCFFBDBDBDFFBDBDBDFFBDBDBDFFBFBFBFFFBBBBBBFFBCBCBCFFD4D4
      D4FFFBFBFBFFFDFDFDFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9BFF646464FF5959
      59FF696969FF747474FF919191FFAEAEAEFFC1C1C1FFD3D3D3FFF3F3F3FFFFFF
      FFFF606060FF666666FF666666FF676767FF6F6F6FFF747474FFEEEEEEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFBFBFBFFC9C9C9FFDFDFDFFFE1E1E1FFE6E6E6FFE8E8E8FFE9E9E9FFEBEB
      EBFFEEEEEEFFF0F0F0FFF1F1F1FFF2F2F2FFF2F2F2FFF3F3F3FFF5F5F5FFF8F8
      F8FFFAFAFAFFF5F5F5FFF5F5F5FFF8F8F8FFF8F8F8FFF8F8F8FFF7F7F7FFF6F6
      F6FFF5F5F5FFF8F8F8FFFAFAFAFFF0F0F0FFF4F4F4FFF2F2F2FFF1F1F1FFF1F1
      F1FFEFEFEFFFECECECFFEBEBEBFFE9E9E9FFE6E6E6FFE3E3E3FFE2E2E2FFE9E9
      E9FFC7C7C7FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFF4E4E4EFF5E5E5EFFBBBB
      BBFFB8B8B8FFAAAAAAFF969696FF7F7F7FFF737373FF626262FF4E4E4EFF5B5B
      5BFF3E3E3EFF494949FF444444FF3A3A3AFF414141FF454545FF626262FF9292
      92FFA5A5A5FFC1C1C1FFDDDDDDFFE7E7E7FFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFAFAFAFFE1E1E1FFDFDFDFFFE8E8E8FFE5E5E5FFE7E7E7FFE9E9E9FFEAEA
      EAFFECECECFFEEEEEEFFEEEEEEFFF0F0F0FFF1F1F1FFF2F2F2FFF3F3F3FFF5F5
      F5FFF3F3F3FFF6F6F6FFF6F6F6FFF5F5F5FFF5F5F5FFF5F5F5FFF6F6F6FFF5F5
      F5FFF5F5F5FFF5F5F5FFF2F2F2FFF3F3F3FFF1F1F1FFF0F0F0FFEFEFEFFFEEEE
      EEFFECECECFFECECECFFEBEBEBFFE8E8E8FFE7E7E7FFE6E6E6FFE4E4E4FFD7D7
      D7FFC6C6C6FFFAFAFAFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFF858585FFEFEFEFFFDADA
      DAFFE6E6E6FFF8F8F8FFE6E6E6FFE1E1E1FFDFDFDFFFDBDBDBFFDADADAFFDADA
      DAFFDBDBDBFFDADADAFFDADADAFFD8D8D8FFD6D6D6FFCECECEFFCBCBCBFFB6B6
      B6FFC4C4C4FFADADADFF9E9E9EFF989898FF848484FF717171FF616161FF5353
      53FF444444FF383838FF373737FF343434FFEAEAEAFFFDFDFDFFF7F7F7FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFDFDFDFFE0DEDFFFE2E0E1FFE1E0E1FFE4E3E4FFE4E4E4FFE5E5E5FFE8E6
      E7FFEAE8E9FFEDEBECFFEEECEDFFF0EEEFFFF2F0F1FFF2F0F1FFF4F2F3FFF5F3
      F4FFF5F3F4FFF7F5F6FFF8F6F7FFF5F4F5FFECEBECFFE7E6E7FFF7F6F7FFF6F5
      F6FFF5F3F4FFF6F4F5FFF4F2F3FFF3F1F2FFF3F1F2FFF1EFF0FFEFEDEEFFEFED
      EEFFEDEBECFFEBE9EAFFEAE8E9FFE8E6E7FFE3E3E3FFE3E3E3FFE2E1E1FFE2E0
      E1FFC6C4C5FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFF9C9C9CFFE4E4E4FFDCDC
      DCFFDEDEDEFFE8E8E8FFE6E6E6FFE1E1E1FFE0E0E0FFE1E1E1FFDEDEDEFFDADA
      DAFFDADADAFFD7D7D7FFD4D4D4FFD0D0D0FFCBCBCBFFC8C8C8FF8E8E8EFFE9E9
      E9FFB7B7B7FFC2C2C2FFC1C1C1FFC1C1C1FFC1C1C1FFC5C5C5FFCDCDCDFFD7D7
      D7FFDFDFDFFFFEFEFEFFDFDFDFFFD0D0D0FFA1A1A1FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFDFDFDFFD4E0DCFFD7E3DFFFDFDFDFFFE3E3E3FFE5E5E5FFE5E5E5FFE9E8
      E8FFEAE9E9FFEEEDEDFFEEEDEDFFF0EFEFFFF1F0F0FFF1F0F0FFF3F2F2FFF4F3
      F3FFF4F3F3FFF6F5F5FFF7F6F6FFE3E2E2FFD7D6D6FFD0CFCFFFF8F7F7FFF4F3
      F3FFF5F4F4FFF5F4F4FFF3F2F2FFF2F1F1FFF2F1F1FFF0EFEFFFEEEDEDFFEEED
      EDFFECEBEBFFEAE9E9FFE9E8E8FFE7E6E6FFE6E4E5FFE6E4E5FFE5E3E4FFE2E0
      E1FFC4C4C4FFFDFDFDFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFB2B2B2FFE0E0E0FFDADA
      DAFFE3E3E3FFF4F4F4FFF6F6F6FFEBEBEBFFE6E6E6FFE4E4E4FFE0E0E0FFDCDC
      DCFFDADADAFFD7D7D7FFD3D3D3FFD4D4D4FFD0D0D0FFDBDBDBFF757575FFA2A2
      A2FFBFBFBFFFC2C2C2FFC0C0C0FFC0C0C0FFBBBBBBFFBDBDBDFFBBBBBBFFB5B5
      B5FFC2C2C2FFF6F6F6FFC5C5C5FFB1B1B1FFB0B0B0FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFDFDFDFFDEDEDEFFE3E2E2FFE3E2E2FFE7E6E6FFE9E7E8FFE7E7E7FFE8E8
      E8FFE9E9E9FFECECECFFECECECFFEEEEEEFFEFEFEFFFEFEFEFFFF1F1F1FFF2F2
      F2FFF2F2F2FFF4F4F4FFF5F5F5FFE3E3E3FFD5D5D5FFDCDCDCFFF4F4F4FFF4F4
      F4FFF3F3F3FFF3F3F3FFF1F1F1FFF0F0F0FFF0F0F0FFEEEEEEFFECECECFFECEC
      ECFFEAEAEAFFE9E9E9FFE8E8E8FFE6E6E6FFE3E3E3FFE6E4E5FFE4E2E3FFE4E2
      E3FFC5C5C5FFFCFCFCFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABABABFFDDDDDDFFDADA
      DAFFFFFFFFFFF4F2F3FFF9F9F9FFEFEFEFFFE7E7E7FFE6E6E6FFE0E0E0FFDADA
      DAFFD7DBDFFFD1D5D9FFCBCFD3FFD3D7DBFFCACED2FFC6CACEFF272727FF6363
      63FFD2D2D2FFC1C1C1FFC1C1C1FFC0C0C0FFBFBFBFFFBCBCBCFFB9B9B9FFB9B9
      B9FFB0B0B0FFC4C4C4FFBEBEBEFFBDBDBDFFBEBEBEFFFFFFFFFFFDFDFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFEBE9EAFFE9E3E0FFEDE7E4FFE7E5E6FFE7E5E6FFE7E6E7FFE9E8
      E9FFECEBECFFEEEDEEFFEEEDEEFFF0EFF0FFF2F1F2FFF2F1F2FFF4F3F4FFF5F4
      F5FFF5F4F5FFF6F5F6FFF8F6F7FFFBF9FAFFF5F3F4FFEEECEDFFF8F6F7FFF8F6
      F7FFF8F6F7FFF7F6F7FFF5F4F5FFF4F3F4FFF4F3F4FFF1F0F1FFF0EFF0FFEFEE
      EFFFEDECEDFFEDECEDFFECEBECFFEAE9EAFFE8E7E8FFE8E8E8FFE1E1E1FFE1E1
      E1FFC6C6C6FFFEFCFDFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFFDCDCDCFFB4B4
      B4FF000000FF020001FF040404FF080808FF0B0B0BFF121212FF1C1C1CFF2626
      26FF282828FF323232FF3D3D3DFF616161FF727272FF787878FF8E8E8EFF9F9F
      9FFFA2A2A2FFB9B9B9FFC6C6C6FFCBCBCBFFD4D4D4FFD8D8D8FFD7D7D7FFDADA
      DAFFE6E6E6FFEBEBEBFFFFFFFFFFF0F0F0FFDADADAFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFD4D8DCFFDBDBDBFFE5E3E4FFE4E3E3FFE5E4E4FFE6E5E5FFEBEA
      EAFFEDECECFFEEEDEDFFF0EFEFFFF1F0F0FFF1F0F0FFF4F3F3FFF4F3F3FFF5F4
      F4FFF6F5F5FFF7F6F6FFF7F6F6FFF7F6F6FFF8F7F7FFF9F8F8FFF7F6F6FFF7F6
      F6FFF7F6F6FFF6F5F5FFF5F4F4FFF4F3F3FFF4F3F3FFF3F2F2FFEFEEEEFFEFEE
      EEFFEEEDEDFFE7E6E6FFE7E6E6FFE6E5E5FFE3E2E2FFDEDDDDFFE5E4E4FFE1E0
      E0FFC8C6C7FFFEFCFDFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFDFFB2B2B2FFDBDBDBFF5F5F
      5FFF020202FF020001FF050304FF060405FF080607FF080607FF040203FF0200
      01FF020101FF000000FF000000FF010101FF000000FF010000FF070606FF0100
      00FF010000FF010000FF010000FF010000FF010001FF040304FF010001FF0100
      01FF050405FF030303FF010101FF848484FFE3E3E3FFFEFEFEFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFDCDCDCFFF0EAE7FFBFA9A6FFC0A296FFC6A494FFC7A595FFC2A4
      98FFC4A69AFFC3A599FFC3A599FFC4A69AFFC3A599FFC2A498FFC2A498FFC3A5
      99FFC2A498FFC2A498FFC2A498FFC1A397FFC0A296FFC1A397FFC1A397FFC1A3
      97FFC2A498FFC2A498FFC3A599FFC3A599FFC2A498FFC3A599FFC3A599FFC3A5
      99FFC4A69AFFBFA195FFBFA195FFC0A296FFC5A393FFC0A296FFB4A69BFFEFE9
      E6FFC6C6C6FFFBFBFBFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F6F7FFB4B4B4FFE2E2E2FF3636
      36FF000000FF060405FF040203FF050304FF050304FF070506FF040203FF0301
      02FF010000FF010000FF010000FF040303FF010000FF010000FF020101FF0100
      00FF010000FF010000FF010000FF010000FF030203FF040304FF020102FF0201
      02FF010001FF000000FF000000FF3B3B3BFFF0F0F0FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFD
      FDFFFDFDFDFFE4E3E3FFF4EAE3FF512F1FFF722F1FFF71361EFF7A331FFF7C35
      21FF7B3420FF7A331FFF7B3420FF7A331FFF7B3420FF7A331FFF7A331FFF7A33
      1FFF78311DFF77301CFF712E1EFF733020FF733020FF712E1EFF733020FF7431
      21FF743121FF753222FF753222FF743121FF743121FF72371FFF763323FF7633
      23FF763323FF793626FF793626FF7A3727FF763B23FF723B27FF4A2818FFFBF1
      EAFFCBC9CAFFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EFF0FFB8B8B8FFE8E8E8FF2929
      29FF020202FF323031FF353334FF383637FF3A3839FF3D3B3CFF403E3FFF4442
      43FF494748FF4B494AFF4B494AFF464445FF3D3B3CFF3A3839FF333233FF2D2C
      2DFF2B2A2BFF201F20FF1B1A1BFF1A191AFF141314FF111011FF100F10FF0F0E
      0FFF0B0A0BFF0C0B0CFF000000FF5E5E5EFFF3F3F3FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFD
      FDFFFDFDFDFFE4E4E4FFEFEAE6FF552F1BFF7C3118FF75361AFF81361DFF8136
      1DFF80351CFF7F341BFF7E331AFF7D3219FF7F341BFF80351CFF80351CFF8035
      1CFF81361DFF80351CFF7B3420FF78311DFF79321EFF7A331FFF78311DFF7831
      1DFF743519FF75361AFF75361AFF743519FF75361AFF77381CFF793A1EFF7A3B
      1FFF7A3B1FFF7B3C20FF7C3D21FF7C3D21FF7D3E22FF7E3F23FF512B17FFFAF1
      E9FFCCCACBFFFDFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E5E6FFBEBEBEFFF0F0F0FF2121
      21FF080607FF2C2A2BFF302E2FFF373536FF3C3A3BFF3E3C3DFF434142FF4746
      47FF564D56FF5B525BFF5B525BFF5D545DFF584F58FF544B54FF504750FF4B42
      4BFF494049FF423942FF3E353EFF3C333CFF343334FF323132FF343334FF3433
      34FF333233FF333132FF040404FF8D8D8DFFF9F9F9FFFEFEFEFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFD
      FDFFFDFDFDFFE5E5E5FFF4EBE3FF56301CFF813A15FF773C13FF87401BFF863F
      1AFF87401BFF88411CFF853E19FF843D18FF863F1AFF87401BFF87401BFF8740
      1BFF863F1AFF83401FFF844120FF844120FF803D1CFF7F3C1BFF7F3C1BFF7D3A
      19FF7C3918FF7E3B1AFF7E3B1AFF78391DFF793A1EFF7B3C20FF7C3D21FF813E
      1DFF7F4024FF814226FF824327FF824327FF7E4723FF85462AFF513317FFFBF2
      EAFFCDCBCCFFFBFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D6D6FFC1C1C1FFFEFEFEFF0707
      07FF0F0D0EFF252324FF342A33FF392F38FF3C323BFF483E47FF4B414AFF544A
      53FF5C525BFF60565FFF5C525BFF564C55FF524851FF4C424BFF494049FF453C
      45FF433A43FF413841FF3E353EFF3D343DFF373536FF353334FF353334FF3432
      33FF333132FF2F2D2EFF000000FFB9B9B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFD
      FDFFFDFDFDFFE5E5E5FFF5ECE4FF5B3018FF813A15FF793E15FF87401BFF8A43
      1EFF8B441FFF8C4520FF8B441FFF8A431EFF8B441FFF8B441FFF8B441FFF8B44
      1FFF87481BFF88491CFF8D4621FF904924FF914A25FF8F4823FF87401BFF853E
      19FF833C17FF843D18FF803D1CFF803D1CFF803D1CFF813E1DFF844120FF8643
      22FF884524FF83481FFF844920FF854A21FF804925FF824B27FF523418FFFCF3
      EBFFCCCACBFFFBFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C6C6FFC7C7C7FFFCFBFCFF0302
      03FF181617FF2C2A2BFF352B34FF3B313AFF40363FFF4B414AFF50464FFF5A50
      59FF615760FF625861FF5C525BFF544A53FF514750FF4B414AFF473E47FF4239
      42FF413841FF3E353EFF3C333CFF3B323BFF353334FF343233FF333132FF3230
      31FF312F30FF2A2829FF000000FFDDDDDDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFE6E6E6FFF6EDE5FF60351DFF843D18FF793E15FF8B4017FF9451
      20FF955221FF965322FF945120FF945120FF945120FF93501FFF945120FF9455
      28FF945528FF955629FF97582BFF98592CFF9A5B2EFF9F5C2BFFA3582FFF9B50
      27FF93481FFF8C4520FF88411CFF843D18FF833C17FF83401FFF854221FF8748
      1BFF844920FF864B22FF864B22FF864B22FF874C23FF834C28FF57391DFFFBF2
      EAFFCDCBCCFFFAFAFAFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB8B8B8FFCDCDCDFFF5F4F5FF0100
      01FF211F20FF323031FF362C35FF3E343DFF433942FF4F454EFF544A53FF5F55
      5EFF665C65FF655B64FF5C525BFF534952FF50464FFF4A4049FF453C45FF4037
      40FF3F363FFF3C333CFF3A313AFF393039FF343233FF333132FF302E2FFF302E
      2FFF2E2C2DFF272526FF020202FFF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFE6E6E6FFF7EEE6FF643921FF8D4219FF804114FF893E15FF904D
      1CFF9C5928FF9B5827FF9A5726FF9A5726FF9A5726FF985524FF995625FF9D5A
      29FFA05D2CFFA25F2EFFA0652CFF9B642FFFA56231FFA66332FFA86534FFA663
      32FFA46130FF93501FFF914E1DFF974C23FF89421DFF863F1AFF87401BFF8445
      18FF894A1DFF8B4C1FFF874C23FF884D24FF855221FF87502CFF593B1FFFFCF3
      EBFFCDCBCCFFFBFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9A9FFD9D9D9FFE9E8E9FF0C0B
      0CFF262425FF2E2C2DFF3B313AFF40363FFF4B414AFF554B54FF5B515AFF6D63
      6CFF6E646DFF685E67FF5D535CFF534952FF50464FFF4A4049FF453C45FF4138
      41FF3F363FFF3B323BFF382F38FF372E37FF312F30FF302E2FFF2E2C2DFF2F2D
      2EFF2E2C2DFF1E1C1DFF000000FFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFE7E7E7FFF7EEE6FF6C3D21FF8C4918FF87481BFF8D4611FF8946
      15FFA8612CFFA46528FFA36427FFA36427FFA36427FFA26326FFA16225FF9E63
      2AFFA56A31FFAB7037FFB0753CFFAD7339FFAD7339FFAD7339FFAF743BFFAE6F
      32FFAA6B2EFFAA6B2EFFA45D28FF9C5520FF99521DFF965322FF9A5726FF9653
      22FF8C4D20FF894A1DFF8B4C1FFF875423FF875423FF8E532AFF5B3D21FFFDF4
      ECFFCECCCDFFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA6A6A6FFD8D8D8FFDDDCDDFF0706
      07FF292728FF323031FF3B313AFF423841FF4D434CFF594F58FF615760FF7167
      70FF6E646DFF675D66FF5D535CFF534952FF50464FFF4A4049FF453C45FF4138
      41FF3F363FFF3C333CFF393039FF382F38FF323031FF312F30FF2E2C2DFF2F2D
      2EFF2E2C2DFF1C1A1BFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFE8E8E8FFEEE9E5FF764323FF8B5017FF93481FFF924B16FF8C49
      18FFA15A25FFAA6B2EFFAB6C2FFFA7682BFFA8692CFFA6672AFFA8692CFFA768
      2BFFAA6B2EFFB0753CFFB67C42FFB97F45FFB37D47FFB67C42FFB3793FFFB577
      39FFB17335FFAD6F31FFAD6E31FFA96A2DFF96571AFF9A5726FF985524FF9459
      20FF985D24FF935C27FF905924FF885524FF8A541EFF8D5621FF623F1FFFFAF1
      E9FFCDCBCCFFFBFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA2A2A2FFDBDBDBFFB0AFB0FF0100
      01FF302E2FFF353334FF3D333CFF453B44FF524851FF635962FF6E646DFF7C72
      7BFF6E646DFF645A63FF5D535CFF534952FF50464FFF4A4049FF453C45FF4138
      41FF3F363FFF3D343DFF3B323BFF3A313AFF333132FF323031FF2E2C2DFF2F2D
      2EFF2E2C2DFF121011FF000000FFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFEAEAEAFFEFEAE6FF7C4929FF92571EFF994E25FF98511CFF9A53
      1EFF944D18FFB37437FFB47538FFB8793CFFB47538FFB17235FFB37437FFAE6F
      32FFAB6C2FFFA66B32FFBE844AFFBE8852FFC18B55FFC08A54FFBB854FFFBB81
      47FFBA7C3EFFB57739FFB47538FFB27336FFB8793CFFA76C33FF9C6128FF9C61
      28FF9F642BFF995E25FF98612CFF9B642FFF98622CFF955E29FF654222FFFBF2
      EAFFCECCCDFFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1A1A1FFDFDFDFFF9A999AFF0100
      01FF323031FF333132FF3C323BFF473D46FF544A53FF685E67FF746A73FF8076
      7FFF6E646DFF635962FF5D535CFF534952FF50464FFF4A4049FF453C45FF4138
      41FF3F363FFF3E353EFF3B323BFF3A313AFF343233FF333132FF2E2C2DFF2F2D
      2EFF2E2C2DFF151314FF000000FFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFDFDFDFFEAEAEAFFF1ECE8FF7F4C2CFF965B22FF9D5229FF9C5520FF9B54
      1FFF9A531EFFB07134FFB7783BFFC58B51FFAC7238FFB6773AFFB7783BFFB071
      34FFB07134FFA96E35FFB0753CFFC58F59FFBE9052FFBF9153FFBC8E50FFBF85
      4BFFBB8147FFBB7D3FFFB97B3DFFB6773AFFAE6F32FFBE7F42FFA76C33FFA465
      28FFA0652CFFA0652CFF9F642BFF99622DFF9A642EFF9C6530FF6A4727FFFBF2
      EAFFCFCDCEFFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAEAFFFD9D9D9FF6D6C6CFF0201
      01FF3A3839FF3C3A3BFF403F40FF4D444DFF5E555EFF796F78FF887687FF7B6A
      7BFF685F68FF625962FF554C55FF514750FF4D434CFF473D46FF443B44FF4138
      41FF403740FF3C333CFF3B323BFF3B323BFF363435FF343233FF333132FF312F
      30FF343233FF191718FF010101FFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEDEDEDFFEEE9E5FF824F2FFF975C23FFA0552CFFA05924FF9E57
      22FF9F5823FFA55E29FFB67B42FFC38D57FFC48E58FFB3793FFFB67C42FFB378
      3FFFB1763DFFB0753CFFAF743BFFAB753FFFCC9660FFBF955BFFBE945AFFBD8F
      51FFB7894BFFBC8248FFB77D43FFBB7D3FFFB1773DFFB57B41FFB67C42FFB379
      3FFFA86E34FFA1672DFFA1672DFF9E6732FF9D6731FF9D6631FF6C4929FFFDF4
      ECFFCFCDCEFFFBFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFEFEFFFFFFFFFFFCFCFCFFB2B1B2FFE0E0E0FF4E4D4DFF0100
      00FF3F3D3EFF3F3E3FFF463D46FF524952FF6A616AFF8A818AFF958394FF8170
      81FF665D66FF5E555EFF544B54FF4E444DFF4C424BFF463C45FF433A43FF4037
      40FF3F363FFF3D343DFF3C333CFF3C333CFF373536FF353334FF343233FF3432
      33FF353334FF171516FF000000FFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEDEDEDFFEFEAE6FF845131FF9B6027FFA45930FFA45D28FFA25B
      26FFA25B26FFA25F2EFFAC7138FFC7915BFFD3A567FFB17B45FFB47E48FFB57A
      41FFB3783FFFAE7842FFB2773EFFB2773EFFB57F49FFCB9967FFC59B61FFC193
      55FFBE9052FFBD8751FFBC8248FFBA8046FFB57B41FFB67C42FFB47A40FFB47E
      48FFB27C46FFA56F39FFA36D37FFA06A34FFA16B35FFA16A35FF714E2EFFFDF4
      ECFFD0CECFFFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFEFEFEFFFFFFFFFFF9F9F9FFB0AFB0FFE3E3E3FF2A2929FF0302
      02FF484748FF4C434CFF4E454EFF5C535CFF7A717AFFA897A8FF9E8D9EFF7968
      79FF665D66FF5A515AFF4E454EFF4B414AFF4B414AFF453B44FF423942FF3F36
      3FFF3E353EFF3F363FFF3D343DFF3D343DFF383637FF363435FF353334FF3634
      35FF363435FF1A1819FF000000FFF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEEEEEEFFF2EDE9FF875434FF9D6229FFA65B32FFA26326FFA45D
      28FFA55E29FFA86534FFAB7037FFC28C56FFC89E64FFCC9E60FFB07A44FFB27C
      46FFB47E48FFB27C46FFB67B42FFB57A41FFB6804AFFAB753FFFC49A60FFC799
      5BFFC09254FFC18B55FFBF8953FFC0864CFFBE844AFFB87E44FFB8824CFFB47E
      48FFB27C46FFB47E48FFB07A44FFA47240FFA7713BFFA7703BFF785535FFFEF5
      EDFFD1CFD0FFFDFDFDFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFCFCFCFFF8F8F8FFFEFEFEFFB6B6B6FFDCDCDCFF1A1919FF0807
      08FF5D545DFF534A53FF504750FF615861FF8C838CFFB7A6B7FF9F8E9FFF806F
      80FF645B64FF5B525BFF4D444DFF4A4049FF463C45FF453B44FF413841FF4037
      40FF3F363FFF3F363FFF3D343DFF3D343DFF383637FF363435FF363435FF3836
      37FF373536FF222021FF1D1D1DFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEEEEEEFFF3EAE2FF7D5632FFA46130FFA46130FFA9622DFFA861
      2CFFA8612CFFA56A31FFB0753CFFBA844EFFCBA167FFD1A76DFFB98B4DFFB37D
      47FFB6804AFFB6804AFFB6804AFFB9824DFFB7814BFFB57F49FFB57F49FFD9A3
      6DFFC9935DFFBF8953FFC18B55FFBC8650FFC0864CFFB8824CFFB8824CFFB482
      50FFB3814FFFB3814FFFB07E4CFFAD7B49FFA2703EFFAA733EFF76593CFFFAF5
      F1FFD1CFD0FFFCFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFBFBFBFFFBFBFBFFF8F8F8FFB3B3B3FFE8E8E8FF030303FF100F
      10FF7C737CFF615C69FF5E555EFF635A63FFAFA6AFFFB2A1B2FF928192FF7564
      75FF5F565FFF595059FF4E454EFF4A4049FF463C45FF453B44FF423942FF4138
      41FF413841FF403740FF3F363FFF3E353EFF3B393AFF393738FF3A3839FF3A38
      39FF373536FF211F20FF4D4D4DFFF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEEEEEEFFF4EBE3FF7A5737FFA66332FF9D6631FFA76433FFAB64
      2FFFAC6530FFAA6F36FFB77C43FFB8824CFFC99F65FFCEA46AFFCCA268FFBB85
      4FFFBD8751FFBC8650FFBC8650FFBB854FFFBA844EFFB9834DFFBA844EFFB781
      4BFFBF8953FFC7995BFFBB8D4FFFBC8E50FFBC8E50FFBC8E50FFBD8751FFBA88
      56FFBA8856FFB88654FFB78553FFB08255FFB08255FFAE7C4AFF7C5F42FFFBF5
      F2FFD4CFCBFFFDFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFBFBFBFFFEFEFEFFF4F4F4FFB7B7B7FFEEEEEEFF000000FF1413
      14FF877E87FF7E7186FF716871FF635A63FFCFBECFFF9D8C9DFF837283FF705F
      70FF5C535CFF574E57FF4F464FFF4A4049FF463C45FF453B44FF433A43FF4239
      42FF413841FF413841FF3F363FFF3F363FFF3D3B3CFF3B393AFF3C3A3BFF3C3A
      3BFF373536FF222021FF6B6B6BFFF8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEDEDEDFFF5ECE4FF7C5939FFA86534FF9F6833FFA96635FFAA67
      36FFAA6736FFAE733AFFB8814CFFBD8751FFBF955BFFCEA46AFFD0A66CFFBC86
      50FFBE8852FFBE8852FFBE8852FFBB8957FFBA8856FFB98755FFB68452FFB987
      55FFBB854FFFC58F59FFC6905AFFC48E58FFBE8852FFC08A54FFBF8953FFBD8B
      59FFBD8B59FFBB8957FFBA8856FFB88654FFB5875AFFB68452FF84674AFFFBF5
      F2FFD4CFCBFFFDFCFCFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFAFAFAFFFCFCFCFFB3B3B3FFF6F6F6FF010000FF0B0A
      0BFF7D747DFF75707DFF7D7885FF6B6673FFB5B0BDFF6D6875FF66616EFF5D58
      65FF5E545DFF594F58FF554B54FF4C424BFF4B414AFF463C45FF463C45FF463C
      45FF463C45FF463C45FF443A43FF443A43FF423942FF413841FF413841FF4037
      40FF342B34FF1D1B1CFFA5A5A5FFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEFEFEFFFF6EDE5FF7D5A3AFFA96635FFA06934FFAA6736FFAC69
      38FFA86D34FFB17A45FFB9834DFFC08E5CFFBE8C5AFFCA9866FFD19F6DFFCB99
      67FFBF8D5BFFBE8C5AFFBF8D5BFFBE8C5AFFBE8C5AFFBE8C5AFFBE8C5AFFBD8B
      59FFC18B55FFC08A54FFC18B55FFC58F59FFC58F59FFC08A54FFBB854FFFC48E
      58FFC69462FFC18F5DFFC08E5CFFC2905EFFBC8E61FFC08E5CFF907356FFFBF5
      F2FFD6D1CDFFFCFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFCFCFCFFF7F7F7FFB3B3B3FFF9F9F9FF000000FF0C0B
      0CFF7E7986FF7B6E83FF67626FFF908B98FF736E7BFF6C6774FF645F6CFF645F
      6CFF615760FF5D535CFF5A5059FF524851FF4F454EFF4A4049FF493F48FF493F
      48FF493F48FF483E47FF473D46FF463C45FF433A43FF423942FF443B44FF433A
      43FF393039FF0A0809FFBBBBBBFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFEFEFEFFFF6EDE5FF7D5A3AFFA46930FFA06934FFAB6837FFAD6A
      39FFA56E39FFB47D48FFB78553FFBD8B59FFC08E5CFFBD8B59FFCD9B69FFD19F
      6DFFBF8D5BFFC08E5CFFC08E5CFFC2905EFFC2905EFFC2905EFFC18F5DFFC18F
      5DFFC08E5CFFBE8C5AFFBE8C5AFFBE8C5AFFC2905EFFC2905EFFC28C56FFBC86
      50FFBC8A58FFC59361FFC99765FFC59361FFBF9164FFC49260FF94775AFFFBF5
      F2FFD6D1CDFFFCFBFBFFFEFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFDFDFDFFFEFEFEFFEFEFEFFFB0B0B0FFFEFEFEFF050405FF1413
      14FF9E91A6FFB1A8C1FFD5D0DDFFEEE9F6FF736E7BFF807B88FF898491FF7570
      7DFF706770FF685F68FF625962FF574E57FF524952FF4C434CFF484647FF4846
      47FF484647FF484647FF464445FF464445FF434243FF424142FF444344FF4140
      41FF323132FF010001FFE5E5E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFF1F0F1FFFBEEE2FF865B33FFA96635FF9C6A38FFA8693CFFAA6B
      3EFFA9723DFFB48250FFBB8957FFBA8856FFC2905EFFC69462FFBF8D5BFFCE9C
      6AFFC69462FFC69462FFC69462FFC59361FFC59361FFC59361FFC49260FFC492
      60FFC3915FFFC59361FFC49260FFC2905EFFC2905EFFC3915FFFC7915BFFC48E
      58FFC38D57FFBD8B59FFBB8957FFC08E5CFFC6986BFFD19B65FFA7815CFFF7F5
      F6FFD2D1D1FFFCFBFBFFFFFEFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFBFBFBFFFDFDFDFFD3D3D3FFB2B2B2FFF6F6F6FF171617FF1E1D
      1EFFCABDD2FFE9DCF1FFF4EFFCFFE2DDEAFF87828FFF7C7784FF7F7A87FF817C
      89FF7A717AFF716871FF685F68FF574E57FF514851FF4E454EFF444243FF3E3C
      3DFF3C3A3BFF333132FF2C2A2BFF2A2829FF242324FF1B1A1BFF1A191AFF1514
      15FF181718FF111011FFEEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFEFEFEFFF2F1F2FFFEEDDCFF835C38FFA56A31FF9C6A38FFA7683BFFAB6C
      3FFFAB743FFFB88554FFBA8856FFBB8957FFC2905EFFC59261FFC49260FFC08E
      5CFFCD9B69FFC89664FFC99765FFCC9660FFCC9660FFCC9660FFCC9660FFCB95
      5FFFCB955FFFC49260FFC69462FFC69462FFC79563FFC59361FFCA945EFFCB95
      5FFFC6905AFFC9935DFFC6905AFFBE8C5AFFB6885BFFC8925CFFA27C57FFF7F5
      F6FFD2D1D1FFFDFBFCFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF9F9F9FFFFFFFFFFC9C9C9FFC6C6C6FFFEFEFEFF121111FF0F0E
      0FFF211821FF130E1BFF120912FF070007FF130A13FF211821FF281F28FF2F26
      2FFF2C2B2CFF333233FF3A393AFF494849FF434243FF424041FF3D3B3CFF3230
      31FF2E2C2DFF1B191AFF181617FF171516FF111011FF232223FF3E3D3EFF4C4B
      4CFF696869FFC2C1C2FFEEEEEEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFEFEFEFFF5F4F5FFFFEFDEFF835D38FF9F6833FFA26B36FF9F6C3BFFA16E
      3DFFA97745FFB48250FFB48250FFB7895CFFBC8E61FFBF9164FFBF9164FFBD8F
      62FFBB8D60FFC5976AFFC7996CFFC6986BFFC99B6EFFC5976AFFC6986BFFC698
      6BFFC6986BFFC6986BFFC6986BFFC6986BFFC6986BFFC5976AFFC39568FFC395
      68FFC29467FFC19366FFC19366FFBF9164FFC9935DFFC08E5CFF997756FFFDF8
      F4FFCED2D6FFFAFAFAFFFFFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFF9F9F9FFFBFBFBFFBABABAFFBBBABBFFF7F7F7FF060505FF1312
      12FF121011FF171516FF0D0C0DFF151415FF171617FF171617FF1B1A1BFF1F1E
      1FFF2D2C2DFF3B3A3BFF4A494AFF706F70FF8F8E8FFF9B9A9BFFBEBCBDFFE2E0
      E1FFF0EEEFFFF6F4F5FFFFFEFFFFFFFEFFFFFCFBFCFFF7F6F7FFF5F4F5FFF6F5
      F6FFF2F1F2FFF2F2F2FFE4E4E4FFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFEFEFEFFF5F5F5FFFFEEDDFF885D35FFA46930FFA66B32FFA36C37FF9E6C
      3AFFAC7A48FFB2804EFFAC8248FFB38D58FFB7915CFFB9935EFFBE945AFFBD93
      59FFC08E5CFFBB8957FFD19F6DFFC99B6EFFC89A6DFFC7996CFFC99B6EFFC89A
      6DFFC99B6EFFC89A6DFFC89A6DFFC89A6DFFC89A6DFFC89A6DFFC5976AFFC597
      6AFFC49669FFC5976AFFC5976AFFC39568FFCC9660FFC59361FF9D7752FFFDF8
      F4FFCFD2D7FFFAFAFAFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2FFCFCFCFFFF8F8F8FFFFFEFEFFFEFD
      FDFFFEFDFDFFFEFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFFAFAFAFFFAFA
      FAFFFDFCFDFFFDFCFDFFFEFDFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFEFEFEFFF2F6FAFFFCEFE3FF835C38FFA36437FFA06934FF9C6A38FFA46D
      38FFB17A45FFB17A45FFB7804BFFBE8752FFC48D58FFC7905BFFC9925DFFC992
      5DFFCF945BFFC78453FFC2874EFFDDA369FFD3A15FFFD7A563FFD79D63FFD3A1
      5FFFD3A15FFFD59B61FFD19F5DFFD19F5DFFD79D63FFD2A05EFFD69C62FFD59B
      61FFD49A60FFD59B61FFD49A60FFD3995FFFCF9963FFC5976AFFA27C57FFFDF8
      F4FFD2D2D2FFFAFAFAFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E7FFF1F1F1FFF6F6F6FFF8F8
      F8FFF8F8F8FFF8F8F8FFFAFAFAFFFAFAFAFFFAFAFAFFFDFDFDFFFDFDFDFFFDFD
      FDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFC
      FCFFFEFEFEFFF5F9FDFFF7E9DEFF624428FF774C24FF794E26FF734D28FF7F58
      34FF8C6139FF865F3BFF8F6844FF966F4BFF9A744FFF9E7853FF9F7854FFA378
      50FFA77C54FF9E734BFFA27347FFA0764DFFB38960FFB1875EFFB48A61FFB48A
      61FFB48A61FFB2885FFFB2885FFFB2885FFFB1875EFFB1875EFFB2885FFFB187
      5EFFB1875EFFB0865DFFB0865DFFAF855CFFAF8964FFA78564FF897057FFFEFD
      FDFFD2D2D2FFFFFFFFFFFFFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFF9F9F9FFFEFEFEFFFEFEFEFFFDFDFDFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFEFEFEFFFEFEFEFFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFEFE
      FEFFFCFCFCFFF6F6F6FFF0EFEFFFFFFAF6FFFFF6EEFFFFF7EFFFFFF8F0FFFFFA
      F6FFFFFAF6FFFFFBF7FFFFFCF8FFFFFCF8FFFFFCF8FFFFFBF7FFFFFBF7FFFFFB
      F7FFFFFCF8FFFFFBF7FFFFFCF8FFEEEDEDFFB7B6B6FFEEEDEDFFFDFCFCFFFDFC
      FCFFFDFCFCFFFDFCFCFFFDFCFCFFFDFCFCFFFDFCFCFFFDFCFCFFFDFCFCFFFCFB
      FBFFFBFAFAFFFBFAFAFFFBFAFAFFFAF9F9FFFBF6F2FFFFF9F1FFFFF7EFFFF0EF
      EFFFD7D7D7FFFEFDFDFFFFFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
      FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFFDFD
      FDFFFFFFFFFFDCDBDCFFF2F2F2FFEBEBEBFFEAEAEAFFEBEBEBFFEDECEDFFF2F1
      F2FFF3F2F3FFF3F2F3FFF2F1F2FFF2F1F2FFF3F2F3FFF5F3F4FFF5F3F4FFF2F1
      F2FFF2F1F2FFF3F2F3FFF3F2F3FFD2D1D1FFA6A5A5FFDDDCDCFFF3F2F2FFF3F2
      F2FFF3F2F2FFF2F1F1FFF2F1F1FFF2F1F1FFF2F1F1FFF2F1F1FFF2F1F1FFF2F1
      F1FFF1F0F0FFF0EFEFFFF0EFEFFFEFEEEEFFF0F0F0FFEFEEEEFFEFEEEEFFEFEF
      EFFFE8E8E8FFFFFEFEFFFFFEFEFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFFDFDFDFFFEFEFEFFFBFBFBFFFEFEFEFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
      FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
      FDFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFC
      FCFFFCFCFCFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
      FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFEFEFEFFFDFDFDFFFDFDFDFFFBFB
      FBFFFEFEFEFFFDFDFDFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEFFFCFCFCFFFCFCFCFFFFFFFFFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFDFDFDFFFDFDFDFFFDFDFDFFFCFCFCFFFCFCFCFFFCFCFCFFFDFDFDFFFDFD
      FDFFFDFDFDFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFEFEFEFFFEFEFEFFFFFF
      FFFFFEFEFEFFFDFDFDFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFFFF
      FFFFFFFFFFFFFCFCFCFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFFFDFD
      FDFFFFFFFFFFFEFEFEFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000C0000000300000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object Timer2: TTimer
    Interval = 600000
    Left = 88
    Top = 520
  end
  object IdUDPServer1: TIdUDPServer
    OnStatus = IdUDPServer1Status
    Active = True
    IPVersion = Id_IPv6
    Bindings = <
      item
        IP = '2001:0DA8:0270:2021:0:0:0:00CB'
        IPVersion = Id_IPv6
        Port = 1234
      end>
    DefaultPort = 1234
    OnUDPRead = IdUDPServer1UDPRead
    OnUDPException = IdUDPServer1UDPException
    Left = 160
    Top = 456
  end
  object ADOQueryNode: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Nodes')
    Left = 80
    Top = 584
  end
  object DataSourceNodes: TDataSource
    DataSet = ADOQueryNode
    Left = 80
    Top = 648
  end
  object ADOQueryData: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select top 1000 * from collect_data')
    Left = 160
    Top = 584
  end
  object DataSourceData: TDataSource
    DataSet = ADOQueryData
    Left = 160
    Top = 648
  end
  object ADOQueryAppend: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select top 1 * from collect_data')
    Left = 232
    Top = 584
  end
end
