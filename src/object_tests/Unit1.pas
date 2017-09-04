unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
    procedure validateError(Sender: TObject;const filenm, msg, context:string;const line:integer);
    procedure progress(Sender: TObject;const count, total:integer);
    procedure status(Sender: TObject;const aStatus:string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  objects, shellapi;

const
  projectURL = 'C:\sourcecode\nebiru\jscruncher_pro\build\projects\compress.jscp';

var
  project : TJSCPProject;

//------------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
begin
  label1.caption := projectURL;
  project := TJSCPProject.create('3.0.0', 'C:\sourcecode\nebiru\jscruncher_pro\build\');
  project.onValidatorError := validateError;
  project.onProgress       := progress;
  project.onStatus         := status;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormDestroy(Sender: TObject);
begin
  project.free();
end;

//------------------------------------------------------------------------------

procedure TForm1.Button1Click(Sender: TObject);
begin
  project.loadFromXML(projectURL);
  memo1.lines.add('ready');
end;

//------------------------------------------------------------------------------

procedure TForm1.Button2Click(Sender: TObject);
begin
  project.filesToCompress.validate();
  memo1.lines.add('done');
end;

//------------------------------------------------------------------------------

procedure TForm1.validateError(Sender: TObject; const filenm, msg,
  context: string; const line: integer);
begin
  memo1.Lines.Add(msg + ' ' + context + ' ' + filenm + ' ('+inttostr(line)+')');
end;

//------------------------------------------------------------------------------

procedure TForm1.progress(Sender: TObject; const count, total: integer);
begin
  ProgressBar1.Max := total;
  ProgressBar1.Position := count;
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TForm1.Button3Click(Sender: TObject);
begin
  project.run();
  memo1.lines.add('done');
end;

//------------------------------------------------------------------------------

procedure TForm1.Label1Click(Sender: TObject);
begin
  ShellExecute(handle,'open',pchar(label1.caption),'','',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.status(Sender: TObject; const aStatus: string);
begin
  label3.Caption := aStatus;
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

end.
 