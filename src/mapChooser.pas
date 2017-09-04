unit mapChooser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PDJ_XPCS, PDJ_XPB, StdCtrls, PDJ_XPC, PDJ_XPEB,
  objects, ExtCtrls, ComCtrls, StShlCtl;

type
  TmapChooserDlg = class(TForm)
    PDJXPEditBtn1: TPDJXPEditBtn;
    Label1: TLabel;
    PDJXPButton1: TPDJXPButton;
    PDJXPButton2: TPDJXPButton;
    StShellListView1: TStShellListView;
    Shape1: TShape;
    procedure StShellListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure PDJXPEditBtn1EButtons0Click(Sender: TObject);
    procedure StShellListView1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fMapPath,
    fUDMap : string;
    procedure setMapPath(const aPath:string);
  public
    { Public declarations }
    property mapPath:string read fMapPath write fMapPath;
    property UDMap : string write fUDMap;
  end;

var
  mapChooserDlg: TmapChooserDlg;

implementation

uses
  jclfileutils, filectrl, darin_file;

{$R *.dfm}

{ TForm2 }


procedure TmapChooserDlg.StShellListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  PDJXPButton1.Enabled := StShellListView1.SelectedItem <> nil;
end;

//------------------------------------------------------------------------------

procedure TmapChooserDlg.PDJXPEditBtn1EButtons0Click(Sender: TObject);
var
  path : string;
begin
  if(directoryexists(mapPath))then path := mapPath;
  SelectDirectory('Select Map Folder','',path);
  if directoryexists(path) then
    mapPath := path;
end;

//------------------------------------------------------------------------------

procedure TmapChooserDlg.setMapPath(const aPath: string);
var
  path : string;
begin
  fMapPath := addDirSlash(aPath);
  path                        := PathCompactPath(canvas.Handle, fMapPath, PDJXPEditBtn1.Width-40, cpCenter);
  PDJXPEditBtn1.Text          := path;
  StShellListView1.RootFolder := fMapPath;
  PDJXPButton1.Enabled        := StShellListView1.SelectedItem <> nil;
end;

//------------------------------------------------------------------------------

procedure TmapChooserDlg.StShellListView1DblClick(Sender: TObject);
begin
  PDJXPButton1.Enabled := StShellListView1.SelectedItem <> nil;
  if(PDJXPButton1.Enabled)then modalResult := mrOK;
end;

//------------------------------------------------------------------------------

procedure TmapChooserDlg.FormShow(Sender: TObject);
var
  i : integer;
begin
  setMapPath(mapPath);
  Application.ProcessMessages();
  for i := 0 to StShellListView1.Items.Count-1 do
    if(StShellListView1.Items[i].Caption = fUDMap)then begin
      StShellListView1.ItemIndex := i;
      break;
    end;
end;

//------------------------------------------------------------------------------

end.
