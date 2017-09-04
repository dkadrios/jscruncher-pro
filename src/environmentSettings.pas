unit environmentSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, CheckLst, ImgList,
  ShellCtrls, StShlCtl, SsShlDlg, PDJ_XPRGB, PDJ_XPCS, PDJ_XPC,
  PDJ_XPB, PDJ_XPGB, PDJ_XPSpB, PDJ_XPEB;

type
  TenvironmentSettingsDlg = class(TForm)
    Button1: TPDJXPButton;
    Button2: TPDJXPButton;
    PageControl1: TPageControl;
    xpTabSheet1: TTabSheet;
    xpTabSheet2: TTabSheet;
    xpTabSheet3: TTabSheet;
    GroupBox3: TPDJXPGroupBox;
    editLog: TPDJXPEditBtn;
    GroupBox2: TPDJXPGroupBox;
    editMap: TPDJXPEditBtn;
    cbAddsToMapFile: TPDJXPCheckBox;
    cbCombineStrings: TPDJXPCheckBox;
    Label3: TLabel;
    SpeedButton1: TPDJXPSpeedButton;
    GroupBox4: TPDJXPGroupBox;
    cbPlaySounds: TPDJXPCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape29: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    editUserDefinedMap: TPDJXPEditBtn;
    Label1: TLabel;
    Label2: TLabel;
    cbShowCompressionSettingsDialog: TPDJXPCheckBox;
    cbInputSameAsOutputWithPrefix: TPDJXPCheckBox;
    cbInputSameAsOutputWithoutPrefix: TPDJXPCheckBox;
    cbInputFolderMissing: TPDJXPCheckBox;
    PDJXPButton1: TPDJXPButton;
    procedure btnBrowseRepClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure PDJXPButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  environmentSettingsDlg: TenvironmentSettingsDlg;

implementation

{$R *.dfm}

uses
   filectrl, help, darin_file, mapChooser;

//------------------------------------------------------------------------------

procedure TenvironmentSettingsDlg.btnBrowseRepClick(Sender: TObject);
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

procedure TenvironmentSettingsDlg.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
begin
   if (modalResult = mrOK) then begin
      if(not directoryexists(editMap.text)) then begin
         messagedlg('Map folder does not exist.',mtError,[mbOk],0);
         editMap.SelectAll();
         editMap.SetFocus();
         canclose := false;
      end else if(not directoryexists(editLog.text)) then begin
         messagedlg('Log folder does not exist.',mtError,[mbOk],0);
         editLog.SelectAll();
         editLog.SetFocus();
         canclose := false;
      end else
         canClose := true;
   end else
      canClose := true;
end;

//------------------------------------------------------------------------------

procedure TenvironmentSettingsDlg.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

//------------------------------------------------------------------------------

procedure TenvironmentSettingsDlg.SpeedButton1Click(Sender: TObject);
begin
  mapChooserDlg := TmapChooserDlg.create(self);
  try
    mapChooserDlg.mapPath := editMap.Text;
    mapChooserDlg.UDMap   := editUserDefinedMap.Text;
    mapChooserDlg.ShowModal();

    if(mapChooserDlg.ModalResult = mrOK)then begin
      editMap.Text := mapChooserDlg.mapPath;
      if(mapChooserDlg.StShellListView1.SelectedItem <> nil) then
        editUserDefinedMap.Text := mapChooserDlg.StShellListView1.SelectedItem.DisplayName;
    end;
  finally
    mapChooserDlg.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TenvironmentSettingsDlg.PageControl1DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  with Control.Canvas do begin
    FillRect(Rect);
    TextOut(Rect.Left + 4, Rect.Top + 2, (Control as TPageControl).Pages[TabIndex].Caption);
  end;
end;

//------------------------------------------------------------------------------

procedure TenvironmentSettingsDlg.PDJXPButton1Click(Sender: TObject);
begin
  showHelp(ftEnvironmentSettings);
end;

//------------------------------------------------------------------------------

end.

