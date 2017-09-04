unit editFileset;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PDJ_XPCS, PDJ_XPB, StdCtrls, PDJ_XPC, PDJ_XPEB, PDJ_XPSpB;

type
  TeditFilesetDlg = class(TForm)
    PDJXPButton1: TPDJXPButton;
    PDJXPButton2: TPDJXPButton;
    edtInputFolder: TPDJXPEditBtn;
    edtOutputFolder: TPDJXPEditBtn;
    cbSubDirs: TPDJXPCheckBox;
    edtPrefix: TPDJXPEdit;
    edtPostfix: TPDJXPEdit;
    cbMask: TPDJXPComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PDJXPButton3: TPDJXPButton;
    procedure edtInputFolderEButtons0Click(Sender: TObject);
    procedure PDJXPButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  editFilesetDlg: TeditFilesetDlg;

implementation

{$R *.dfm}

uses
  filectrl, darin_file, help;

//------------------------------------------------------------------------------

procedure TeditFilesetDlg.edtInputFolderEButtons0Click(Sender: TObject);
var
  temp : string;
  edit : TPDJXPEdit;
begin
  edit := TPDJXPEdit(TPDJXPSpeedButton(sender).Parent);
  if(directoryexists(edit.text))then temp := edit.text;
  SelectDirectory('Select Folder','',temp);
  if directoryexists(temp) then edit.text := addDirSlash(temp);
end;

//------------------------------------------------------------------------------

procedure TeditFilesetDlg.PDJXPButton3Click(Sender: TObject);
begin
  showHelp(ftEditFileset);
end;

//------------------------------------------------------------------------------

end.
