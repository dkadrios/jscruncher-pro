unit backgroundTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, PDJ_XPCS, PDJ_XPPB,
  mxCustomControl, mxOutlookPanel, Grids_ts, TSGrid, objects,
  PDJ_XPB;

type
  TbackgroundTaskDlg = class(TForm)
    ProgressBar1: TPDJXPProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlErrorMessages: TPanel;
    pnlErrorsFound: TmxOutlookPanel;
    Label5: TLabel;
    Image1: TImage;
    Shape1: TShape;
    tgMessages: TtsGrid;
    PDJXPButton1: TPDJXPButton;
    oneshot: TTimer;
    procedure tgMessagesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure tgMessagesDblClick(Sender: TObject);
    procedure oneshotTimer(Sender: TObject);
    procedure PDJXPButton1Click(Sender: TObject);
  private
    { Private declarations }
    fProject : TJSCPProject;
    procedure OnProgressBar(Sender: TObject;const index, total: integer);
    procedure OnProgressText(Sender: TObject;const status     :string );
    procedure OnProgressText2(Sender: TObject;const status     :string );
    procedure OnCancelled(sender:tobject);
    procedure OnMessageAdded(Sender: TObject;const filenm, msg, context:string;const line:integer);
    procedure setProject(const Value: TJSCPProject);
  public
    { Public declarations }
    property  project : TJSCPProject read fProject write setProject;
  end;

var
  backgroundTaskDlg: TbackgroundTaskDlg;

implementation

uses
  shellapi, Unit1, jclfileutils;

{$R *.dfm}

//------------------------------------------------------------------------------

{ TbackgroundTaskDlg }

procedure TbackgroundTaskDlg.OnMessageAdded(Sender: TObject;const filenm, msg, context:string;const line:integer);
begin
  try
    // this next line can sometimes throw an error
    if(project = nil) or (project.errors = nil) then exit;
  except
    exit;
  end;

  if(project.errors.Count > 0) and (not panel2.Visible)then begin
    height         := 305;
    panel2.Visible := true;
  end;
  if(tgMessages <> nil)then
    tgMessages.rows := project.errors.count;
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.OnProgressBar(Sender: TObject;const index, total: integer);
begin
  try
    ProgressBar1.Max      := total;
    if(index > 0)then
      ProgressBar1.Position := index;
    Application.ProcessMessages();
  except end;
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.OnCancelled(sender: tobject);
begin
  label1.Caption := 'Operation cancelled.';
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.OnProgressText(Sender: TObject;const status: string);
begin
  label1.Caption := status;
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.OnProgressText2(Sender: TObject;const status: string);
begin
  label2.Caption := PathCompactPath(canvas.Handle, status, label2.Width, cpCenter); 
  Application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.tgMessagesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  m : TJSCPErrorMessage;
begin
  try
    m := project.errors[datarow-1];
    case datacol of
      1: value := m.msg;
      2: value := m.relativeFname;//m.script.fileobj.relativeFilename;
      3: value := inttostr(m.linenum) + ' : ' + m.line;
    end;
  except end;
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.FormShow(Sender: TObject);
begin
  oneshot.enabled := true;
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.setProject(const Value: TJSCPProject);
begin
  fProject       := value;
  Caption        := 'Running project ' + quotedstr(project.name);
  Height         := 120;
  Label2.caption := '';
  project.OnProgress       := OnProgressBar;
  project.onStatus         := OnProgressText;
  project.onStatus2        := OnProgressText2;
  project.onValidatorError := OnMessageAdded;
  project.onCancelled      := OnCancelled;
  project.settings.init();
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.tgMessagesDblClick(Sender: TObject);
var
  aParams,
  aFilename   : string;
  i,
  aLinenumber : integer;
  msg         : TJSCPErrorMessage;
begin
  if(tgMessages.SelectedRows.Count < 1) then exit;
  i           := tgMessages.SelectedRows.First - 1;
  msg         := project.errors[i];
  aLinenumber := msg.linenum;
  aFilename   := msg.fname;//msg.script.fileobj.inputFilename;
  aParams     := aFilename + ' ' + inttostr(aLinenumber);
  if(fileexists(aFilename))then
    ShellExecute(handle,'open',pchar(form1.pathToFileEditor),pchar(aParams),'',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.oneshotTimer(Sender: TObject);
var
  result : boolean;
begin
  oneshot.enabled := false;
  Application.ProcessMessages();

  result := project.run();
  if(project.cancelled)then begin
    Label2.caption := 'Operation cancelled.';
  end else if(result) and (project.errors.count = 0)then begin
    Label2.caption := 'Project completed without errors.';
    playSound(stSuccess);
  end else begin
    Label2.caption := 'Project completed with errors.';
    playSound(stError);
  end;
  Label1.caption                  := 'Done.';
  ProgressBar1.Position           := 0;
  PDJXPButton1.Enabled            := true;
  PDJXPButton1.Caption            := 'Close';
  PDJXPButton1.tag                := 1;
  tgMessages.Enabled              := true;
  label5.Caption := label5.caption + ' (double-click them to view/repair)';
  backgroundTaskDlg.ActiveControl := PDJXPButton1;
end;

//------------------------------------------------------------------------------

procedure TbackgroundTaskDlg.PDJXPButton1Click(Sender: TObject);
begin
  if(PDJXPButton1.tag = 1) then modalresult := mrOK
  else begin
    label1.Caption       := 'Awaiting cancel request...';
    PDJXPButton1.Enabled := false;
    project.cancelled    := true;
    Application.ProcessMessages();
  end;
end;

//------------------------------------------------------------------------------

end.
