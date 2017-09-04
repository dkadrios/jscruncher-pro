unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TsplashDlg = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  splashDlg: TsplashDlg;

implementation

{$R *.dfm}

uses
  darin_file, unit1;

//------------------------------------------------------------------------------

procedure TsplashDlg.FormCreate(Sender: TObject);
begin
  label1.Caption := formatVersionNumber();
  shape1.Align   := alClient;
end;

//------------------------------------------------------------------------------

end.
