unit requestEvalCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PDJ_XPCS, PDJ_XPB, StdCtrls, PDJ_XPC;

type
  TrequestEvalCodeDlg = class(TForm) PDJXPEdit1: TPDJXPEdit;
    Label1: TLabel;
    Label2: TLabel;
    PDJXPButton1: TPDJXPButton;
    PDJXPButton2: TPDJXPButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  requestEvalCodeDlg: TrequestEvalCodeDlg;

implementation

{$R *.dfm}

end.
