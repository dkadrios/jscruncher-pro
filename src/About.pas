unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, PDJ_XPGB, PDJ_XPCS, PDJ_XPB;

type
  TAboutDlg = class(TForm)
    Label3: TLabel;
    Button1: TPDJXPButton;
    Shape1: TShape;
    Panel1: TPDJXPGroupBox;
    Image1: TImage;
    Label7: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    registeredLabel: TLabel;
    Image2: TImage;
    RichEdit1: TRichEdit;
    lblPurchase: TLabel;
    Image3: TImage;
    procedure Label1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblPurchaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutDlg: TAboutDlg;

implementation

uses
  ShellAPI, unit1, DNA_INT;

{$R *.DFM}

//------------------------------------------------------------------------------

procedure TAboutDlg.Label1Click(Sender: TObject);
begin
   if sender = label1 then
      form1.launchURL('http://www.nebiru.com')
   else
      form1.launchURL('http://www.domapi.com');
   close;
end;

//------------------------------------------------------------------------------

procedure TAboutDlg.Button1Click(Sender: TObject);
begin close(); end;

//------------------------------------------------------------------------------

procedure TAboutDlg.FormCreate(Sender: TObject);
var
  daysLeft : integer;
  s        : string;
  msg      : array[0..127] of char;
  expires  : tdatetime;
  // see https://www.softworkz.com/login/admin/documents/dna_api_custom_devguide_300_121104.pdf
begin
  Shape1.Align  := alClient;
  //richedit1.Lines.LoadFromFile(extractfilepath(application.ExeName) + 'license.txt');
  label1.left   := label2.Left + label2.Width;
  label6.left   := label1.Left + label1.Width;

  DNA_Param('EVAL_CODE', msg, sizeof(msg));

  if(msg = '1')then begin // evaluation
    DNA_Param('EXPIRY_DATE', msg, sizeof(msg));
    expires := StrToDate(msg);
    daysLeft := trunc(expires - now) + 1;
    s := ' day';
    if(daysLeft > 1)then s := s + 's';
    registeredLabel.Caption := '- EVALUATION COPY -' + #13 + inttostr(daysLeft) + s + ' left';
    lblPurchase.visible := true;
  end else begin
    registeredLabel.Caption := '';
    lblPurchase.visible := false;
  end;
end;

//------------------------------------------------------------------------------

procedure TAboutDlg.lblPurchaseClick(Sender: TObject);
begin
  ShellExecute(handle,'open','http://domapi.com/jscruncherpro/purchase.cfm',nil,'',SW_SHOW);
end;

//------------------------------------------------------------------------------

end.
