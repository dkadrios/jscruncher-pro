unit confirmation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PDJ_XPB, PDJ_XPCS, ExtCtrls;

type
  TConfirmationDlg = class(TForm)
    CheckBox1: TPDJXPCheckBox;
    Button1: TPDJXPButton;
    PDJXPButton1: TPDJXPButton;
    Panel1: TPanel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfirmationDlg: TConfirmationDlg;

implementation

{$R *.dfm}

end.
