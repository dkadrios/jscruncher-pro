unit editProject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mxTaskPaneItems, mxNavigationBar, PDJ_XPCS, PDJ_XPB, ComCtrls,
  StdCtrls, PDJ_XPGB, ExtCtrls, objects, PDJ_XPC, PDJ_XPSpB,
  Grids_ts, TSGrid, PDJ_XPEB, CheckLst, PDJ_XPRGB, PDJ_XPCHL;

type
  TEditingType = (etAll, etCompression, etText);

  TeditProjectDlg = class(TForm)
    Panel1: TPanel;
    btnOk: TPDJXPButton;
    PDJXPButton2: TPDJXPButton;
    Shape2: TShape;
    Panel2: TPanel;
    Timer1: TTimer;
    Label16: TLabel;
    radioManage: TPDJXPRadioGroup;
    mxContainer1: TmxContainer;
    Panel4: TPanel;
    nb: TNotebook;
    Label14: TLabel;
    PDJXPGroupBox2: TPDJXPGroupBox;
    cbDoCompressFiles: TPDJXPCheckBox;
    cbDoManageTags: TPDJXPCheckBox;
    Label3: TLabel;
    edtLogFolder: TPDJXPEditBtn;
    Shape1: TShape;
    gridSelCompress: TtsGrid;
    sbAddCompress: TPDJXPSpeedButton;
    sbRemoveCompress: TPDJXPSpeedButton;
    Label13: TLabel;
    Label12: TLabel;
    GroupBox3: TPDJXPGroupBox;
    edPreamble: TPDJXPMemo;
    cbPreambleEnabled: TPDJXPCheckBox;
    gbOutput: TPDJXPGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    lblSample: TLabel;
    edDestination: TPDJXPEditBtn;
    edPrefix: TPDJXPEdit;
    edPostfix: TPDJXPEdit;
    lbMaps: TPDJXPCheckListBox;
    Label7: TLabel;
    cbObfuscationEnabled: TPDJXPCheckBox;
    Label11: TLabel;
    Label9: TLabel;
    PDJXPGroupBox3: TPDJXPGroupBox;
    cbCompressionEnabled: TPDJXPCheckBox;
    cbFixSemicolons: TPDJXPCheckBox;
    cbComments: TPDJXPCheckBox;
    cbWhitespace: TPDJXPCheckBox;
    cbExtraSemicolons: TPDJXPCheckBox;
    cbCombineStrings: TPDJXPCheckBox;
    pnlWhitespace: TPanel;
    cbTabs: TPDJXPCheckBox;
    cbSpaces: TPDJXPCheckBox;
    cbCarriageReturn: TPDJXPCheckBox;
    cbLinefeed: TPDJXPCheckBox;
    cbFormfeed: TPDJXPCheckBox;
    PDJXPGroupBox4: TPDJXPGroupBox;
    Label8: TLabel;
    addBtn: TPDJXPSpeedButton;
    delBtn: TPDJXPSpeedButton;
    Shape4: TShape;
    gridSelPunct: TtsGrid;
    Label10: TLabel;
    gridSelManage: TtsGrid;
    sbAddManage: TPDJXPSpeedButton;
    sbRemoveManage: TPDJXPSpeedButton;
    Shape3: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Panel3: TPanel;
    mxNavBarCaption7: TmxNavBarCaption;
    nbManageSelections: TmxNavBarCaption;
    mxNavBarCaption1: TmxNavBarCaption;
    nbCompressAdvanced: TmxNavBarCaption;
    nbCompressSettings: TmxNavBarCaption;
    nbCompressSelections: TmxNavBarCaption;
    mxNavBarCaption2: TmxNavBarCaption;
    nbBasic: TmxNavBarCaption;
    nbObfuscation: TmxNavBarCaption;
    nbManageSettings: TmxNavBarCaption;
    Image1: TImage;
    imgUnchecked: TImage;
    imgChecked: TImage;
    PDJXPButton1: TPDJXPButton;
    sbEditCompress: TPDJXPSpeedButton;
    sbEditManage: TPDJXPSpeedButton;
    cbShowSettingsDialog: TPDJXPCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure nbBasicClick(Sender: TObject);
    procedure cbDoCompressFilesClick(Sender: TObject);
    procedure PDJXPEditBtn1EButtons0Click(Sender: TObject);
    procedure sbAddCompressClick(Sender: TObject);
    procedure sbRemoveManageClick(Sender: TObject);
    procedure gridSelManageCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure gridSelManageGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
    procedure Timer1Timer(Sender: TObject);
    procedure gridSelPunctCellEdit(Sender: TObject; DataCol, DataRow: Integer; ByUser: Boolean);
    procedure gridSelPunctCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure addBtnClick(Sender: TObject);
    procedure delBtnClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure gridSelPunctClickCell(Sender: TObject; DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos, UpPos: TtsClickPosition);
    procedure gridSelPunctPaintCell(Sender: TObject; DataCol, DataRow: Integer; ARect: TRect; State: TtsPaintCellState;var Cancel: Boolean);
    procedure PDJXPButton1Click(Sender: TObject);
    procedure sbEditCompressClick(Sender: TObject);
    procedure gridSelCompressDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fEditingType: TEditingType;
    function  getFileSetList:TJSCPFileSetList;// TProjectFileList;
    function  getGrid: TtsGrid;
    procedure setEditingType(const Value: TEditingType);
    function  editFileSet(const fs:TJSCPFileSet):boolean;
  private
    { Private declarations }
    aProject : TJSCPProject;
    procedure setProject(const Value: TJSCPProject);
    property  grid : TtsGrid read getGrid;
    property  fileSetList : TJSCPFileSetList read getFileSetList;
  public
    { Public declarations }
    property project : TJSCPProject read aProject write setProject;
    property editingType : TEditingType read fEditingType write setEditingType;
  end;

var
  editProjectDlg: TeditProjectDlg;

implementation

{$R *.dfm}

uses
  mxGraphics, jclsysutils, filectrl, darin_file, settings, help, editFileset, unit1;

var
  pMarks,
  pMarksBefore,
  pMarksAfter : string;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.FormCreate(Sender: TObject);
begin
  nb.ActivePage := 'basic';
end;

//------------------------------------------------------------------------------

function TeditProjectDlg.getFileSetList: TJSCPFileSetList;
begin
  if(nb.ActivePage = 'compressSelections')then result := aProject.filesToCompress
  else if(nb.ActivePage = 'manageSelections')then result := aProject.filesToManage
  else result := nil;
end;

//------------------------------------------------------------------------------

function TeditProjectDlg.getGrid: TtsGrid;
begin
  if(nb.ActivePage = 'compressSelections')then result := gridSelCompress
  else if(nb.ActivePage = 'manageSelections')then result := gridSelManage
  else result := nil;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.nbBasicClick(Sender: TObject);
begin
  if(not TmxNavBarCaption(sender).Enabled)then exit;

  nbBasic              .Background.Gradient.beginColor := clWhite;
  nbBasic              .Background.Gradient.endColor   := clWhite;
  nbCompressSelections .Background.Gradient.beginColor := clWhite;
  nbCompressSelections .Background.Gradient.endColor   := clWhite;
  nbCompressSettings   .Background.Gradient.beginColor := clWhite;
  nbCompressSettings   .Background.Gradient.endColor   := clWhite;
  nbObfuscation        .Background.Gradient.beginColor := clWhite;
  nbObfuscation        .Background.Gradient.endColor   := clWhite;
  nbCompressAdvanced   .Background.Gradient.beginColor := clWhite;
  nbCompressAdvanced   .Background.Gradient.endColor   := clWhite;
  nbManageSelections   .Background.Gradient.beginColor := clWhite;
  nbManageSelections   .Background.Gradient.endColor   := clWhite;
  nbManageSettings     .Background.Gradient.EndColor   := clWhite;

  TmxNavBarCaption(sender).Background.Gradient.beginColor := $00D3D3D3;
  TmxNavBarCaption(sender).Background.Gradient.endColor   := $00DFA17C;

  if(sender = nbBasic             )then nb.ActivePage := 'basic';
  if(sender = nbCompressSelections)then nb.ActivePage := 'compressSelections';
  if(sender = nbCompressSettings  )then nb.ActivePage := 'compressSettings';
  if(sender = nbObfuscation       )then nb.ActivePage := 'obfuscation';
  if(sender = nbCompressAdvanced  )then nb.ActivePage := 'compressAdvanced';
  if(sender = nbManageSelections  )then nb.ActivePage := 'manageSelections';
  if(sender = nbManageSettings    )then nb.ActivePage := 'manageSettings';
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.setProject(const Value: TJSCPProject);
var
  i : integer;
  s : TJSCPProjectSettings;
begin
  aProject := value;
  s        := aProject.settings;
  // load the form from the project
  cbDoCompressFiles.checked    := aProject.doCompressFiles;
  cbFixSemicolons.Checked      := aProject.settings.doAutoFixSemicolons;
  cbDoManageTags   .checked    := aProject.doManageFiles;
  edtLogFolder.Text            := s.logFolder;
  gridSelCompress.rows         := aProject.filesToCompress.Count;
  gridSelManage.rows           := aProject.filesToManage.Count;
  cbPreambleEnabled.Checked    := s.doPreamble;
  edPreamble.Text              := s.preamble_str;
  edPrefix.Text                := s.defPrefix;
  edPostfix.text               := s.defPostfix;
  edDEstination.Text           := s.outputFolder;
//  cbEmptyFolder.Checked        := s.doClearOutputFirst;
  cbObfuscationEnabled.Checked := s.doObfuscate;

  lbMaps.Items.Clear();
  for i := 0 to s.maps.Count-1 do begin
    if(s.maps[i] <> s.SessionMap)then begin
      lbMaps.Items.Add(extractFilename(s.maps[i].filename));
      lbMaps.Checked[lbMaps.Items.count-1] := s.mapFilesToUse.IndexOf(lowercase(lbMaps.Items[lbMaps.Items.count-1])) > -1;
    end;
  end;

  cbCompressionEnabled.Checked := s.doCompress;
  cbExtraSemicolons.Checked    := s.fineTunings.ExtraSemicolons;
  cbWhitespace.Checked         := s.fineTunings.Whitespace;
  cbComments.Checked           := s.fineTunings.Comments;
  cbCombineStrings.Checked     := s.fineTunings.CombineStrings;
  cbTabs.Checked               := s.fineTunings.Tabs;
  cbLinefeed.Checked           := s.fineTunings.Linefeed;
  cbCarriageReturn.Checked     := s.fineTunings.CarriageReturn;
  cbFormfeed.Checked           := s.fineTunings.Formfeed;
  cbSpaces.Checked             := s.fineTunings.ExtraSpaces;
  gridSelPunct.Rows            := length(s.punctMarks);
  pMarks                       := s.punctMarks;
  pMarksBefore                 := s.punctMarksBefore;
  pMarksAfter                  := s.punctMarksAfter;

//  radioManage.ItemIndex        := iff(s.manageUsesCompressed, 0, 1);

  cbDoCompressFilesClick(nil);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.cbDoCompressFilesClick(Sender: TObject);
begin
  nbCompressSelections.Enabled := cbDoCompressFiles.Checked;
  nbCompressSettings  .Enabled := cbDoCompressFiles.Checked;
  nbObfuscation       .Enabled := cbDoCompressFiles.Checked;
  nbCompressAdvanced  .Enabled := cbDoCompressFiles.Checked;
  nbManageSelections  .Enabled := cbDoManageTags   .Checked;
  nbManageSettings    .Enabled := cbDoManageTags   .Checked;

  nbCompressSelections.Font.Color := iff(nbCompressSelections.Enabled, clBlack, clSilver);
  nbCompressSettings  .Font.Color := iff(nbCompressSettings  .Enabled, clBlack, clSilver);
  nbObfuscation       .Font.Color := iff(nbCompressSettings  .Enabled, clBlack, clSilver);
  nbCompressAdvanced  .Font.Color := iff(nbCompressAdvanced  .Enabled, clBlack, clSilver);
  nbManageSelections  .Font.Color := iff(nbManageSelections  .Enabled, clBlack, clSilver);
  nbManageSettings    .Font.Color := iff(nbManageSettings    .Enabled, clBlack, clSilver);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.PDJXPEditBtn1EButtons0Click(Sender: TObject);
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

procedure TeditProjectDlg.sbAddCompressClick(Sender: TObject);   // add
var
  fs : TJSCPFileSet;
begin
  fs := fileSetList.Add();
  if(fileSetList.Count > 1)then begin
    fs.inputFolder           := fileSetList.Items[fileSetList.count-2].inputFolder;
    fs.mask                  := fileSetList.Items[fileSetList.count-2].mask;
    fs.includeSubDirectories := fileSetList.Items[fileSetList.count-2].includeSubDirectories;
  end else begin
    fs.includeSubDirectories := false;
    fs.mask := iff(grid = gridSelCompress, form1.cbFilesFilter.text, form1.cbTagsFilter.text);
  end;
  if (not editFileSet(fs)) then
    fileSetList.Delete(fs.Index);

 // fileSetList

  grid.Rows := fileSetList.Count;
  grid.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.sbRemoveManageClick(Sender: TObject);  // delete
var
  i : integer;
begin
  i := grid.SelectedRows.Last;
  while(i > 0)do begin
    fileSetList.Delete(i-1);
    i := grid.SelectedRows.Previous(i);
  end;
  grid.Rows := fileSetList.Count;
  grid.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelManageCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
begin
  case dataCol of
    1 : value := fileSetList[dataRow-1].inputFolder + extractFileMask(fileSetList[datarow-1].mask);
    2 : value := fileSetList[dataRow-1].outputFolder;
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelManageGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
begin
  if(datarow > 0) then drawInfo.Font.Color := iff(directoryexists(fileSetList[datarow-1].inputFolder), clBlack, clSilver);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.Timer1Timer(Sender: TObject);
begin
  cbFixSemicolons.Enabled    := cbCompressionEnabled.Checked;
  cbComments.Enabled         := cbCompressionEnabled.Checked;
  cbWhitespace.Enabled       := cbCompressionEnabled.Checked;
  cbExtraSemicolons.Enabled  := cbCompressionEnabled.Checked;
  cbCombineStrings.Enabled   := cbCompressionEnabled.Checked;

  cbTabs.Enabled             := cbWhitespace.checked and cbCompressionEnabled.Checked;
  cbCarriageReturn.Enabled   := cbWhitespace.checked and cbCompressionEnabled.Checked;
  cbLinefeed.Enabled         := cbWhitespace.checked and cbCompressionEnabled.Checked;
  cbFormfeed.Enabled         := cbWhitespace.checked and cbCompressionEnabled.Checked;
  cbSpaces.Enabled           := cbWhitespace.Checked and cbCompressionEnabled.Checked;
  gridSelPunct.Enabled       := cbWhitespace.Checked and cbCompressionEnabled.Checked;
  addBtn.Enabled             := cbWhitespace.Checked and cbCompressionEnabled.Checked;
  delBtn.Enabled             := cbWhitespace.Checked and cbCompressionEnabled.Checked;

  lbMaps.Enabled             := cbObfuscationEnabled.Checked;
  edPreamble.Enabled         := cbPreambleEnabled.Checked;
  lblSample.caption          := edPrefix.text + 'include' + edPostfix.text + '.js';
  sbRemoveCompress.enabled   := (nb.ActivePage = 'compressSelections') and (grid.SelectedRows.Count > 0);
  sbRemoveManage.enabled     := (nb.ActivePage = 'manageSelections'  ) and (grid.SelectedRows.Count > 0);
  sbEditCompress.enabled     := sbRemoveCompress.enabled;
  sbEditManage.enabled       := sbRemoveManage.enabled;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelPunctCellEdit(Sender: TObject; DataCol, DataRow: Integer; ByUser: Boolean);
var
  p : string[1];
begin
  if (datacol = 1) then begin
    p := String(gridSelPunct.currentCell.value)[1];
    pMarks[dataRow] := p[1];
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelPunctCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  p : string;
begin
  if(datarow > length(pMarks)) or (datarow < 1) then exit;
  p := pMarks[datarow];
  case datacol of
    1 : value := p;
    2 : value := iff(pos(p, pMarksBefore) > 0, 'Y', 'N');
    3 : value := iff(pos(p, pMarksAfter ) > 0, 'Y', 'N');
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.addBtnClick(Sender: TObject);
var
  value : string;
  r     : integer;
begin
  if(InputQuery('New symbol', 'Enter new symbol', Value))then begin
    if(length(value) > 0)then
      pMarks := pMarks + value[1];
    r := length(pMarks);
    gridSelPunct.Rows   := r;
    gridSelPunct.toprow := r;
    gridSelPunct.SelectRows(r, r, true);
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.delBtnClick(Sender: TObject);
var
  p : string;
  i : integer;
begin
  if(gridSelPunct.CurrentDataRow > 0)then begin
    p := pMarks[gridSelPunct.CurrentDataRow];
    delete(pMarks, gridSelPunct.CurrentDataRow, 1);

    i := pos(p, pMarksBefore);
    if(i > 0)then delete(pMarksBefore,  i, 1);

    i := pos(p, pMarksAfter);
    if(i > 0)then delete(pMarksAfter,   i, 1);

    gridSelPunct.Rows := length(pMarks);
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.btnOkClick(Sender: TObject);
var
  s : TJSCPProjectSettings;
  i : integer;
begin
  // transfer the settings back to the project
  s := aProject.settings;

  if(fEditingType = etCompression)then begin
    project.filesToCompress.Items[0].outputFolder := edDestination.text;
    project.filesToCompress.Items[0].prefix       := edPrefix     .text;
    project.filesToCompress.Items[0].postfix      := edPostfix    .text;
  end;

  aProject.doCompressFiles    := cbDoCompressFiles.checked;
  aProject.doManageFiles      := cbDoManageTags   .checked;
  s.logFolder                 := edtLogFolder.Text;
  s.doCompress                := cbCompressionEnabled.Checked;
  s.doAutofixSemicolons       := cbFixSemicolons.Checked;
  s.doObfuscate               := cbObfuscationEnabled.Checked;
  s.defPrefix                 := edPrefix.Text;
  s.defPostfix                := edPostfix.Text;
  s.doPreamble                := cbPreambleEnabled.Checked;
  s.outputFolder              :=  edDestination.text;
//  s.doClearOutputFirst        := cbEmptyFolder.Checked;
  s.preamble_str              := edPreamble.Text;
  s.mapFilesToUse.clear();
  for i := 0 to lbMaps.Items.Count-1 do
    if(lbMaps.Checked[i])then begin
      s.mapFilesToUse.add(lowercase(lbMaps.Items[i]));
    end;
  s.fineTunings.ExtraSemicolons  := cbExtraSemicolons.Checked;
  s.fineTunings.Whitespace       := cbWhitespace.Checked;
  s.fineTunings.Comments         := cbComments.Checked;
  s.fineTunings.CombineStrings   := cbCombineStrings.Checked;
  s.fineTunings.Tabs             := cbTabs.Checked;
  s.fineTunings.Linefeed         := cbLinefeed.Checked;
  s.fineTunings.CarriageReturn   := cbCarriageReturn.Checked;
  s.fineTunings.Formfeed         := cbFormfeed.Checked;
  s.fineTunings.ExtraSpaces      := cbSpaces.Checked;
  s.punctMarks                   := pMarks;
  s.punctMarksBefore             := pMarksBefore;
  s.punctMarksAfter              := pMarksAfter;
//  s.manageUsesCompressed         := iff(radioManage.ItemIndex = 0, true, false);

  form1.formSettings.lastTabIndexInProjectEditor := nb.ActivePage;
  form1.formSettings.doShowCompressionSettings   := cbShowSettingsDialog.Checked;
  form1.formSettings.SaveFormSettings();

  modalResult := mrOk; // close the window
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelPunctClickCell(Sender: TObject;
  DataColDown, DataRowDown, DataColUp, DataRowUp: Integer; DownPos,
  UpPos: TtsClickPosition);
var
  c : string[1];
  i : integer;
begin
  if(DataRowUp >0) and (datacolup > 1) then begin
    c := pMarks[datarowup];
    case datacolup of
      2 : begin
        i := pos(c, pMarksBefore);
        if (i = 0)then pMarksBefore := pMarksBefore + c
        else delete(pMarksBefore, i, 1);
      end;
      3 : begin
        i := pos(c, pMarksAfter );
        if (i = 0)then pMarksAfter := pMarksAfter + c
        else delete(pMarksAfter, i, 1);
      end;
    end;
  end;

  gridSelPunct.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelPunctPaintCell(Sender: TObject; DataCol,
  DataRow: Integer; ARect: TRect; State: TtsPaintCellState;
  var Cancel: Boolean);
var
  s : string[1];
  x : integer;
begin
  if(datarow >0) and (datacol > 1) then begin
    case datacol of
      2 : s := iff(pos(pMarks[datarow], pMarksBefore) > 0, 'Y', 'N');
      3 : s := iff(pos(pMarks[datarow], pMarksAfter ) > 0, 'Y', 'N');
    end;
    gridSelPunct.Canvas.FillRect(arect);
    x := (arect.Right - arect.left) div 2 + arect.left - 5;
    if(s = 'Y')then
      gridSelPunct.Canvas.Draw(x, arect.Top+1, imgChecked.Picture.Graphic)
    else
      gridSelPunct.Canvas.Draw(x, arect.Top+1, imgUnchecked.Picture.Graphic);
    cancel := true;
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.PDJXPButton1Click(Sender: TObject);
begin
  showHelp(htEditProject);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.setEditingType(const Value: TEditingType);
begin
  fEditingType := Value;
  if(value in [etCompression, etText])then begin
    mxNavBarCaption7    .visible := false;
    nbBasic             .visible := false;
    mxNavBarCaption1    .visible := false;
    nbManageSelections  .visible := false;
    nbManageSettings    .visible := false;
    nbCompressSelections.visible := false;
    cbDoCompressFiles   .Checked := true;
    edDestination       .Enabled := false;
    cbDoCompressFilesClick(cbDoCompressFiles);
    nbBasicClick(nbCompressSettings);
  end;
  cbShowSettingsDialog.visible := value in [etCompression, etText];
  gbOutput.visible := value = etCompression;
  if(fEditingType = etCompression)then begin
    if(project.filesToCompress.Count = 0)then
      project.filesToCompress.Add();
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.sbEditCompressClick(Sender: TObject);
var
  fs : TJSCPFileSet;
begin
  fs := nil;
  if(grid.SelectedRows.Count = 1) then
    fs := fileSetList.items[grid.selectedRows.first - 1];
  if(fs <> nil)then editFileSet(fs);
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.gridSelCompressDblClickCell(Sender: TObject;DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  sbEditCompressClick(sbEditCompress);
end;

//------------------------------------------------------------------------------

function TeditProjectDlg.editFileSet(const fs: TJSCPFileSet):boolean;
begin
  editFilesetDlg := TeditFilesetDlg.create(self);
  try
    if(grid = gridSelCompress)then
      editFilesetDlg.cbMask.Items.Assign(form1.cbFilesFilter.Items)
    else if(grid = gridSelManage)then
      editFilesetDlg.cbMask.Items.Assign(form1.cbTagsFilter.Items);

    editFilesetDlg.edtInputFolder.text  := fs.inputFolder;
    editFilesetDlg.edtOutputFolder.text := fs.outputFolder;
    editFilesetDlg.cbSubDirs.checked    := fs.includeSubDirectories;
    editFilesetDlg.edtPrefix.text       := fs.prefix;
    editFilesetDlg.edtPostfix.text      := fs.postfix;
    editFilesetDlg.cbMask.text          := fs.mask;

    playsound(stContext);
    editFilesetDlg.ShowModal();
    result := editFilesetDlg.ModalResult = mrOK;

    if(result)then begin
      fs.inputFolder           := editFilesetDlg.edtInputFolder.text;
      fs.outputFolder          := editFilesetDlg.edtOutputFolder.text;
      fs.includeSubDirectories := editFilesetDlg.cbSubDirs.checked;
      fs.prefix                := editFilesetDlg.edtPrefix.text;
      fs.postfix               := editFilesetDlg.edtPostfix.text;
      fs.mask                  := editFilesetDlg.cbMask.text;
      playsound(stOK);
    end else playsound(stCancel);
  finally
    editFilesetDlg.Free();
  end;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.FormShow(Sender: TObject);
var
  s : string;
begin
  s := form1.formSettings.lastTabIndexInProjectEditor;
  if(s = 'basic'             ) and (nbBasic.Visible             )then nbBasicClick(nbBasic);
  if(s = 'compressSelections') and (nbCompressSelections.Visible)then nbBasicClick(nbCompressSelections);
  if(s = 'compressSettings'  ) and (nbCompressSettings.Visible  )then nbBasicClick(nbCompressSettings);
  if(s = 'obfuscation'       ) and (nbObfuscation.Visible       )then nbBasicClick(nbObfuscation);
  if(s = 'compressAdvanced'  ) and (nbCompressAdvanced.Visible  )then nbBasicClick(nbCompressAdvanced);
  if(s = 'manageSelections'  ) and (nbManageSelections.Visible  )then nbBasicClick(nbManageSelections);
  if(s = 'manageSettings'    ) and (nbManageSettings.Visible    )then nbBasicClick(nbManageSettings);
  cbShowSettingsDialog.Checked := form1.formSettings.doShowCompressionSettings;
end;

//------------------------------------------------------------------------------

procedure TeditProjectDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  i                              : integer;
  anInputFolderDoesntExist,
  inputSameAsOutputWithPrefix,
  inputSameAsOutputWithoutPrefix : boolean;
begin
  canclose                       := true;
  if(modalResult = mrCancel) and (editingType = etAll)then begin
    playsound(stDrop);
    canclose := MessageDlg('Sure to cancel?', mtWarning, [mbYes,mbNo], 0)
      = mrYes;
    exit;
  end;
  if(modalResult = mrCancel) then begin
    playSound(stCancel);
    exit;
  end;

  anInputFolderDoesntExist       := false;
  inputSameAsOutputWithPrefix    := false;
  inputSameAsOutputWithoutPrefix := false;

  if(cbDoCompressFiles.checked)then
    for i := 0 to project.filesToCompress.Count-1 do begin
      if(not directoryexists(project.filesToCompress[i].inputFolder)) then anInputFolderDoesntExist := true
      else if(project.filesToCompress[i].inputFolder = project.filesToCompress[i].outputFolder)then begin
        if(trim(project.filesToCompress[i].prefix ) = '') and
          (trim(project.filesToCompress[i].postfix) = '')
        then inputSameAsOutputWithoutPrefix := true
        else inputSameAsOutputWithPrefix := true;
      end;
    end;

  if(cbDoManageTags.checked)then
    for i := 0 to project.filesToManage.Count-1 do begin
      if(not directoryexists(project.filesToManage[i].inputFolder)) then anInputFolderDoesntExist := true
      else if(project.filesToManage[i].inputFolder = project.filesToManage[i].outputFolder)then begin
        if(trim(project.filesToManage[i].prefix ) = '') and
          (trim(project.filesToManage[i].postfix) = '')
        then inputSameAsOutputWithoutPrefix := true
        else inputSameAsOutputWithPrefix := true;
      end;
    end;

  if(editingType <> etText)then begin
    if(canclose and anInputFolderDoesntExist)then begin
      playSound(stDrop);
      canclose := form1.formSettings.showConfirmation(
        'One or more specified folders do not exist.'#13#10+
        'Continue anyways?', mtConfirmation, ctInputFolderMissing);
      if(not canClose)then playSound(stCancel);
    end;

    if(canclose and inputSameAsOutputWithoutPrefix)then begin
      canclose := form1.formSettings.showConfirmation(
        'One or more output folders are the same as the input folder,'#13#10+
        'and no file prefix or suffix has been provided.'#13#10#13#10+
        'THIS WILL OVERWRITE YOUR ORIGINAL FILES!!'#13#10#13#10+
        'Continue anyways?', mtConfirmation, ctInputSameAsOutputWithoutPrefix);
      if(not canClose)then playSound(stCancel);
    end else if(canclose and inputSameAsOutputWithPrefix)then begin
      playSound(stError);
      canclose := form1.formSettings.showConfirmation(
        'One or more output folders are the same as the input folder.'#13#10+
        'Continue anyways?', mtConfirmation, ctInputSameAsOutputWithPrefix);
      if(not canClose)then playSound(stCancel);
    end;
  end;
end;

//------------------------------------------------------------------------------

end.
