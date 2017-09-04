unit Activate;

//***********
	interface
//***********

uses
	Forms, StdCtrls, Controls, Classes, SysUtils, PDJ_XPCS, PDJ_XPB, PDJ_XPC,
  PDJ_XPGB, Graphics, ExtCtrls;

type
  TFActivate = class(TForm)
    GroupBox2: TPDJXPGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    GroupBox1: TPDJXPGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Password: TPDJXPEdit;
    Password_confirm: TPDJXPEdit;
    Email: TPDJXPEdit;
    Email_confirm: TPDJXPEdit;
    Activate: TPDJXPButton;
    Cancel: TPDJXPButton;
    Image1: TImage;
    Label2: TLabel;
    procedure ActivateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FActivate: TFActivate;

//****************
	implementation
//****************

{$R *.dfm}

procedure TFActivate.ActivateClick(Sender: TObject);
begin
	if Password.text<>Password_confirm.Text then begin
  	Password.SetFocus;
    raise exception.Create('Passwords don''t match !!!');
  end;

	if Email.text<>Email_confirm.Text then begin
  	Email.SetFocus;
    raise exception.Create('Emails don''t match !!!');
  end;

  ModalResult:=mrOk;
end;

end.
