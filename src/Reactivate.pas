unit Reactivate;

//***********
	interface
//***********

uses
	Forms, StdCtrls, Controls, Classes, SysUtils, Graphics, ExtCtrls,
  PDJ_XPCS, PDJ_XPB, PDJ_XPC, PDJ_XPGB;

type
  TFReactivate = class(TForm)
    GroupBox2: TPDJXPGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TPDJXPGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Password: TPDJXPEdit;
    New_password: TPDJXPEdit;
    New_password_confirm: TPDJXPEdit;
    Email: TPDJXPButton;
    Reactivate: TPDJXPButton;
    Cancel: TPDJXPButton;
    Image1: TImage;
    procedure ReactivateClick(Sender: TObject);
    procedure EmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReactivate: TFReactivate;

//****************
	implementation
//****************

uses
	Protection, protection_inc, Dialogs, DNA_int;

{$R *.dfm}

procedure TFReactivate.ReactivateClick(Sender: TObject);
begin
	if New_password.text<>New_password_confirm.Text then begin
  	New_password.SetFocus;
    raise exception.Create('Passwords don''t match !!!');
  end;

  ModalResult:=mrOk;
end;

procedure TFReactivate.EmailClick(Sender: TObject);
var
	code:string;
  err:integer;
begin
  err:=DNA_SendPassword(pchar( ProductKey() ),pchar(code));
	if err=0 then begin
	  ShowMessage('Your password has been sent !!!');
    password.SetFocus;
  end
  else
	  ShowMessage(GetErrorMsg(err));
end;

end.

