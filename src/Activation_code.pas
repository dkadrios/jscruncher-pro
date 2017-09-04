unit Activation_code;

//***********
	interface
//***********

uses
	windows, Forms, StdCtrls, Controls, Classes, SysUtils, PDJ_XPGB, PDJ_XPCS, PDJ_XPB,
  PDJ_XPC, Graphics, ExtCtrls;

type
  TFActivation_code = class(TForm)
    GroupBox1: TPDJXPGroupBox;
    Label2: TLabel;
    Activation_code: TPDJXPEdit;
    EvalCode: TPDJXPButton;
    Continue: TPDJXPButton;
    Cancel: TPDJXPButton;
    Image1: TImage;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    PDJXPButton1: TPDJXPButton;
    Shape1: TShape;
    procedure EvalCodeClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PDJXPButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FActivation_code: TFActivation_code;

implementation

uses
	Protection, protection_inc, Dialogs, DNA_int, requestEvalCode, shellAPI;

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TFActivation_code.EvalCodeClick(Sender: TObject);
var
	email : string;
  err   : integer;
begin
  requestEvalCodeDlg := TRequestEvalCodeDlg.Create(self);
  try
    if(requestEvalCodeDlg.ShowModal() <> mrOK)then exit;
    email := requestEvalCodeDlg.PDJXPEdit1.Text;
  finally
    requestEvalCodeDlg.free();
  end;
  showmessage( ProductKey() );
  err:=DNA_SendEvalCode(pchar(ProductKey()),pchar(email),1);
	if err=0 then begin
	  ShowMessage('Your evaluation code has been sent !!!');
  end
  else
	  ShowMessage(GetErrorMsg(err));
end;

//------------------------------------------------------------------------------

procedure TFActivation_code.Timer1Timer(Sender: TObject);
begin
  continue.Enabled := length(Activation_code.Text) >= 16;
end;

//------------------------------------------------------------------------------

procedure TFActivation_code.PDJXPButton1Click(Sender: TObject);
begin
  ShellExecute(handle,'open','http://domapi.com/jscruncherpro/purchase.cfm',nil,'',SW_SHOW);
end;

//------------------------------------------------------------------------------

end.
