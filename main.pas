unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, StrUtils;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    CDS: TClientDataSet;
    DataSource1: TDataSource;
    Button1: TButton;
    DBGrid2: TDBGrid;
    Button2: TButton;
    CDS2: TClientDataSet;
    DataSource2: TDataSource;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure SoundexSearch;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  csv: TextFile;
  Rec: string;
  Fields: TStringList;
  LineNo: Integer;
  i: Integer;
begin
  CDS.FieldDefs.Add('FIRST_NAME', ftString, 30);
  CDS.FieldDefs.Add('LAST_NAME', ftString, 30);
  CDS.FieldDefs.Add('EMAIL', ftString, 50);
  CDS.FieldDefs.Add('POSITION', ftString, 50);
  CDS.FieldDefs.Add('COMPANY', ftString, 50);
  CDS.FieldDefs.Add('CITY', ftString, 50);
  CDS.FieldDefs.Add('STATE', ftString, 50);
  CDS.FieldDefs.Add('PHONE', ftString, 50);
  CDS.FieldDefs.Add('AGE', ftString, 50);

  CDS.CreateDataSet;
  Fields := TStringList.Create;
  try
    Fields.StrictDelimiter := True;
    Fields.Delimiter := ',';
    AssignFile(csv, 'D:\data\clients\YourHouseCouncil\data\Conferences\CLM2018\2018 CLM Annual Conference - Attendees v3.csv');
    try
      Reset(csv);
      LineNo := 0;
      while not Eof(csv) do begin
        Inc(LineNo);
        Readln(csv, Rec);

        Fields.DelimitedText := Rec;
        CDS.Append;

        for i := 0 to Fields.Count - 1 do
          try
            CDS.Fields[i].Value := Fields[i];   // Variant conversion will raise
                                 // exception where conversion from string fails
          except
            on E:EDatabaseError do begin
              CDS.Cancel;        // Failed, discard the record

              // log the error instead of showing a message
              ShowMessage(Format('Cannot set field "%s" at line %d' + sLineBreak +
                  'Error: %s', [CDS.Fields[i].FieldName, LineNo, E.Message]));
              Break;             // Continue with next record
            end;
          end;

        if CDS.State = dsInsert then // It's not dsInsert if we Cancelled the Insert
          try
            CDS.Post;
          except
            on E:EDatabaseError do begin
              // log error instead of showing
              ShowMessage(Format('Cannot post line %d' + sLineBreak + 'Error: %s',
                  [LineNo, E.Message]));
              CDS.Cancel;
            end;
          end;

      end;
    finally
      CloseFile(csv);
    end;
  finally
    Fields.Free;
  end;
end;



procedure TForm1.Button2Click(Sender: TObject);
var
  csv: TextFile;
  Rec: string;
  Fields: TStringList;
  LineNo: Integer;
  i: Integer;
begin
  CDS2.FieldDefs.Add('First_Name', ftString, 30);
  CDS2.FieldDefs.Add('Last_Name', ftString, 30);
  CDS2.FieldDefs.Add('Position', ftString, 50);
  CDS2.FieldDefs.Add('Company', ftString, 100);
  CDS2.FieldDefs.Add('City', ftString, 30);
  CDS2.FieldDefs.Add('State', ftString, 20);
  CDS2.FieldDefs.Add('SourceID', ftString, 30);
  CDS2.CreateDataSet;

  Fields := TStringList.Create;
  try
    Fields.StrictDelimiter := True;
    Fields.Delimiter := ',';
    AssignFile(csv, 'D:\data\clients\YourHouseCouncil\data\Conferences\CLM2018\MasterRegistry v3.csv');
    try
      Reset(csv);
      LineNo := 0;
      while not Eof(csv) do begin
        Inc(LineNo);
        Readln(csv, Rec);

        Fields.DelimitedText := Rec;
        CDS2.Append;

        for i := 0 to Fields.Count - 1 do
          try
            CDS2.Fields[i].Value := Fields[i];   // Variant conversion will raise
                                 // exception where conversion from string fails
          except
            on E:EDatabaseError do begin
              CDS2.Cancel;        // Failed, discard the record

              // log the error instead of showing a message
              ShowMessage(Format('Cannot set field "%s" at line %d' + sLineBreak +
                  'Error: %s', [CDS2.Fields[i].FieldName, LineNo, E.Message]));
              Break;             // Continue with next record
            end;
          end;

        if CDS2.State = dsInsert then // It's not dsInsert if we Cancelled the Insert
          try
            CDS2.Post;
          except
            on E:EDatabaseError do begin
              // log error instead of showing
              ShowMessage(Format('Cannot post line %d' + sLineBreak + 'Error: %s',
                  [LineNo, E.Message]));
              CDS2.Cancel;
            end;
          end;

      end;
    finally
      CloseFile(csv);
    end;
  finally
    Fields.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  CDS.First;
  CDS2.First;
  CDS.DisableControls;
  while not CDS2.eof do
  begin
    CDS.First;
    while not CDS.eof do
    begin
      if (UpperCase(CDS.FieldByName('FIRST_NAME').AsString) = UpperCase(CDS2.FieldByName('FIRST_NAME').AsString)) and
         (UpperCase(CDS.FieldByName('LAST_NAME').AsString) = UpperCase(CDS2.FieldByName('LAST_NAME').AsString)) then
      begin
        Memo1.Lines.Add
//        ('Found [Conf] : | '+ CDS2.FieldByName('RECORDID').AsString + ' | ' + CDS2.FieldByName('TITLE').AsString + ' | ' + CDS2.FieldByName('FIRST_NAME').AsString + ' | ' + CDS2.FieldByName('LAST_NAME').AsString + ' | ' + CDS2.FieldByName('COMPANY').AsString +
//         '  |  = [YHC]  : | '+ CDS.FieldByName('FIRST_NAME').AsString + ' | ' + CDS.FieldByName('LAST_NAME').AsString  + ' | ' + CDS.FieldByName('COMPANY').AsString + ' | ' + CDS.FieldByName('EMAIL').AsString);

//        ('Found [Conf] : | '+ CDS2.FieldByName('FIRST_NAME').AsString + ' | ' + CDS2.FieldByName('LAST_NAME').AsString + ' | ' + CDS2.FieldByName('COMPANY').AsString + ' | ' + CDS2.FieldByName('CITY').AsString + ' | ' + CDS2.FieldByName('SOURCEID').AsString  + ' | ' + CDS2.FieldByName('COMPANY').AsString  +
//         '  |  = [YHC]  : | '+ CDS.FieldByName('FIRST_NAME').AsString + ' | ' + CDS.FieldByName('LAST_NAME').AsString  + ' | ' + CDS.FieldByName('CITY').AsString + ' | ' + CDS.FieldByName('COMPANY').AsString );


       ('Found [Conf] : |' +  CDS2.FieldByName('FIRST_NAME').AsString + ' | ' +
                              CDS2.FieldByName('LAST_NAME').AsString + ' | ' +
                              CDS2.FieldByName('POSITION').AsString + ' | ' +
                              CDS2.FieldByName('COMPANY').AsString + ' | ' +
                              CDS2.FieldByName('CITY').AsString + ' | ' +
                              CDS2.FieldByName('STATE').AsString + ' | ' +
                              CDS2.FieldByName('SOURCEID').AsString + ' | ' +
        '  |  = [YHC]  : | '+ CDS.FieldByName('FIRST_NAME').AsString + ' | ' +
                              CDS.FieldByName('LAST_NAME').AsString + ' | ' +
                              CDS.FieldByName('EMAIL').AsString + ' | ' +
                              CDS.FieldByName('POSITION').AsString + ' | ' +
                              CDS.FieldByName('COMPANY').AsString + ' | ' +
                              CDS.FieldByName('CITY').AsString + ' | ' +
                              CDS.FieldByName('STATE').AsString );
        end;
      CDS.Next;
    end;
    CDS2.Next;
  end;
  CDS.EnableControls;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SoundexSearch;
end;

procedure TForm1.SoundexSearch;
begin
  Memo1.Lines.Add('Soundex ------------------------------------------------- ');
  CDS.First;
  CDS2.First;
  CDS.DisableControls;
  CDS2.DisableControls;
  while not CDS2.eof do
  begin
    CDS.First;
    while not CDS.eof do
    begin
      if ((Soundex(CDS.FieldByName('FIRST_NAME').AsString) = soundex(CDS2.FieldByName('FIRST_NAME').AsString))) and
         ((soundex(CDS.FieldByName('LAST_NAME').AsString) = soundex(CDS2.FieldByName('LAST_NAME').AsString))) then
      begin
      if not ((CDS.FieldByName('FIRST_NAME').AsString = CDS2.FieldByName('FIRST_NAME').AsString) and
         (CDS.FieldByName('LAST_NAME').AsString = CDS2.FieldByName('LAST_NAME').AsString)) then
        Memo1.Lines.Add
       ('Found [Conf] : |' +  CDS2.FieldByName('FIRST_NAME').AsString + ' | ' +
                              CDS2.FieldByName('LAST_NAME').AsString + ' | ' +
                              CDS2.FieldByName('POSITION').AsString + ' | ' +
                              CDS2.FieldByName('COMPANY').AsString + ' | ' +
                              CDS2.FieldByName('CITY').AsString + ' | ' +
                              CDS2.FieldByName('STATE').AsString + ' | ' +
                              CDS2.FieldByName('SOURCEID').AsString + ' | ' +
        '  |  = [YHC]  : | '+ CDS.FieldByName('FIRST_NAME').AsString + ' | ' +
                              CDS.FieldByName('LAST_NAME').AsString + ' | ' +
                              CDS.FieldByName('EMAIL').AsString + ' | ' +
                              CDS.FieldByName('POSITION').AsString + ' | ' +
                              CDS.FieldByName('COMPANY').AsString + ' | ' +
                              CDS.FieldByName('CITY').AsString + ' | ' +
                              CDS.FieldByName('STATE').AsString );      end;
      CDS.Next;
    end;
    CDS2.Next;
  end;
  CDS.EnableControls;
  CDS2.EnableControls;
end;

end.
