unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ToolWin, ImgList, ActnList,
  XPStyleActnCtrls, ActnMan, ActnCtrls, ActnMenus, Grids_ts, TSGrid,
  AMHelper, TSImageList, mxTaskPaneItems,
  logObjects, Menus, ActnPopupCtrl, StdCtrls, mxCustomControl,
  mxOutlookPanel, ActnColorMaps, mxNavigationBar, XPMan, Contnrs;

type
  TForm1 = class(TForm)
    CoolBar1: TCoolBar;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    tree: TTreeView;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    loadAction: TAction;
    exitAction: TAction;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    tsCompress: TTabSheet;
    Splitter2: TSplitter;
    Panel3: TPanel;
    AMHelper: TActionManagerHelper;
    Panel4: TPanel;
    mxTaskPaneCaption2: TmxTaskPaneCaption;
    tgErrors: TtsGrid;
    Splitter3: TSplitter;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    mxTaskPaneCaption3: TmxTaskPaneCaption;
    mxTaskPaneCaption4: TmxTaskPaneCaption;
    tgObfuscatedTokens: TtsGrid;
    tgClearedTokens: TtsGrid;
    Panel8: TPanel;
    mxTaskPaneCaption1: TmxTaskPaneCaption;
    tgFiles: TtsGrid;
    Bevel1: TBevel;
    filesPopup: TPopupActionBarEx;
    errorsPopup: TPopupActionBarEx;
    obfuscatedPopup: TPopupActionBarEx;
    clearedPopup: TPopupActionBarEx;
    openFileAction: TAction;
    locateErrorAction: TAction;
    openMapfileAction: TAction;
    OpenEdit1: TMenuItem;
    Locate1: TMenuItem;
    Openmapfile1: TMenuItem;
    addToSessionMapAction: TAction;
    Addtosessionmap1: TMenuItem;
    mxOutlookPanel3: TmxOutlookPanel;
    lblStatus: TLabel;
    btnMap: TXPColorMap;
    tsTokens: TTabSheet;
    Panel9: TPanel;
    Panel10: TPanel;
    Bevel2: TBevel;
    mxTaskPaneCaption5: TmxTaskPaneCaption;
    tgFlatObfuscatedTokens: TtsGrid;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    mxNavBarCaption1: TmxNavBarCaption;
    tgObfuscatedTokensFileList: TtsGrid;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    tsManage: TTabSheet;
    Panel14: TPanel;
    mxTaskPaneCaption7: TmxTaskPaneCaption;
    tgScriptIncludes: TtsGrid;
    Panel15: TPanel;
    mxTaskPaneCaption6: TmxTaskPaneCaption;
    tgManageFiles: TtsGrid;
    Splitter4: TSplitter;
    XPManifest1: TXPManifest;
    Shape4: TShape;
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
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    procedure FormCreate(Sender: TObject);
    procedure loadActionExecute(Sender: TObject);
    procedure exitActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure treeChange(Sender: TObject; Node: TTreeNode);
    procedure tgFilesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgFilesHeadingClick(Sender: TObject; DataCol: Integer);
    procedure Panel5Resize(Sender: TObject);
    procedure tgFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
    procedure tgErrorsCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgObfuscatedTokensCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgClearedTokensCellLoaded(Sender: TObject; DataCol,  DataRow: Integer; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure tgClearedTokensGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
    procedure tgClearedTokensDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure tgErrorsDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure tgFilesDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure openFileActionExecute(Sender: TObject);
    procedure locateErrorActionExecute(Sender: TObject);
    procedure openMapfileActionExecute(Sender: TObject);
    procedure filesPopupPopup(Sender: TObject);
    procedure addToSessionMapActionExecute(Sender: TObject);
    procedure tsTokensResize(Sender: TObject);
    procedure tgFlatObfuscatedTokensCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgFlatObfuscatedTokensSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
    procedure tgObfuscatedTokensFileListCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgManageFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
    procedure tgScriptIncludesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgScriptIncludesDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure tgObfuscatedTokensDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure tgObfuscatedTokensGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
  private
    { Private declarations }
    fLogFiles : TObjectList;
    procedure assignImages;
    procedure loadFile(const aFilename:string);
    function getSelectedFile: TLogFile;
    procedure loadSettings;
    procedure saveSettings;
    function getSelectedClearedToken: TLogMapToken;
    function getSelectedError: TLogErrorMessage;
    function getSelectedObfuscatedToken: TLogMapToken;
    function getPathToFileEditor: string;
    function getSelectedFlatObfuscatedToken: TLogMapToken;
    function getSelectedLog: TLogProject;
    procedure setSessionMap(const path : string);
  public
    { Public declarations }
    property selectedFile : TLogFile read getSelectedFile;
    property selectedError : TLogErrorMessage read getSelectedError;
    property selectedClearedToken : TLogMapToken read getSelectedClearedToken;
    property selectedObfuscatedToken : TLogMapToken read getSelectedObfuscatedToken;
    property selectedFlatObfusactedToken : TLogMapToken read getSelectedFlatObfuscatedToken;
    property pathToFileEditor : string read getPathToFileEditor;
    property log : TLogProject read getSelectedLog;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R images\16x16.res}

uses
  darin_string, images, jclsysutils, registry, shellAPI, mapChooser, objects;

const
  RegKey = 'Software\Nebiru Software\JSCruncher Pro\Logviewer';

var
  StateForShow   : integer;
  sessionMapName : string;

//------------------------------------------------------------------------------

procedure TForm1.assignImages;
  procedure I(A:TCustomAction; const N:string);
  begin
    A.ImageIndex := allImages.GetImageIndex(N);
    //AMHelper.syncImageIndexes(A);
  end;
begin
  ActionManager1.Images                := allImages.il16;
  tree.Images                          := allImages.il16;
  tgFiles.ImageList                    := allImages.tsIl16;
  tgErrors.ImageList                   := allImages.tsIl16;
  tgObfuscatedTokens.ImageList         := allImages.tsIl16;
  tgClearedTokens.ImageList            := allImages.tsIl16;
  tgFlatObfuscatedTokens.ImageList     := allImages.tsIl16;
  tgObfuscatedTokensFileList.ImageList := allImages.tsIl16;
  tgManageFiles.ImageList              := allImages.tsIl16;
  tgScriptIncludes.ImageList           := allImages.tsIl16;

  I(loadAction, 'open_document16');
  I(exitAction, 'exit');
end;

//------------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
var
  i     : integer;
  fname : string;
begin
  fLogFiles := TObjectList.Create(true); // true for ownsObjects
  for i := 0 to pagecontrol1.PageCount-1 do
    pagecontrol1.Pages[i].TabVisible := false;

  btnMap.Color            := form1.Color;
  btnMap.BtnSelectedColor := form1.Color;
  btnMap.FontColor        := clblack;

  assignImages();
  PageControl1.ActivePage := nil;
  caption := application.Title;
  OpenDialog1.InitialDir := extractfilepath(application.exename) + 'logs';

  if(ParamCount > 0) then begin
    with TReginifile.create(RegKey) do try
      sessionMapName := readstring( 'FORM', 'sessionMapName', '');
    finally
      free();
    end;

    fname := '';
    for i := 1 to paramCount do
      fname := fname + iff(i=1, '', ' ') + paramStr(i);
    if(fileexists(fname))then
      loadFile(ParamStr(1));
  end;

  for i := 1 to tgFiles.cols do
    tgFiles.Col[i].SortPicture := spNone;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormDestroy(Sender: TObject);
begin
  SaveSettings();
  fLogFiles.Free();
end;

//------------------------------------------------------------------------------

procedure TForm1.exitActionExecute(Sender: TObject);
begin
  close();
end;

//------------------------------------------------------------------------------

procedure TForm1.loadActionExecute(Sender: TObject);
begin
  if(OpenDialog1.execute)then
    loadFile(OpenDialog1.FileName);
end;

//------------------------------------------------------------------------------

procedure TForm1.loadFile(const aFilename: string);
var
  rootNode : TTreeNode;
  n, n2    : TTreenode;
  i        : integer;
  aLog     : TLogProject;
begin
  if(not fileexists(aFilename))then exit;
  PageControl1.ActivePage := nil;
  OpenDialog1.InitialDir  := extractfilepath(aFilename);
  lblStatus.caption       := aFilename;
  //tree.Items.Clear();

  for i := 0 to tree.Items.Count-1 do
    if(tree.Items[i].Text = ExtractFileName(aFilename))then begin  // already opened and in tree
      tree.Selected := tree.Items[i]; // select it
      exit;
    end;

  rootNode := tree.Items.add(nil, extractfilename(aFilename));
  rootNode.ImageIndex    := allImages.GetImageIndex('view_log');
  rootNode.SelectedIndex := allImages.GetImageIndex('view_log');

  aLog := TLogProject.create();
  fLogFiles.Add(aLog);
  rootNode.Data := aLog;

  aLog.load(aFilename);
  if(aLog.filesToCompress.present)then begin
    n                := tree.Items.AddChild(rootNode, 'Compression Job');
    n.ImageIndex     := allImages.GetImageIndex('compress1');
    n.SelectedIndex  := n.ImageIndex;
    n.Data           := aLog.filesToCompress;
    n2               := tree.Items.AddChild(n, 'Files');
    n2.ImageIndex    := allImages.GetImageIndex('folder_closed');
    n2.SelectedIndex := allImages.GetImageIndex('folder_opened');
    n2.Data          := aLog.filesToCompress.flatFileList;

    n2               := tree.Items.AddChild(n, 'Tokens');
    n2.ImageIndex    := allImages.GetImageIndex('folder_closed');
    n2.SelectedIndex := allImages.GetImageIndex('folder_opened');
    n2.Data          := aLog.filesToCompress.flatMapTokenList;
  end;
  if(aLog.filesToManage.present)then begin
    n                := tree.Items.AddChild(rootNode, 'Tag Management Job');
    n.Data           := aLog.filesToManage;
    n.ImageIndex     := allImages.GetImageIndex('small_includes');
    n.SelectedIndex  := n.ImageIndex;
    n2               := tree.Items.AddChild(n, 'Files');
    n2.ImageIndex    := allImages.GetImageIndex('folder_closed');
    n2.SelectedIndex := allImages.GetImageIndex('folder_opened');
    n2.Data          := aLog.filesToManage.flatFileList;
  end;
  rootNode.Expand(true);
  tree.Selected := rootNode;

  if(aLog.settings.SessionMap = nil)then
    addToSessionMapAction.Caption := '<select default session map>'
  else
    addToSessionMapAction.Caption := 'Add to ''' + extractfilename(aLog.settings.SessionMap.filename) + '''...';
  if(fileexists(sessionMapName))then
    setSessionMap(sessionMapName);
end;

//------------------------------------------------------------------------------

function tokenSortMethod(Item1, Item2: Pointer): Integer;
begin
  result := StrIComp(
    pchar(TLogMapToken(item1).key),
    pchar(TLogMapToken(item2).key)
  );
end;

//------------------------------------------------------------------------------

procedure TForm1.treeChange(Sender: TObject; Node: TTreeNode);
var
  fileList     : TLogFilelist;
  mapTokenList : TLogMapTokenList;
begin
  PageControl1.ActivePage := nil;
  if(node.Data = nil) then exit;
  if(TObject(node.data) is TLogFilelist)then begin
    fileList := TLogFilelist(node.data);

    if(node.data = log.filesToCompress.flatFileList)then begin
      PageControl1.ActivePage := tsCompress;
      tgFiles.Rows := filelist.Count;
      tgFiles.RefreshData(roNone, rpNone);
      if(filelist.Count > 0)then
        tgFilesSelectChanged(tgFiles, stRowSelect, true);
    end;

    if(node.data = log.filesToManage.flatFileList)then begin
      pagecontrol1.ActivePage := tsManage;
      tgManageFiles.Rows := filelist.Count;
      tgManageFiles.RefreshData(roNone, rpNone);
      if(filelist.Count > 0)then
        tgManageFilesSelectChanged(tgManageFiles, stRowSelect, true);
    end;

  end;
  if(TObject(node.data) is TLogMapTokenList)then begin
    mapTokenList := TLogMapTokenList(node.data);
    PageControl1.ActivePage := tsTokens;
    mapTokenList.Sort(tokenSortMethod);
    tgFlatObfuscatedTokens.Rows := mapTokenList.Count;
    tgFlatObfuscatedTokens.RefreshData(roNone, rpNone);
    if(mapTokenList.Count > 0)then
      tgFlatObfuscatedTokensSelectChanged(tgFlatObfuscatedTokens, stRowSelect, true);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFilesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
  function formatInt(const int:integer):string;
  begin
    if(int = 0)then result := '-'
    else result := inttostr(int);
  end;
var
  item : TLogFile;
begin
  if(pagecontrol1.ActivePage = tsCompress)then begin
    item := log.filesToCompress.flatFileList.Items[tgFiles.DisplayRownr[dataRow]-1];
    case dataCol of
       1 : case item.fileType of
            ftHTML    : value := 'HTML';
            ftScript  : value := 'SCRIPT2';
            ftUnknown : value := 'BLUEBALL';
          end;
       2 : value := extractfilename(item.inputFilename);
       3 : value := copy(extractfilepath(item.inputFilename), length(item.fileSet.folder)+1, length(item.inputFilename));
       4 : value := FormatFileSize(item.outputSize);
       5 : value := formatInt(item.compression) + iff(item.compression = 0, '', '%');
       6 : value := formatInt(item.ObfuscatedTokens.Count);
       7 : value := formatInt(item.errors.Count);
       8 : value := formatInt(item.scripts);
       9 : value := formatInt(item.comments);
      10 : value := formatInt(item.stringLiterals);
    end;
  end else begin
    item := log.filesToManage.flatFileList.Items[tgManageFiles.DisplayRownr[dataRow]-1];
    case dataCol of
       1 : case item.fileType of
            ftHTML    : value := 'HTML';
            ftScript  : value := 'SCRIPT2';
            ftUnknown : value := 'BLUEBALL';
          end;
       2 : value := extractfilename(item.inputFilename);
       3 : value := copy(extractfilepath(item.inputFilename), length(item.fileSet.folder)+1, length(item.inputFilename));
       4 : value := FormatFileSize(item.inputSize);
       5 : value := formatInt(item.scriptIncludes.count);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFilesHeadingClick(Sender: TObject; DataCol: Integer);
var
  sortOn  : TLogSortType;
  sortDir : TSortDir;
  i       : integer;
begin
  sortOn  := stFileType;
  sortDir := sdAsc;
  case dataCol of
     1 : sortOn := stFileType;
     2 : sortOn := stFilename;
     3 : sortOn := stFilepath;
     4 : sortOn := stOutputSize;
     5 : sortOn := stCompression;
     6 : sortOn := stTokens;
     7 : sortOn := stErrors;
     8 : sortOn := stScripts;
     9 : sortOn := stComments;
    10 : sortOn := stStrings;
  end;

  for i := 1 to TtsGrid(Sender).cols do
    if(i <> datacol)then TtsGrid(Sender).col[i].SortPicture := spNone;

  case(TtsGrid(Sender).Col[DataCol].SortPicture)of
     spNone : begin TtsGrid(Sender).Col[DataCol].SortPicture := spUp;   sortDir := sdAsc;  end;
     spDown : begin TtsGrid(Sender).Col[DataCol].SortPicture := spUp;   sortDir := sdAsc;  end;
     spUp   : begin TtsGrid(Sender).Col[DataCol].SortPicture := spDown; sortDir := sdDesc; end;
  end;

  if(sender = tgFiles)then
    log.filesToCompress.flatFileList.sortOn(sortOn, sortDir);
  if(sender = tgObfuscatedTokensFileList)then
    selectedFlatObfusactedToken.files.sortOn(sortOn, sortDir);
  if(sender = tgManageFiles)then begin
    if(datacol = 5)then sortOn := stScriptTags;
    log.filesToManage.flatFileList.sortOn(sortOn, sortDir);
  end;
    
  TtsGrid(Sender).RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.Panel5Resize(Sender: TObject);
begin
  Panel6.width := panel5.width div 2;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedFile: TLogFile;
var
  i : integer;
begin
  if(pagecontrol1.ActivePage = tsCompress)then begin
    i := tgFiles.SelectedRows.First-1;
    if(i >= 0)then
      result := log.filesToCompress.flatFileList.Items[i]
    else result := nil;
  end else if(PageControl1.ActivePage = tsManage) then begin
     i := tgManageFiles.SelectedRows.First-1;
    if(i >= 0)then
      result := log.filesToManage.flatFileList.Items[i]
    else result := nil;
  end else result := nil;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedClearedToken: TLogMapToken;
var
  i : integer;
begin
  i := tgClearedTokens.selectedRows.first-1;
  if(i >= 0) then
    result := selectedFile.CleanTokens.Items[i]
  else
    result := nil;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedError: TLogErrorMessage;
begin
  result := selectedFile.errors.Items[tgErrors.selectedRows.first-1];
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedObfuscatedToken: TLogMapToken;
var
  i : integer;
begin
  i := tgObfuscatedTokens.selectedRows.first-1;
  if(i >= 0)then
    result := selectedFile.ObfuscatedTokens.Items[i]
  else result := nil;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedFlatObfuscatedToken: TLogMapToken;
var
  i : integer;
begin
  i := tgFlatObfuscatedTokens.selectedRows.first-1;
  if(i >= 0)then
    result := log.filesToCompress.flatMapTokenList.Items[i]
  else result := nil;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
begin
  tgErrors.Rows := selectedFile.errors.Count;
  tgObfuscatedTokens.Rows := selectedFile.ObfuscatedTokens.Count;
  tgClearedTokens   .Rows := selectedFile.CleanTokens     .Count;

  tgErrors          .RefreshData(roNone, rpNone);
  tgObfuscatedTokens.RefreshData(roNone, rpNone);
  tgClearedTokens   .RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgErrorsCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
begin
  case dataCol of
    1: value := 'ERROR';
    2: value := inttostr(selectedFile.errors[dataRow-1].linenum);
    3: value := selectedFile.errors[dataRow-1].line;
    4: value := selectedFile.errors[dataRow-1].msg;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
begin
  case dataCol of
    1: value := 'TOKEN';
    2: value := selectedFile.ObfuscatedTokens[dataRow-1].key;
    3: value := selectedFile.ObfuscatedTokens[dataRow-1].value;
    4: value := inttostr(selectedFile.ObfuscatedTokens[dataRow-1].occurances);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgClearedTokensCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
begin
  case dataCol of
    1: value := 'TOKEN';
    2: value := selectedFile.CleanTokens[dataRow-1].key;
    3: value := selectedFile.CleanTokens[dataRow-1].map;
    4: value := inttostr(selectedFile.CleanTokens[dataRow-1].occurances);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.loadSettings;
begin
  with TReginifile.create(RegKey) do try
    width          := readinteger('FORM', 'Width',          668);
    height         := readinteger('FORM', 'Height',         528);
    top            := readinteger('FORM', 'Top',            screen.height div 2-height div 2);
    left           := readinteger('FORM', 'Left',           screen.width  div 2-width  div 2);
    StateForShow   := readinteger('FORM', 'WindowState',    ord(wsNormal));
  finally
    free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.saveSettings;
begin
  with TReginifile.create(RegKey) do try
    if windowstate = wsNormal then begin
      writeinteger('FORM', 'Top',    top);
      writeinteger('FORM', 'Left',   left);
      writeinteger('FORM', 'Width',  width);
      writeinteger('FORM', 'Height', height);
    end;
    writeinteger( 'FORM', 'WindowState',    ord(WindowState));
    writestring(  'FORM', 'sessionMapName', sessionMapName);
  finally
    free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormShow(Sender: TObject);
begin
  LoadSettings();
  WindowState := TWindowState(StateForShow);
//  FormResize(self);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgClearedTokensGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
var
  map : string;
begin
  if(datacol = 3)then begin
    map := selectedFile.CleanTokens[dataRow-1].map;
    if(lowercase(ExtractFileExt(map)) = '.map')then begin
      DrawInfo.Font.Color := clHotLight;
      drawInfo.Font.Style := [fsUnderline];
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgClearedTokensDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  if(datacol = 3) and (datarow > 0) and (datacol < selectedFile.CleanTokens.Count)then begin
    openMapfileAction.enabled := true; openMapfileAction.Execute();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgErrorsDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  locateErrorAction.enabled := true; locateErrorAction.Execute();
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFilesDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  openFileAction.enabled := true; openFileAction.Execute();
end;

//------------------------------------------------------------------------------

procedure TForm1.openFileActionExecute(Sender: TObject);
var
  aFilename,
  aParams : string;
begin
  if(pagecontrol1.ActivePage = tsCompress)then
    aFilename := selectedFile.inputFilename;
  if(pagecontrol1.ActivePage = tsTokens)then
    aFilename := selectedFlatObfusactedToken.files[tgObfuscatedTokensFileList.SelectedRows.first-1].inputFilename;
  if(pagecontrol1.ActivePage = tsManage)then
    aFilename := selectedFile.inputFilename;

  aParams     := aFilename;
  if(fileexists(aFilename))then
    ShellExecute(handle,'open',pchar(pathToFileEditor),pchar(aParams),'',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.locateErrorActionExecute(Sender: TObject);
var
  aFilename,
  aParams : string;
  aLinenumber : integer;
begin
  aFilename   := selectedFile.inputFilename;

  aLinenumber := 1;
  if(pagecontrol1.ActivePage = tsCompress)then
    aLinenumber := selectedError.linenum
  else if(PageControl1.ActivePage = tsManage)then
    aLinenumber := selectedFile.scriptIncludes[tgScriptIncludes.SelectedRows.First - 1].lineNumber;

  aParams := aFilename + ' ' + inttostr(aLinenumber);
  if(fileexists(aFilename))then
    ShellExecute(handle,'open',pchar(pathToFileEditor),pchar(aParams),'',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.openMapfileActionExecute(Sender: TObject);
var
  map : string;
begin
  map := log.settings.mapFolder + selectedClearedToken.map;
  if(fileexists(map))then
    ShellExecute(handle,'open',pchar(map),'','',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.filesPopupPopup(Sender: TObject);
begin
  openFileAction.Enabled        := (selectedFile <> nil) and (fileexists(selectedFile.inputFilename));
  openMapfileAction.Enabled     := (selectedFile <> nil) and (selectedClearedToken    <> nil);

  if(pagecontrol1.ActivePage = tsCompress)then begin
    openFileAction       .Enabled := (selectedFile <> nil) and (fileexists(selectedFile.inputFilename));
    locateErrorAction    .Enabled := (selectedFile <> nil) and (selectedError <> nil);
    addToSessionMapAction.Enabled := (selectedFile <> nil) and
                                     (selectedObfuscatedToken <> nil);
  end;

  if(pagecontrol1.ActivePage = tsTokens)then begin
    openFileAction.Enabled := (selectedFlatObfusactedToken <> nil) and
                              (tgObfuscatedTokensFileList.SelectedRows.first > 0) and
                              (fileexists(selectedFlatObfusactedToken.files[tgObfuscatedTokensFileList.SelectedRows.first-1].inputFilename));
    addToSessionMapAction.Enabled := (selectedFlatObfusactedToken <> nil);
  end;

  if(PageControl1.ActivePage = tsManage)then begin
    locateErrorAction.Enabled := (selectedFile <> nil) and
                                 (tgScriptIncludes.SelectedRows.First > 0);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.addToSessionMapActionExecute(Sender: TObject);
var
  i,
  insertionPoint : integer;
  newToken       : TJSCPMapToken;
  selectedToken  : TLogMapToken;
begin
  if(log.settings.SessionMap = nil)then begin
    // have user select session map, change action caption to reflect this
    mapChooserDlg := TmapChooserDlg.create(self);
    try
      mapChooserDlg.mapPath := log.settings.mapFolder;
      mapChooserDlg.showModal();
      if(mapChooserDlg.ModalResult = mrOK)then begin
        log.settings.mapFolder := mapChooserDlg.mapPath;
        log.settings.maps.LoadFromDisk();
        i := log.settings.maps.findMapByName(mapChooserDlg.StShellListView1.selectedItem.displayName);
        if(i <> -1)then
          setSessionMap(mapChooserDlg.StShellListView1.selectedItem.Path);
      end;
    finally
      mapChooserDlg.free();
    end;
  end else begin
    // add token to session map
    selectedToken := nil;
    if(PageControl1.ActivePage = tsManage) or (pageControl1.activepage = tsCompress) then
      selectedToken := selectedObfuscatedToken;

    if(PageControl1.ActivePage = tsTokens)then
      selectedToken := selectedFlatObfusactedToken;
    if(selectedToken = nil) or
      (log.settings.SessionMap.items.indexOf(selectedToken.key, insertionPoint) <> -1)then exit;


    newToken       := TJSCPMapToken.Create();
    newToken.key   := selectedToken.key;
    newToken.value := selectedToken.key; // value is the same as the key
    log.settings.SessionMap.items.Insert(insertionPoint, newToken);
    log.settings.SessionMap.save();

    if(PageControl1.ActivePage = tsCompress) or 
      (PageControl1.ActivePage = tsManage)then begin
      //selectedFile.ObfuscatedTokens.Delete(tgObfuscatedTokens.selectedRows.first-1);
      tgObfuscatedTokens.Rows := selectedFile.ObfuscatedTokens.Count;
      tgObfuscatedTokens.RefreshData(roNone, rpNone);
    end;

  end;
end;

//------------------------------------------------------------------------------

function TForm1.getPathToFileEditor: string;
begin
  result := extractfilepath(application.ExeName) + 'editor.exe';
end;

//------------------------------------------------------------------------------

procedure TForm1.tsTokensResize(Sender: TObject);
begin
//  Panel9.height := tsTokens.height div 2;
  panel9.Align := alClient;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFlatObfuscatedTokensCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  item : TLogMapToken;
begin
  item := log.filesToCompress.flatMapTokenList.Items[tgFlatObfuscatedTokens.DisplayRownr[dataRow]-1];
  case dataCol of
    1: value := 'TOKEN';
    2: value := item.key;
    3: value := item.value;
    4: value := inttostr(item.occurances);
    5: value := inttostr(item.files.count);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgFlatObfuscatedTokensSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  item : TLogMapToken;
begin
  item := selectedFlatObfusactedToken;
  if(item = nil) then exit;
  tgObfuscatedTokensFileList.Rows := item.files.Count;
  tgObfuscatedTokensFileList.RefreshData(roNone,rpNone);
  selectedFlatObfusactedToken.files.sortOn(
    selectedFlatObfusactedToken.files.SortFilesOn,
    selectedFlatObfusactedToken.files.SortDir
  );
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensFileListCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  item : TLogFile;
begin
  item := selectedFlatObfusactedToken.files[dataRow-1];
  case dataCol of
     1 : case item.fileType of
          ftHTML    : value := 'HTML';
          ftScript  : value := 'SCRIPT2';
          ftUnknown : value := 'BLUEBALL';
        end;
     2 : value := extractfilename(item.inputFilename);
     3 : value := copy(extractfilepath(item.inputFilename), length(item.fileSet.folder)+1, length(item.inputFilename));
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgManageFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
begin
  tgScriptIncludes.Rows := selectedFile.scriptIncludes.Count;
  tgScriptIncludes.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgScriptIncludesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  item : TLogScriptTag;
begin
  item := selectedFile.scriptIncludes[datarow - 1];
  case dataCol of
    1 : value := 'SCRIPT2';
    2 : value := inttostr(item.lineNumber);
    3 : value := tagTypeToString(item.tagType);
    4 : value := item.filename;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgScriptIncludesDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
begin
  locateErrorAction.enabled := true; locateErrorAction.Execute();
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
var
  key        : string;
  i          : integer;
  tokenNode,
  parentNode : TTreeNode;
begin
  tokenNode  := nil;
  parentNode := tree.Selected.Parent;
  for i := 0 to parentNode.Count-1 do
    if(parentNode.Item[i].Data = log.filesToCompress.flatMapTokenList)then begin
      tokenNode := parentNode.item[i];
      break;
    end;
  if(tokenNode = nil)then exit;

  key := selectedFile.ObfuscatedTokens[dataRow-1].key;
  i   := log.filesToCompress.flatMapTokenList.IndexOf(key);

  if(i > -1)then begin
    tree.Select(tokenNode);
    tgFlatObfuscatedTokens.SelectRows(i+1, i+1, true);
    tgFlatObfuscatedTokens.TopRow := i - 10;
  end;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedLog: TLogProject;
var
  n : TTreenode;
begin
  result := nil;
  n := tree.Selected;
  while(n <> nil)do begin
    if(TObject(n.Data) is TLogProject)then begin
      result := TLogProject(n.data);
      exit;
    end;
    n := n.Parent;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensGetDrawInfo(Sender: TObject; DataCol,
  DataRow: Integer; var DrawInfo: TtsDrawInfo);
var
  value : string;
  i     : integer;
begin
  drawinfo.font.Color := clblack;
  if(log.settings.SessionMap = nil)then exit;
  if(dataCol = 2)then begin
    value := selectedFile.ObfuscatedTokens[dataRow-1].key;
    if(log.settings.SessionMap.items.indexOf(value, i) > -1) then
      drawinfo.font.Color := clsilver
    else
      drawinfo.font.Color := clblack;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.setSessionMap(const path: string);
var
  i : integer;
begin
  sessionMapName := path;
  log.settings.mapFolder := extractfilepath(path);
  log.settings.maps.LoadFromDisk();
  i := log.settings.maps.findMapByName(extractfilename(path));
  if(i <> -1)then begin
    log.settings.SessionMap := log.settings.maps[i];
    addToSessionMapAction.Caption := 'Add to ''' + extractfilename(log.settings.SessionMap.filename) + '''...';
  end;
end;

//------------------------------------------------------------------------------

end.
