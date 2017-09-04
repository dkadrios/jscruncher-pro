unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Bevel1: TBevel;
    Label2: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
   jclstrings, blowfish, string_compression, darin_file;

const
   mapKey = 'eJwryTAsjs8sji/JSI3PNq6MT8svis8qTg4qzUvOSC0KKDIIjs81KYhPy8wxNgUAgb8QpQ==';

//------------------------------------------------------------------------------

procedure TForm1.Button1Click(Sender: TObject);
var
   f,e,s :string;
begin
   //showmessage(compressandencode(mapKey));
   if(not opendialog1.Execute) then exit;
   f := opendialog1.FileName;
   e := ExtractFileExt(f);
   if(e = '.jmap')then begin
      s := EncryptText(decodeanduncompress(mapKey),filetostring(f));
      stringtofile(ChangeFileExt(f,'.jmapx'),s);
   end;

   if(e = '.jmapx')then begin
      s := DecryptText(decodeanduncompress(mapKey),filetostring(f));
      stringtofile(ChangeFileExt(f,'.jmap'),s);
   end;

   messageBeep(MB_OK);
   showmessage('Done.');
end;

//------------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
  var
  p : string;
begin
  p := addDirSlash(extractfilepath(Application.ExeName));
  p := addDirSlash(MoveUpOneDir(p)) + 'build\maps';
  opendialog1.InitialDir := p;
end;

//------------------------------------------------------------------------------

procedure TForm1.Button2Click(Sender: TObject);
var
  f, e : string;
  list : tstringlist;
begin
  if(not opendialog1.Execute) then exit;
  f := opendialog1.FileName;
  e := ExtractFileExt(f);

  list := tstringlist.create();
  try
    if(e = '.jmap')then begin
      list.LoadFromFile(f);
      list.Sort();
      list.SaveToFile(f);
    end;

    if(e = '.jmapx')then begin
      list.Text := DecryptText(decodeanduncompress(mapKey),filetostring(f));
      list.Sort();
      stringtofile(f, EncryptText(decodeanduncompress(mapKey), list.Text));
    end;

  finally
    list.free();
  end;

  messageBeep(MB_OK);
  showmessage('Done.');
end;

//------------------------------------------------------------------------------

end.
