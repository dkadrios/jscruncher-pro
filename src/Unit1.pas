unit Unit1;

interface

uses
  Windows, Messages, SysUtils, forms,ShellCtrls, StdCtrls, ComCtrls, StShlCtl,
  SynEdit, ExtCtrls, Controls, MouseoverPanel, SynHighlighterHtml,
  SynEditHighlighter, SynHighlighterJScript, ActnMan, ActnColorMaps, XPMan,
  ActnList, Classes, StdActns, XPStyleActnCtrls, Menus, ImgList, Dialogs,
  ActnCtrls, ActnMenus, ToolWin, Graphics, Grids_ts, TSGrid,
  objects, mxTaskPaneItems, mxNavigationBar,
  mxCustomControl, mxOutlookPanel,
  PDJ_XPCS, PDJ_XPB, PDJ_XPC, TSImageList,  mxXPButton,
  OleCtrls, SHDocVw, WebBrowserWithUI,  AMHelper, ActnPopupCtrl,
  PDJ_XPPB, xmldom, XMLIntf, msxmldom, XMLDoc, XSLProd, IdAntiFreezeBase,
  IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, PDJ_XPSpB,
  settings, FileCtrl, StdStyleActnCtrls, PDJ_XPEB;

 const
   homePane           = 0;
   filesPane          = 1;
   textPane           = 2;
   tagsPane           = 3;

   lvFilesImage       = 1;
   lvFilesExtImage    = 2;
   lvFilesCaption     = 3;
   lvFilesSize        = 4;
   lvFilesAttributes  = 5;
   lvFilesModified    = 6;
   lvFilesCompressed  = 7;
   lvFilesCompression = 8;
   lvFilesScripts     = 9;

   lvTagsImage        = 1;
   lvTagsExtImage     = 2;
   lvTagsCaption      = 3;
   lvTagsNormal       = 4;
   lvTagsCompressed   = 5;
   lvTagsSize         = 6;
   lvTagsAttributes   = 7;
   lvTagsModified     = 8;
   lvTagsScripts      = 9;

type
  TSoundType = (stError, stOK, stSuccess, stCancel, stContext, stDrop);

  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    ActionManager1: TActionManager;
    FileExitAction: TFileExit;
    selectFlaggedFilesAction: TAction;
    invertSelectionAction: TAction;
    CompressSelectedFilesAction: TAction;
    UseCompressedScriptsAction: TAction;
    UseNormalScriptsAction: TAction;
    RefreshAction: TAction;
    AboutAction: TAction;
    viewBottombarAction: TAction;
    CoolBar1: TCoolBar;
    ActionMainMenuBar1: TActionMainMenuBar;
    compressPlainTextAction: TAction;
    jscruncherHomeAction: TAction;
    domapiHomeAction: TAction;
    validateFilesAction: TAction;
    SynJScriptSyn1: TSynJScriptSyn;
    SynHTMLSyn1: TSynHTMLSyn;
    settingsAction: TAction;
    browseLogsAction: TAction;
    mainToolbar: TActionToolBar;
    imgTop: TImage;
    imgBottom: TImage;
    Panel6: TPanel;
    bottomSplitter: TSplitter;
    bottomBar: TPanel;
    MouseoverPanel2: TMouseoverPanel;
    imgBottomBar: TImage;
    TagTree: TStShellTreeView;
    FileTree: TStShellTreeView;
    exportLogAction: TAction;
    neverReplaceAction: TAction;
    mapSaveDialog: TSaveDialog;
    activateAction: TAction;
    helpIndexAction: TAction;
    toggleReadonlyAction: TAction;
    usingConsoleAction: TAction;
    UDLogAddAction: TAction;
    UDLogDeleteAction: TAction;
    Bevel4: TBevel;
    compressionSettingsAction1: TAction;
    navPane: TmxNavigationBarPro;
    Splitter1: TSplitter;
    pgHome: TmxNavigationBarPage;
    pgFiles: TmxNavigationBarPage;
    pgText: TmxNavigationBarPage;
    pgTags: TmxNavigationBarPage;
    mxNavBarCaption1: TmxNavBarCaption;
    mxNavBarCaption2: TmxNavBarCaption;
    mxNavBarCaption3: TmxNavBarCaption;
    mxNavBarCaption4: TmxNavBarCaption;
    pgBottom: TPageControl;
    tsFileViewer: TTabSheet;
    tsScriptIncludes: TTabSheet;
    tsMessages: TTabSheet;
    tsObfuscationLog: TTabSheet;
    tsUDMap: TTabSheet;
    viewOriginalPanel: TPanel;
    viewCompressedPanel: TPanel;
    tagsInsideListView: TListView;
    XPColorMap1: TXPColorMap;
    tsImageList1: TtsImageList;
    loadProjectAction: TAction;
    mxNavBarCaption5: TmxNavBarCaption;
    mxContainer1: TmxContainer;
    mxTPButton1: TmxTPButton;
    mxNavBarCaption8: TmxNavBarCaption;
    createProjectAction: TAction;
    mxTPButton2: TmxTPButton;
    compressFilesAction: TAction;
    compressTextAction: TAction;
    manageTagsAction: TAction;
    mxContainer2: TmxContainer;
    mxTPButton3: TmxTPButton;
    mxTPButton4: TmxTPButton;
    mxTPButton5: TmxTPButton;
    Label3: TLabel;
    mxTPButton6: TmxTPButton;
    openProjectDialog: TOpenDialog;
    saveProjectDialog: TSaveDialog;
    runProjectAction: TAction;
    mxTPButton7: TmxTPButton;
    editProjectAction: TAction;
    saveAsProjectAction: TAction;
    mxTPButton8: TmxTPButton;
    mxTPButton9: TmxTPButton;
    AMHelper: TActionManagerHelper;
    plainTextPopupMenu: TPopupActionBarEx;
    Compress2: TMenuItem;
    messagesPopupMenu: TPopupActionBarEx;
    Open2: TMenuItem;
    Clearallmessages2: TMenuItem;
    filesPopupMenu: TPopupActionBarEx;
    Selecttaggedfiles1: TMenuItem;
    Invertselection1: TMenuItem;
    N3: TMenuItem;
    Compressfiles1: TMenuItem;
    Validateselectedfiles2: TMenuItem;
    Altertousecompressedscripts1: TMenuItem;
    Altertousenormalscripts1: TMenuItem;
    ogglereadonlystatus2: TMenuItem;
    N5: TMenuItem;
    OpenFile1: TMenuItem;
    mapLogPopupMenu: TPopupActionBarEx;
    Neverreplace1: TMenuItem;
    Exportobfuscationlog1: TMenuItem;
    N1: TMenuItem;
    mxOutlookPanel3: TmxOutlookPanel;
    lblStatus: TLabel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    ProgressBar1: TPDJXPProgressBar;
    imageTag: TImage;
    lblHint: TLabel;
    Bevel7: TBevel;
    XSLPageProducer1: TXSLPageProducer;
    XMLDocument1: TXMLDocument;
    checkForUpdateAction: TAction;
    IdHTTP1: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    Panel4: TPanel;
    Shape6: TShape;
    Shape7: TShape;
    nb1: TNotebook;
    Shape4: TShape;
    showWelcomePanel: TPanel;
    cbShowWelcomeScreen: TPDJXPCheckBox;
    wbAnimate: TAnimate;
    wb: TWebBrowserWithUI;
    lvTags: TtsGrid;
    mxOutlookPanel4: TmxOutlookPanel;
    lblTagTotalFiles: TLabel;
    lblTagSize: TLabel;
    lblTagNorm: TLabel;
    lblTagComp: TLabel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Shape2: TShape;
    Panel5: TPanel;
    Label2: TLabel;
    ActionToolBar3: TActionToolBar;
    FileSubDirs: TPDJXPCheckBox;
    cbFilesFilter: TPDJXPComboBox;
    lvFiles: TtsGrid;
    mxOutlookPanel2: TmxOutlookPanel;
    lblTotalFiles: TLabel;
    lblTotalSize: TLabel;
    lblTotalCompSize: TLabel;
    lblAvgRatio: TLabel;
    Bevel2: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel1: TBevel;
    Panel8: TPanel;
    Label1: TLabel;
    TagSubDirs: TPDJXPCheckBox;
    ActionToolBar5: TActionToolBar;
    cbTagsFilter: TPDJXPComboBox;
    btnMap: TXPColorMap;
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
    Shape27: TShape;
    Shape28: TShape;
    Panel1: TPanel;
    pnlErrorMessages: TPanel;
    pnlErrorsFound: TmxOutlookPanel;
    Label5: TLabel;
    Image1: TImage;
    tgMessages: TtsGrid;
    Panel3: TPanel;
    ActionToolBar6: TActionToolBar;
    Shape1: TShape;
    Shape3: TShape;
    Panel7: TPanel;
    ActionToolBar1: TActionToolBar;
    Shape26: TShape;
    tgUDMap: TtsGrid;
    Shape11: TShape;
    Shape29: TShape;
    Panel9: TPanel;
    Bevel17: TBevel;
    pnlFileViewer: TPanel;
    btnFileViewer: TPDJXPSpeedButton;
    pnlScriptIncludes: TPanel;
    btnScriptIncludes: TPDJXPSpeedButton;
    pnlMessages: TPanel;
    btnMessages: TPDJXPSpeedButton;
    pnlObfuscationLog2: TPanel;
    btnObfuscationLog: TPDJXPSpeedButton;
    pnlUserDefinedMapfile: TPanel;
    btnUserDefinedMapfile: TPDJXPSpeedButton;
    Panel10: TPanel;
    label8: TmxNavBarCaption;
    RichEdit1: TSynEdit;
    Shape9: TShape;
    Panel11: TPanel;
    mxNavBarCaption7: TmxNavBarCaption;
    RichEdit2: TSynEdit;
    Shape10: TShape;
    Shape32: TShape;
    Shape30: TShape;
    Bevel3: TBevel;
    Panel12: TPanel;
    Panel13: TPanel;
    Shape8: TShape;
    Shape31: TShape;
    Shape5: TShape;
    Shape33: TShape;
    Panel14: TPanel;
    ActionToolBar4: TActionToolBar;
    PlainTextInCaption: TmxNavBarCaption;
    PlainTextIn: TSynEdit;
    Panel15: TPanel;
    PlainTextOut: TRichEdit;
    Shape34: TShape;
    mxNavBarCaption6: TmxNavBarCaption;
    textViewLogButton: TPDJXPButton;
    edtFilesOutput: TPDJXPEditBtn;
    Label6: TLabel;
    Label7: TLabel;
    edtTagsOutput: TPDJXPEditBtn;
    edtTagsInput: TPDJXPEditBtn;
    Label9: TLabel;
    Shape35: TShape;
    Shape36: TShape;
    Label10: TLabel;
    edtFilesInput: TPDJXPEditBtn;
    btnLaunchInputFile: TPDJXPButton;
    btnLaunchOutputFile: TPDJXPButton;
    homeAction: TAction;
    ReopenActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    mxRecentItemsContainer: TmxContainer;
    mxContainer3: TmxContainer;
    Image3: TImage;
    mxNavBarCaption9: TmxNavBarCaption;
    projectToolbar: TActionToolBar;
    viewLogAction: TAction;
    mxTPButton10: TmxTPButton;
    mxTPButton11: TmxTPButton;
    MRUTimer: TTimer;
    XPManifest1: TXPManifest;
    Timer2: TTimer;
    Panel2: TPanel;
    tgLog: TtsGrid;
    pnlObfuscationLog: TPanel;
    mxOutlookPanel1: TmxOutlookPanel;
    Label4: TLabel;
    Image2: TImage;
    Panel16: TPanel;
    Panel17: TPanel;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    Panel18: TPanel;
    mxNavBarCaption10: TmxNavBarCaption;
    tgObfuscatedTokensFileList: TtsGrid;
    openLogViewerAction: TAction;
    viewOrphansAction: TAction;
    udmPopup: TPopupActionBarEx;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbFilesFilterChange(Sender: TObject);
    procedure cbTagsFilterChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure selectFlaggedFilesActionExecute(Sender: TObject);
    procedure invertSelectionActionExecute(Sender: TObject);
    procedure CompressSelectedFilesActionExecute(Sender: TObject);
    procedure UseCompressedScriptsActionExecute(Sender: TObject);
    procedure UseNormalScriptsActionExecute(Sender: TObject);
    procedure FileExitActionHint(var HintStr: String; var CanShow: Boolean);
    procedure RefreshActionExecute(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
    procedure TagSubDirsClick(Sender: TObject);
    procedure OpenFile1Click(Sender: TObject);
    procedure filesPopupMenu2Popup(Sender: TObject);
    procedure lvFilesDblClick(Sender: TObject);
    procedure FileSubDirsClick(Sender: TObject);
    procedure viewBottombarActionExecute(Sender: TObject);
    procedure FileTreeFolderSelected(Sender: TObject;Folder: TStShellFolder);
    procedure compressPlainTextActionExecute(Sender: TObject);
    procedure TagTreeFolderSelected(Sender: TObject;Folder: TStShellFolder);
    procedure validateFilesActionExecute(Sender: TObject);
    procedure lvMessagesDblClick(Sender: TObject);
    procedure pgBottomResize(Sender: TObject);
    procedure Clearallmessages1Click(Sender: TObject);
    procedure imgBottomBarClick(Sender: TObject);
    procedure bottomSplitterMoved(Sender: TObject);
    procedure browseLogsActionExecute(Sender: TObject);
    procedure settingsActionExecute(Sender: TObject);
    procedure tsTextResize(Sender: TObject);
    procedure jscruncherHomeActionExecute(Sender: TObject);
    procedure exportLogActionExecute(Sender: TObject);
    procedure neverReplaceActionExecute(Sender: TObject);
    procedure activateActionExecute(Sender: TObject);
    procedure helpIndexActionExecute(Sender: TObject);
    procedure toggleReadonlyActionExecute(Sender: TObject);
    procedure usingConsoleActionExecute(Sender: TObject);
    procedure tgUDMapCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure UDLogAddActionExecute(Sender: TObject);
    procedure UDLogDeleteActionExecute(Sender: TObject);
    procedure tgUDMapCellEdit(Sender: TObject; DataCol, DataRow: Integer; ByUser: Boolean);
    procedure compressionSettingsAction1Execute(Sender: TObject);
    procedure tgLogCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgMessagesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure navPaneChange(Sender: TObject);
    procedure lvTagsCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure lvFilesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure lvTagsColResized(Sender: TObject; RowColnr: Integer);
    procedure lvFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
    procedure lvTagsSelectChanged(Sender: TObject;  SelectType: TtsSelectType; ByUser: Boolean);
    procedure compressFilesActionExecute(Sender: TObject);
    procedure wbBeforeNavigate2(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
    procedure createProjectActionExecute(Sender: TObject);
    procedure loadProjectActionExecute(Sender: TObject);
    procedure runProjectActionExecute(Sender: TObject);
    procedure saveAsProjectActionExecute(Sender: TObject);
    procedure tagsInsideListViewResize(Sender: TObject);
    procedure lvFilesGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
    procedure lvFilesRowCountChanged(Sender: TObject; OldCount, NewCount: Integer);
    procedure lvTagsRowCountChanged(Sender: TObject; OldCount, NewCount: Integer);
    procedure cbShowWelcomeScreenClick(Sender: TObject);
    procedure checkForUpdateActionExecute(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure wbDocumentComplete(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure wbNavigateComplete2(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure wbProgressChange(Sender: TObject; Progress, ProgressMax: Integer);
    procedure btnFileViewerClick(Sender: TObject);
    procedure pgBottomChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtFilesOutputChange(Sender: TObject);
    procedure edtTagOutputEButtons0Click(Sender: TObject);
    procedure edtTagsOutputEButtons1Click(Sender: TObject);
    procedure btnLaunchInputFileClick(Sender: TObject);
    procedure homeActionExecute(Sender: TObject);
    procedure ReopenActionExecute(Sender: TObject);
    procedure viewLogActionExecute(Sender: TObject);
    procedure MRUTimerTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure tgLogSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
    procedure tgObfuscatedTokensFileListCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
    procedure tgObfuscatedTokensFileListDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
    procedure tgLogHeadingClick(Sender: TObject; DataCol: Integer);
    procedure openLogViewerActionExecute(Sender: TObject);
    procedure viewOrphansActionExecute(Sender: TObject);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    ReopenMenuItem: TActionClientItem;
    threadShouldCancel : boolean;
    procedure addToRecentMenu(const aFilename:string);
    procedure loadProject(const aFilename:string);
    procedure FindReopenMenuItem(AClient: TActionClient);
    procedure UpdateReopenItem(ReopenItem: TActionClientItem);
    procedure refreshMRU(ReopenItem: TActionClientItem);
    procedure CrunchFiles;
    procedure ManageTags(  const useCompressed:boolean);
    procedure showLogTab;
    procedure syncUpActionsToGUI;
    procedure addToUserDefinedMap(const aValue: string);
    procedure UDOnRowCountChanged(sender:Tobject);
    procedure SMOnRowCountChanged(sender:Tobject);
    procedure editEnvironmentSettings;
    function  editSessionSettings(const captionStr:string):boolean;
    function  getSelectedTab:integer;
    procedure setSelectedTab(const Value: integer);
    procedure assignImages;
    procedure updateFilesPaneStatusBar;
    procedure updateTagsPaneStatusBar;
    procedure displayProjectContents;
    procedure displayStartPage;
    procedure ThreadDone(Sender: TObject);
    procedure colorToolbars;
    function  getGuiFileSet: TJSCPFileSet;
    function  getPathToLogViewer : string;
    function  getPathToFileEditor : string;
    function  getSessionSettingsFilename : string;
    function  getManageFileFilter: string;
    procedure setManageFileFilter(aValue : string);
    function  getCompressFileFilter: string;
    procedure setCompressFileFilter(aValue : string);
    function  getCurrentFile : TJSCPFile;
    function  getLogFilename : string;
    function  getSelectedSessionToken : TJSCPMapToken;
    procedure ShowSearchDialog(const aEditor:TSynEdit);
    procedure DoSearchText(const aEditor:TSynEdit; aBackwards:boolean);
    //-----
    procedure onProgress(Sender: TObject;const count, total:integer);
    procedure onStatus(Sender: TObject;const aStatus:string);
    procedure onError(Sender: TObject;const filenm, msg, context:string;const line:integer);
    procedure onProjectLoaded(sender:tobject);
    procedure onProjectCleared(sender:tobject);
  public
    { Public declarations }
    project,
    sessionProject : TJSCPProject;
    formSettings   : TFormSettings;
    procedure launchURL(const u:string);
    property  selectedTab:integer read getSelectedTab write setSelectedTab;
    property  guiFileSet : TJSCPFileSet read getGuiFileSet;
    property  currentFile : TJSCPFile read getCurrentFile;
    property  pathToLogViewer: string read getPathToLogViewer;
    property  pathToFileEditor:string read getPathToFileEditor;
    property  sessionSettingsFilename:string read getSessionSettingsFilename;
    property  manageFileFilter : string read getManageFileFilter write setManageFileFilter;
    property  compressFileFilter : string read getCompressFileFilter write setCompressFileFilter;
    property  logFilename : string read getLogFilename;
    property  selectedSessionToken : TJSCPMapToken read getSelectedSessionToken;
  end;

function  formatVersionNumber:string;
procedure playsound(const soundType : TSoundType;const async:boolean = true);

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R images\16x16.res}
{$R images\avis.res}

uses
  registry, dirscan, darin_string, darin_file, jclsysutils,
  about, jclstrings, RegExpr, environmentSettings, ShellAPI,
  help, confirmation, jclfileutils, strutils,
  editProject, backgroundTask, images, TransformStartPage,
  protection,
  DNA_INT, Math, orphanedTokens, MMSystem, dlgSearchText;

const
  //pathToWebsite = 'http://darin/bmc/wwwroot/jscruncherpro/';
  pathToWebsite = 'http://domapi.com/jscruncherpro/';

var
  canceled,
  oneshot,
  MaximizeOneShot : boolean;

  gbSearchBackwards,
  gbSearchCaseSensitive,
  gbSearchFromCaret,
  gbSearchSelectionOnly,
  gbSearchTextAtCaret,
  gbSearchWholeWords,
  fSearchFromCaret     : boolean;

  gsSearchText,
  gsSearchTextHistory,
  gsReplaceText        : string;

//------------------------------------------------------------------------------

function EnvelopeCheck: Boolean;
{$I Include\DelphiEnvelopeCheckFunc.inc}

//------------------------------------------------------------------------------

function formatVersionNumber:string;
var
  list : tstrings;
begin
  list := TStringList.create();
  try
    StrToStrings(GetVersionNumber(application.ExeName), '.', list, false);
    result := 'v' + list[0] + '.' + list[1] + ' build ' + list[3];
  finally
    list.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.UDOnRowCountChanged(sender:Tobject);
begin
  tgUDMap.Rows := sessionProject.settings.UDMap.items.Count;
  tgUDMap.RefreshData(roNone, rpNone);
  application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TForm1.SMOnRowCountChanged(sender:Tobject);
begin
  tgLog.rows := sessionProject.settings.SessionMap.items.count;
  tgLog.RefreshData(roNone, rpNone);
  application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TForm1.FindReopenMenuItem(AClient: TActionClient);
begin
  // Find the Reopen item by looking at the item caption
  if AClient is TActionClientItem then
    if Pos('Re&cent...', TActionClientItem(AClient).Caption) <> 0 then
      ReopenMenuItem := AClient as TActionClientItem
end;

//------------------------------------------------------------------------------

procedure TForm1.UpdateReopenItem(ReopenItem: TActionClientItem);
var
  I : Integer;
begin
  if ReopenItem = nil then exit;
  // Add the new filename to the beginning of the list and move other items down
  for I := ReopenActionList1.ActionCount - 1 downto 0 do
    if I = 0 then
      TCustomAction(ReopenActionList1.Actions[I]).Caption := openProjectDialog.FileName
    else
      TCustomAction(ReopenActionList1.Actions[I]).Caption := TCustomAction(ReopenActionList1.Actions[I - 1]).Caption;
  // Add new items to the reopen item if necessary
  if ReopenItem.Items.Count < ReopenActionList1.ActionCount then
    ReopenItem.Items.Add;

  refreshMRU(ReopenItem);
end;

//------------------------------------------------------------------------------

procedure TForm1.refreshMRU(ReopenItem: TActionClientItem);
begin
  MRUTimer.enabled := true;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);

  procedure SetupItemCaptions(AnItem: TActionClientItem);
  var
    I: Integer;
  begin
    if Assigned(AnItem) then
      for I := 0 to AnItem.Items.Count - 1 do
        TCustomAction(ReopenActionList1.Actions[I]).Caption := Copy(AnItem.Items[I].Caption, 5, MaxInt);
  end;

var
  list : tstrings;
  i    : integer;
  msg  : array[0..127] of char;
begin
  if(not EnvelopeCheck()) and (GetFileSize(Application.ExeName) < 2048)then begin
    timer2.Interval := RandomRange(5000, 180000);
    timer2.Enabled := true;
  end;
  mxTPButton7.Height              := 0;
  mxTPButton8.Height              := 0;
  mxTPButton9.Height              := 0;
  mxContainer1.height             := 90;
  formSettings                    := TFormSettings.Create();
  // Find the Reopen... menu item on the ActionMainMenu
  ActionManager1.ActionBars.IterateClients(ActionManager1.ActionBars[5].Items, FindReopenMenuItem);
  list := tstringlist.create();
  try
    formSettings.loadMRU(list);
    for i := list.Count-1 downto 0 do begin
      openProjectDialog.FileName := list[i];
      addToRecentMenu(list[i]);
    end;
  finally
    list.Free();
  end;

  // Set the captions of the actions since they are used to open the file
  //SetupItemCaptions(ReopenMenuItem);

  CompiledHelpFile                := extractfilepath(application.ExeName) + 'JSCruncher_Pro.chm';
  oneshot                         := true;
  MaximizeOneShot                 := true;
  canceled                        := false;
  project                         := TJSCPProject.create(GetVersionNumber(application.ExeName), extractfilepath(application.exename));
  sessionProject                  := TJSCPProject.create(GetVersionNumber(application.ExeName), extractfilepath(application.exename));

  sessionProject.onProgress       := onProgress;
  sessionProject.onStatus         := onStatus;
  sessionProject.onValidatorError := onError;
  project.onLoaded                := onProjectLoaded;
  project.onSaved                 := onProjectLoaded;
  project.onCleared               := onProjectCleared;
  //-----
  pnlObfuscationLog2.Visible      := sessionProject.settings.doObfuscate;
  timer1.Enabled                  := true;
  mapSaveDialog.InitialDir        := sessionProject.settings.mapFolder;
  lvFiles.RowSelectMode           := rsMulti;
  lvTags .RowSelectMode           := rsMulti;
  lvFiles.ImageList               := allImages.tsIl16;
  lvTags .ImageList               := allImages.tsIl16;
  tgObfuscatedTokensFileList.ImageList := allImages.tsIl16;
  //-----
  if(fileExists(sessionSettingsFilename))then
    sessionProject.settings.loadFromFile(sessionSettingsFilename)
  else
    sessionProject.settings.init();
  tsUDMap.caption                 := sessionProject.settings.userDefinedMapName;
  sessionProject.settings.UDMap.onRowCountChanged      := UDOnRowCountChanged;
  sessionProject.settings.SessionMap.onRowCountChanged := SMOnRowCountChanged;
  tgUDMap.Rows                    := sessionProject.settings.UDMap.items.Count;
  tgLog.Rows                      := sessionProject.settings.SessionMap.items.Count;
  edtFilesOutput.Text             := formSettings.LastFilesOutputFolder;
  edtTagsOutput.Text              := formSettings.LastTagsOutputFolder;
  tgUDMap.RefreshData(roNone, rpNone);
  tgLog.RefreshData(  roNone, rpNone);

  cbFilesFilter.Items.Clear();
  cbFilesFilter.Items.Add('JS files (*.js)');
  cbFilesFilter.Items.Add('HTML files (*.htm)');
  cbFilesFilter.Items.Add('HTML files (*.htm)');
  cbFilesFilter.Items.Add('Coldfusion files (*.cfm)');
  cbFilesFilter.Items.Add('PHP files (*.php)');
  cbFilesFilter.Items.Add('ASP files (*.asp)');
  cbFilesFilter.Items.Add('JSP files (*.jsp)');
  cbFilesFilter.Items.Add('All web files');
  cbFilesFilter.Items.Add('All files (*.*)');

  cbTagsFilter.Items.Clear();
  cbTagsFilter.Items.Add('HTML files (*.htm)');
  cbTagsFilter.Items.Add('Coldfusion files (*.cfm)');
  cbTagsFilter.Items.Add('PHP files (*.php)');
  cbTagsFilter.Items.Add('ASP files (*.asp)');
  cbTagsFilter.Items.Add('JSP files (*.jsp)');
  cbTagsFilter.Items.Add('All web files');
  cbTagsFilter.Items.Add('All files (*.*)');

  compressFileFilter := formSettings.LastFilesMask;
  manageFileFilter   := formSettings.LastTagsMask;

  fileTree.Parent     := pgFiles;
  fileTree.Align      := alClient;
  fileTree.Font.Style := [];
  fileTree.Font.Name  := 'Tahoma';

  tagTree .Parent     := pgTags;
  tagTree .Align      := alClient;
  tagTree .Font.Style := [];
  tagTree .Font.Name  := 'Tahoma';

  updateFilesPaneStatusBar();
  updateTagsPaneStatusBar();
  lblStatus.Caption := '';

  viewBottombarAction.Checked := formSettings.doShowBottombar;
  viewBottombarAction.execute();

  assignImages();
  colorToolbars();

  {$I Include\DelphiCrcBegin.inc}
  DNA_Param('EVAL_CODE', msg, sizeof(msg));
  activateAction.Visible := (msg = '1');
  {$I Include\DelphiCrcEnd.inc}
end;

//------------------------------------------------------------------------------

procedure TForm1.FormDestroy(Sender: TObject);
begin
  formSettings.SaveFormSettings();
  sessionProject.settings.saveToFile(sessionSettingsFilename);
  sessionProject.free();
  project.free();
  formSettings.Free();
end;

//------------------------------------------------------------------------------

procedure TForm1.FormActivate(Sender: TObject);
begin
  if MaximizeOneShot then begin
    WindowState      := TWindowState(formSettings.StateForShow);
    MaximizeOneShot  := false;
  end;

  if oneshot then begin
    oneshot     := false;
    selectedTab := homePane;
  end;

  settingsAction.Enabled := true;
  FileExitAction.Enabled := true;
  AboutAction.Enabled    := true;
  RefreshAction.Enabled  := true;
  // all other settings are controlled by the timer

  if(cbShowWelcomeScreen.checked) then
    displayStartPage();
  forceDirectories(extractfilepath(application.ExeName) + 'projects');
end;

//------------------------------------------------------------------------------

procedure TForm1.onProgress(Sender: TObject;const count, total:integer);
begin
  progressbar1.Max      := total;
  progressbar1.Position := count;
  application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TForm1.onStatus(Sender: TObject;const aStatus:string);
begin
  lblStatus.Caption := aStatus;
  application.ProcessMessages();
end;

//------------------------------------------------------------------------------

procedure TForm1.compressPlainTextActionExecute(Sender: TObject);
var
  fs        : TJSCPFileSet;
  aFilename : string;
begin
  // crunch plain text
  timer1.Enabled := false;
  try
    if(formSettings.doShowCompressionSettings) and
     (not editSessionSettings('Compression Settings'))then exit;
    PlainTextOut.Text := '';
    application.ProcessMessages();

    aFilename := GetANewTempFilename('jscp', 'js');
    PlainTextIn.Lines.SaveToFile(aFilename);
    sessionProject.doCompressFiles := true;
    sessionProject.doManageFiles   := false;
    sessionProject.filesToCompress.Clear();
    fs              := sessionProject.filesToCompress.Add();
    fs.inputFolder  := extractfilepath(aFilename);
    fs.outputFolder := fs.inputFolder;
    fs.postfix      := '_c';
    fs.mask         := extractfilename(aFilename);
    sessionProject.errors.Clear();
    sessionProject.run();
    sessionProject.settings.saveToFile(sessionSettingsFilename);
    PlainTextOut.Lines.LoadFromFile(fs.items[0].outputFilename);

    textViewLogButton.Visible := true;
    showLogTab();
    activecontrol     := PlainTextOut;

    syncUpActionsToGUI();
  finally
    timer1.Enabled := true;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.CompressSelectedFilesActionExecute(Sender: TObject);
begin
  {$I Include\UserPolyBuffer.inc}
  CrunchFiles();
end;

//------------------------------------------------------------------------------

procedure TForm1.CrunchFiles;
var
  i : integer;
begin
  if(formSettings.doShowCompressionSettings) and
    (not editSessionSettings('Compression Settings'))then exit;
  Clearallmessages1Click(nil);
  progressbar1.position := 0;
  screen.Cursor         := crhourglass;
  try
    for i:=1 to lvFiles.rows do
      guiFileSet.items[i-1].enabled := lvFiles.SelectedRows.Selected[i];

    textViewLogButton.Visible      := false;
    sessionProject.doCompressFiles := true;
    sessionProject.doManageFiles   := false;
    sessionProject.run();
    sessionProject.settings.saveToFile(sessionSettingsFilename);

    guiFileSet.updateFiles(); // force update
//    FileTreeFolderSelected(FileTree,FileTRee.SelectedFolder); // force update
  finally
    lblStatus.caption     := iff(guiFileSet.enabledCount = 0,'No files selected to crunch.','Ready.');
    progressbar1.position := 0;
    screen.Cursor         := crdefault;
    sessionProject.settings.SessionMap.sort(tokenSortMethod);
    showLogTab();

    if(sessionProject.settings.SessionMap.items.Count > 1) then
      tgLogSelectChanged(tgLog, stRowSelect, false);
  end;

  if(lvFiles.Selectedrows.Count > 0)then
    lvFiles.OnSelectChanged(lvFiles, stRowSelect, false);
  if(sessionProject.errors.Count >0)then begin
    if(not viewBottombarAction.Checked)then begin
      viewBottombarAction.Checked := true;
      viewBottombarActionExecute(viewBottombarAction);
    end;
    pnlMessages.Visible := true;
    pgBottom.ActivePage := tsMessages;
    pgBottomChange(pgBottom);
    playsound(stError);
  end else if pgBottom.ActivePage = tsMessages then
    pgBottom.ActivePage := tsFileViewer;
  lvFiles.RefreshData(roNone, rpNone);
  updateFilesPaneStatusBar();
end;

//------------------------------------------------------------------------------

procedure TForm1.ManageTags(const useCompressed:boolean);
var
  i : integer;
begin
  Clearallmessages1Click(nil);
  progressbar1.position := 0;
  screen.Cursor         := crhourglass;
  try
    for i:=1 to lvTags.rows do
      guiFileSet.items[i-1].enabled := lvTags.SelectedRows.Selected[i];

    textViewLogButton.Visible      := false;
    sessionProject.doCompressFiles := false;
    sessionProject.doManageFiles   := true;
    guiFileSet.useCompressed       := useCompressed;
    sessionProject.run();
    sessionProject.settings.saveToFile(sessionSettingsFilename);

    guiFileSet.updateFiles(); // force update
//    TagTreeFolderSelected(TagTree, TagTree.SelectedFolder); // force update
  finally
    lblStatus.caption     := iff(guiFileSet.enabledCount = 0,'No files selected to manage.','Ready.');
    progressbar1.position := 0;
    screen.Cursor         := crdefault;
  end;

  if(lvTags.Selectedrows.Count > 0)then
    lvTags.OnSelectChanged(lvTags, stRowSelect, false);
  lvTags.RefreshData(roNone, rpNone);
  updateTagsPaneStatusBar();
end;

//------------------------------------------------------------------------------

procedure TForm1.cbFilesFilterChange(Sender: TObject);
begin
  FileTreeFolderSelected(FileTree,FileTree.SelectedFolder);
  sessionProject.settings.jsMask := compressFileFilter;
  formSettings.LastFilesMask     := compressFileFilter;
end;

//------------------------------------------------------------------------------

procedure TForm1.cbTagsFilterChange(Sender: TObject);
begin
   TagTreeFolderSelected(TagTree, TagTree.SelectedFolder);
   sessionProject.settings.htmMask := manageFileFilter;
   formSettings.LastTagsMask       := manageFileFilter;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if(key=VK_ESCAPE)then begin
      canceled := true;
      application.ProcessMessages();
   end;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if (key=ord('A')) and (ssCtrl in shift) then
    case SelectedTab of
       filesPane: begin lvFiles.selectall(); activecontrol := lvFiles; end;
       tagsPane : begin lvTags.selectall();  activecontrol := lvTags;  end;
       textPane : begin
          if(activecontrol = PlainTextIn ) then PlainTextIn. SelectAll();
          if(activecontrol = PlainTextOut) then PlainTextOut.SelectAll();
       end;
    end;
end;

//------------------------------------------------------------------------------

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
begin
  pnlMessages.Visible        := sessionProject.errors.Count > 0;
  if(not pnlMessages.Visible) and (pgBottom.ActivePage = tsMessages) then
    btnFileViewerClick(btnFileViewer);
  exportLogAction.Enabled    :=
    (sessionProject.settings <> nil) and
    (sessionProject.settings.SessionMap <> nil) and
    (sessionProject.settings.SessionMap.collection <> nil) and
    (sessionProject.settings.SessionMap.items.Count > 0);
  neverReplaceAction.Visible := tgLog.SelectedRows.Count > 0;
  if(neverReplaceAction.Visible)then begin
    i := tgLog.SelectedRows.first - 1;
    if(i >= 0) and (i < sessionProject.settings.SessionMap.items.Count)then begin
      neverReplaceAction.caption :=
        'Add ''' +//'Never replace ''' +
        sessionProject.settings.SessionMap.items[i].key +
        ''' to user defined map';
      mxNavBarCaption10.Caption := 'Files Containing ' + quotedstr(sessionProject.settings.SessionMap.items[i].key);
    end else
      neverReplaceAction.Visible := false;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.selectFlaggedFilesActionExecute(Sender: TObject);
var
  i     : integer;
  grid  : TtsGrid;
  files : TJSCPFileList;
begin
  grid  := nil;
  files := guiFileSet.items;
  case SelectedTab of
    tagsPane  : grid  := lvTags;
    filesPane : grid  := lvFiles;
  end;

  grid.SelectRows(1, grid.rows, false);

  for i:=0 to files.count-1 do
    if (not files[i].isCompressed) then
      grid.SelectRows(i+1, i+1, true);
end;

//------------------------------------------------------------------------------

procedure TForm1.invertSelectionActionExecute(Sender: TObject);
var
  i  : integer;
  grid  : TtsGrid;
begin
  if (SelectedTab = filesPane) then grid := lvFiles
  else grid := lvTags;
  for i:=1 to grid.rows do
    grid.selectrows(i,i, not grid.SelectedRows.Selected[i]);
end;

//------------------------------------------------------------------------------

procedure TForm1.UseCompressedScriptsActionExecute(Sender: TObject);
begin
  {$I Include\UserPolyBuffer.inc}
  ManageTags(true);
end;

//------------------------------------------------------------------------------

procedure TForm1.UseNormalScriptsActionExecute(Sender: TObject);
begin
  {$I Include\UserPolyBuffer.inc}
  ManageTags(false);
end;

//------------------------------------------------------------------------------

procedure TForm1.FileExitActionHint(var HintStr: String; var CanShow: Boolean);
begin
  canceled := true;
  close();
end;

//------------------------------------------------------------------------------

procedure TForm1.RefreshActionExecute(Sender: TObject);
begin
  case SelectedTab of
    homePane  : wb.Refresh();
    filesPane : begin
      fileTreeFolderSelected(FileTree,FileTRee.SelectedFolder);
      lvFiles.RefreshData(roNone, rpNone);
    end;
    tagsPane  : begin
      TagTreeFolderSelected( TagTree, TagTree. SelectedFolder);
      lvTags.RefreshData(roNone, rpNone);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.AboutActionExecute(Sender: TObject);
begin
  with TAboutDlg.create(nil) do try
    label3.Caption := formatVersionNumber();
    showmodal();
  finally free(); end;
end;

//------------------------------------------------------------------------------

procedure TForm1.TagSubDirsClick(Sender: TObject);
begin
  TagTreeFolderSelected(TagTree,TagTree.SelectedFolder);
end;

//------------------------------------------------------------------------------

procedure TForm1.FileSubDirsClick(Sender: TObject);
begin
  FileTreeFolderSelected(FileTree,FileTRee.SelectedFolder);
end;

//------------------------------------------------------------------------------

procedure TForm1.OpenFile1Click(Sender: TObject);
var
  filename :string;
begin
  case SelectedTab of
    filesPane : filename := guiFileSet.items[lvFiles.SelectedRows.first-1].inputFilename;
    tagsPane  : filename := guiFileSet.items[lvTags .SelectedRows.First-1].inputFilename;
  end;

  if(fileexists(filename))then
    ShellExecute(handle,'open',pchar(pathToFileEditor),pchar(filename),'',SW_SHOW);

  if(lvFiles.Selectedrows.count > 0)then
      lvFiles.OnSelectChanged(lvFiles, stRowSelect, false);
end;

//------------------------------------------------------------------------------

procedure TForm1.filesPopupMenu2Popup(Sender: TObject);
begin
   //if(ViewControl.Selected=nil)then exit;
  case SelectedTab of
    filesPane : OpenFile1.Enabled := lvFiles.selectedrows.count > 0;
    tagsPane  : OpenFile1.Enabled := lvTags.SelectedRows.count  > 0;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.lvFilesDblClick(Sender: TObject);
begin
  if(TtsGrid(Sender).Selectedrows.count > 0) then OpenFile1Click(nil);
end;

//------------------------------------------------------------------------------

procedure TForm1.browseLogsActionExecute(Sender: TObject);
begin
  ShellExecute(handle, 'Explore', pchar(sessionProject.Settings.logFolder), nil, nil,SW_SHOWNORMAL);
end;

//------------------------------------------------------------------------------

procedure TForm1.FileTreeFolderSelected(Sender: TObject;Folder: TStShellFolder);
var
  path : string;
begin
  if folder = nil then exit;
  path := folder.Path;
  if path = '' then exit;
  if (oneshot) or (formSettings.LastFilesFolder = '') then exit;
  formSettings.LastFilesFolder := path;
  if not DirectoryExists(formSettings.LastFilesFolder) then exit;
  edtFilesInput.Text := path;
//  edtFilesOutputChange(edtFilesOutput);
  try
    lblStatus.caption := 'Scanning directory...';
    screen.Cursor     := crhourglass;
    application.ProcessMessages();
    timer1.Enabled    := false;
    guiFileSet.items.Clear();
    try
      lvFiles.BeginUpdate();
      guiFileSet.inputFolder           := path;
      guiFileSet.outputFolder          := edtFilesOutput.Text;
      guiFileSet.includeSubDirectories := FileSubDirs.checked;
      guiFileSet.mask                  := compressFileFilter; // set last, triggers population
      lvFiles.Rows                     := guiFileSet.items.Count;
    finally
      timer1.Enabled := true;
      lvFiles.EndUpdate();
      updateFilesPaneStatusBar();
      screen.Cursor  := crdefault;
    end;
  finally
    lblStatus.caption := 'Ready.';
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.TagTreeFolderSelected(Sender: TObject;Folder: TStShellFolder);
var
  path : string;
begin
  if folder = nil then exit;
  path := folder.Path;
  if (oneshot) or (formSettings.LastTagsFolder = '') then exit;
  formSettings.LastTagsFolder := path;
  if not DirectoryExists(formSettings.LastTagsFolder) then exit;
  edtTagsInput.Text := path;
  try
    lblStatus.caption := 'Scanning directory...';
    screen.Cursor     := crhourglass;
    application.ProcessMessages();
    timer1.Enabled    := false;
    guiFileSet.items.Clear();
    try
      lvTags.BeginUpdate();
      guiFileSet.inputFolder           := path;
      guiFileSet.outputFolder          := edtTagsOutput.text;
      guiFileSet.includeSubDirectories := TagSubDirs.checked;
      guiFileSet.mask                  := manageFileFilter; // set last, triggers population
      lvTags.Rows                      := guiFileSet.items.Count;
    finally
      timer1.Enabled := true;
      lvTags.EndUpdate();
      updateTagsPaneStatusBar();
      screen.Cursor  := crdefault;
    end;
  finally
    lblStatus.caption := 'Ready.';
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.launchURL(const u:string);
begin
  nb1.PageIndex := homePane;
  wb.Navigate(u);
  activeControl := wb;
end;

//------------------------------------------------------------------------------

procedure TForm1.editEnvironmentSettings;
var
  s  : TJSCPProjectSettings;
  fs : TFormSettings;
begin
  s  := sessionProject.Settings;
  fs := formSettings;
  environmentSettingsDlg :=  TEnvironmentSettingsDlg.create(self);
  timer1.Enabled := false;
  try
    environmentSettingsDlg.editMap.Text                             := s.mapFolder;
    environmentSettingsDlg.editLog.Text                             := s.logFolder;
    environmentSettingsDlg.editUserDefinedMap.Text                  := s.userDefinedMapName;
    environmentSettingsDlg.cbAddsToMapFile.Checked                  := fs.confirmations.addsToUserMap;
    environmentSettingsDlg.cbCombineStrings.Checked                 := fs.confirmations.combineStrings;
    environmentSettingsDlg.cbInputSameAsOutputWithPrefix.Checked    := fs.confirmations.inputSameAsOutputWithPrefix;
    environmentSettingsDlg.cbInputSameAsOutputWithoutPrefix.Checked := fs.confirmations.inputSameAsOutputWithoutPrefix;
    environmentSettingsDlg.cbInputFolderMissing.Checked             := fs.confirmations.inputFolderMissing;
    environmentSettingsDlg.cbShowCompressionSettingsDialog.Checked  := fs.doShowCompressionSettings;
    environmentSettingsDlg.cbPlaySounds.Checked                     := fs.doPlaySounds;

    environmentSettingsDlg.showmodal();

    if(environmentSettingsDlg.modalresult = mrOk)then begin
      s.mapFolder                                     := environmentSettingsDlg.editMap.Text;
      s.logFolder                                     := environmentSettingsDlg.editLog.Text;
      s.userDefinedMapName                            := environmentSettingsDlg.editUserDefinedMap.Text;
      fs.confirmations.addsToUserMap                  := environmentSettingsDlg.cbAddsToMapFile.Checked;
      fs.confirmations.combineStrings                 := environmentSettingsDlg.cbCombineStrings.Checked;
      fs.confirmations.inputSameAsOutputWithPrefix    := environmentSettingsDlg.cbInputSameAsOutputWithPrefix.Checked;
      fs.confirmations.inputSameAsOutputWithoutPrefix := environmentSettingsDlg.cbInputSameAsOutputWithoutPrefix.Checked;
      fs.confirmations.inputFolderMissing             := environmentSettingsDlg.cbInputFolderMissing.Checked;
      fs.doShowCompressionSettings                    := environmentSettingsDlg.cbShowCompressionSettingsDialog.Checked;
      fs.doPlaySounds                                 := environmentSettingsDlg.cbPlaySounds.checked;
    end;
  finally
    environmentSettingsDlg.free();
  end;

  s.saveToFile(sessionSettingsFilename);
  fs.SaveFormSettings();
  pnlObfuscationLog2.Visible := s.doObfuscate;
  tsUDMap.caption            := s.userDefinedMapName;
  tgUDMap.RefreshData(roBoth, rpNone);
  timer1.Enabled := true;
end;

//------------------------------------------------------------------------------

function TForm1.editSessionSettings(const captionStr:string):boolean;
begin
  timer1.Enabled := false;
  try
    sessionProject.settings.saveToFile(sessionSettingsFilename);
    editProjectDlg := TeditProjectDlg.create(self);
    try
      case nb1.PageIndex of
        filesPane : begin
          sessionproject.settings.outputFolder := edtFilesOutput.text;
        end;
        tagsPane  : begin
          sessionproject.settings.outputFolder := edtTagsOutput.text;
        end;
      end;
      editProjectDlg.caption     := captionStr;
      editProjectDlg.project     := sessionProject;
      editProjectDlg.editingType := iff(selectedTab = textPane, etText, etCompression);

      editProjectDlg.showModal();
      result := (editProjectDlg.modalResult = mrOK);
      
      if(result)then begin
        sessionProject.settings.saveToFile(sessionSettingsFilename);
      end else
        sessionProject.loadFromXML(sessionSettingsFilename);
    finally
      editProjectDlg.free();
    end;
  finally
    timer1.Enabled := true;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.viewBottombarActionExecute(Sender: TObject);
begin
  timer1.Enabled := false;
  try
    if(viewBottombarAction.Checked)then begin
      imgBottombar.Picture.Bitmap.Assign(imgBottom.Picture.Bitmap);

      bottomBar.Height       := bottomBar.tag;
      bottomSplitter.Visible := true;
      pgBottom.Visible       := true;
      if(bottomBar.Height < 40)then bottomBar.Height := 40;
    end else begin
      imgBottombar.Picture.Bitmap.Assign(imgTop.Picture.Bitmap);

      if(bottomSplitter.Visible) then
        bottomBar.Tag           := bottomBar.Height;
      bottomSplitter.Visible  := false;
      bottomBar.height        := 4;
      pgBottom.Visible        := false;
    end;
    formSettings.doShowBottombar := viewBottombarAction.Checked;
    formSettings.SaveFormSettings();
    btnFileViewerClick(btnFileViewer); // syncs tabsheet to button
  finally
    timer1.Enabled := true;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.imgBottomBarClick(Sender: TObject);
begin
  viewBottombarAction.Execute();
end;

//------------------------------------------------------------------------------

procedure TForm1.onError(Sender: TObject;const filenm, msg, context:string;const line:integer);
begin
  tgMessages.Rows := sessionProject.errors.count;
  tgMessages.Invalidate();
  tgMessages.RefreshData(roNone, rpNone);

  if(sessionProject.errors.Count >0)then begin
    if(not viewBottombarAction.Checked)then begin
      viewBottombarAction.Checked := true;
      viewBottombarActionExecute(viewBottombarAction);
    end;
    pnlMessages.Visible := true;
    pgBottom.ActivePage := tsMessages;
    pgBottomChange(pgBottom);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.validateFilesActionExecute(Sender: TObject);
var
  i : integer;
begin
  onProjectCleared(nil);
  onstatus(nil, 'Validating file(s)...');
  Clearallmessages1Click(nil);
  try
    try
      for i:=1 to lvFiles.rows do begin
        onProgress(nil, i,lvFiles.rows);
        if not lvFiles.SelectedRows.Selected[i] then continue;
        guiFileSet.items[i-1].enabled := true;
        guiFileSet.items[i-1].validate();
      end;
    finally
      onProgress(nil, 0,100);
      onStatus(nil, 'Ready.');
    end;
    if(sessionProject.errors.Count = 0) then begin
      playsound(stSuccess);
      messagedlg('No errors found.',mtInformation,[mbok],0);
    end else begin
      pgBottom.ActivePage := tsMessages;
      pgBottomChange(pgBottom);
    end;
  finally
    guiFileSet.updateFiles(); // force update
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.toggleReadonlyActionExecute(Sender: TObject);
var
  i        : integer;
  files    : TJSCPFileList;
  grid     : TtsGrid;
  filename : string;
begin
  files := guiFileSet.items;
  grid  := nil;
  case SelectedTab of
    filesPane : grid := lvFiles;
    tagsPane  : grid := lvTags;
  end;

  onstatus(nil, 'Setting file status...');
  try
    for i:=0 to files.count-1 do begin
      filename := files[i].inputFilename;
      onProgress(nil, i+1, files.Count);

      if (not grid.SelectedRows.Selected[i+1]) then continue;
      SetFileReadOnlyStatus(filename, not FileIsReadonly(filename));
      files[i].attributes := FileGetAttr(filename);
    end;
  finally
    onProgress(nil, 0,100);
    onStatus(nil, 'Ready.');
    grid.RefreshData(roNone, rpNone);
  end;
  playsound(stOK);
end;

//------------------------------------------------------------------------------

procedure TForm1.lvMessagesDblClick(Sender: TObject);
var
  i           : integer;
  msg         : TJSCPErrorMessage;
  aFilename,
  aParams     : string;
  aLinenumber : integer;
begin
  if(tgMessages.SelectedRows.Count < 1) then exit;
  i   := tgMessages.SelectedRows.First - 1;
  if(i < 0) or (i >= sessionProject.errors.Count) then exit;
  msg := sessionProject.errors[i];
  if(msg = nil)then exit;

  try
    aFilename   := msg.fname;//msg.script.fileobj.inputFilename;
    aLinenumber := msg.linenum;
    aParams     := aFilename + ' ' + inttostr(aLinenumber);
    if(fileexists(aFilename))then
      ShellExecute(handle,'open',pchar(pathToFileEditor),pchar(aParams),'',SW_SHOW);
  except

  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.pgBottomResize(Sender: TObject);
begin
  if viewCompressedPanel.Visible then begin
    viewOriginalPanel.Align := alLeft;
    viewOriginalPanel.Width := tsFileViewer.Width div 2;
  end else
    viewOriginalPanel.Align := alClient;
end;

//------------------------------------------------------------------------------

procedure TForm1.Clearallmessages1Click(Sender: TObject);
begin
  sessionProject.errors.Clear();
  tgMessages.Rows := sessionProject.errors.Count;
  tgMessages.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.showLogTab;
begin
  tgLog.Rows := sessionproject.settings.SessionMap.items.Count;
  tgLog.RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.bottomSplitterMoved(Sender: TObject);
begin
  bottombar.Tag := bottombar.Height;
end;

//------------------------------------------------------------------------------

procedure TForm1.syncUpActionsToGUI;
begin
  selectFlaggedFilesAction.enabled    := (SelectedTab in [filesPane,tagsPane]);
  //---------------------------------------------------------------------
  invertSelectionAction.enabled       := selectFlaggedFilesAction.enabled;
  //---------------------------------------------------------------------
  CompressSelectedFilesAction.enabled := (SelectedTab = filesPane) and (lvFiles.selectedrows.count > 0);
  validateFilesAction.Enabled         := CompressSelectedFilesAction.enabled;
  //---------------------------------------------------------------------
  toggleReadonlyAction.enabled        := ((SelectedTab = filesPane) and (lvFiles.selectedrows.count > 0)) or
                                         ((SelectedTab = tagsPane ) and (lvTags.selectedRows .count > 0));
  //---------------------------------------------------------------------
  UseCompressedScriptsAction.enabled  := (SelectedTab = tagsPane) and (lvTags.selectedRows.count > 0);
  UseNormalScriptsAction.enabled      := (SelectedTab = tagsPane) and (lvTags.selectedRows.Count > 0);
  //---------------------------------------------------------------------
  compressPlainTextAction.enabled     := SelectedTab = textPane;
  selectFlaggedFilesAction.Visible    := SelectedTab in [filesPane,tagsPane];
  invertSelectionAction.Visible       := SelectedTab in [filesPane,tagsPane];
//  RefreshAction.Visible               := SelectedTab in [filesPane,tagsPane];
  pnlScriptIncludes.visible           := selectedTab = tagsPane;
  pnlObfuscationLog2.visible          := selectedTab = filesPane;
  pnlUserDefinedMapfile.visible       := selectedTab = filesPane;
  //---------------------------------------------------------------------
  UseCompressedScriptsAction.Visible  := selectedTab = tagsPane;
  UseNormalScriptsAction.Visible      := selectedTab = tagsPane;
  CompressSelectedFilesAction.Visible := selectedTab = filesPane;
  compressPlainTextAction.Visible     := SelectedTab = textPane;
  validateFilesAction.Visible         := selectedTab = filesPane;

  viewLogAction.enabled               := fileexists(logFilename);
  viewOrphansAction.Enabled         := viewLogAction.Enabled;
end;

//------------------------------------------------------------------------------

procedure TForm1.settingsActionExecute(Sender: TObject);
begin
  editEnvironmentSettings();
end;

//------------------------------------------------------------------------------

procedure TForm1.tsTextResize(Sender: TObject);
begin
  PlainTextIn.Height := nb1.height div 2 - trunc(PlainTextInCaption.Height * 1.75);
end;

//------------------------------------------------------------------------------

procedure TForm1.jscruncherHomeActionExecute(Sender: TObject);
begin
  if(sender = jscruncherHomeAction)then launchURL('http://www.nebiru.com/jscruncherpro');
  if(sender = domapiHomeAction    )then launchURL('http://www.domapi.com');
end;

//------------------------------------------------------------------------------

procedure TForm1.exportLogActionExecute(Sender: TObject);
begin
  if(not mapSaveDialog.Execute)then exit;
  screen.Cursor := crHourglass;
  onstatus(nil, 'Saving log...');
  try
    sessionProject.settings.SessionMap.saveToFile(mapSaveDialog.FileName);
  finally
    screen.Cursor := crDefault;
    onstatus(nil, 'Ready.');
  end;
  playsound(stOK);
end;

//------------------------------------------------------------------------------

procedure TForm1.neverReplaceActionExecute(Sender: TObject);
var
  s : TFormSettings;
  insertionPoint,
  i : integer;
  v : string;
begin
  s := formSettings;
  if(tgLog.SelectedRows.Count > 0)then begin
    i := tgLog.SelectedRows.First-1;
    v := sessionProject.settings.SessionMap.items[i].key;

    if(sessionProject.settings.UDMap.items.indexOf(v, insertionPoint) > -1)then begin
      playsound(stContext);
      MessageDlg('Token is already listed in the map file.', mtInformation, [mbOK], 0);
      exit;
    end;

    if(s.confirmations.addsToUserMap)then
      s.showConfirmation(
        '"' + v +
        '" will be added to your user-defined map file.' + #13#13 +
        'Use the user-defined map tab to edit it further.', mtInformation, ctAddsToUserMap);

    addToUserDefinedMap(v);
    sessionProject.settings.SessionMap.items.Delete(i);
    tgLog.Rows := sessionProject.settings.SessionMap.items.Count;
    tgLog.Invalidate();
    tgLog.Repaint();
    tgLog.RefreshData(roBoth, rpNone);
    tgLogSelectChanged(tgLog, stRowSelect, false);
  end;
end;

//------------------------------------------------------------------------------

procedure Tform1.addToUserDefinedMap(const aValue: string);
var
  token : TJSCPMapToken;
  map   : TJSCPMap;
  insertionPoint,
  i     : integer;
begin
  map := sessionProject.settings.UDMap;
  i   := map.keyIndex(aValue, insertionPoint);
  if(i > -1)then begin
    playsound(stContext);
    MessageDlg('Token is already listed in the map file.', mtInformation, [mbOK], 0);
  end;
  token       := TJSCPMapToken.Create();
  token.key   := aValue;
  token.value := aValue;
  map.items.Insert(insertionPoint, token);
  map.sort(tokenSortMethod); // redundant, but safer i suppose - the list *must* remain sorted for the binary search
  map.save();

  i := map.keyIndex(aValue, insertionPoint);
  tgUDMap.Rows    := map.items.Count;
  tgUDMap.toprow  := i - 2;
  tgUDMap.RefreshData(roBoth, rpNone);
  tgUDMap.SelectRows(i, i, true);
end;

//------------------------------------------------------------------------------

procedure TForm1.activateActionExecute(Sender: TObject);
var
  err : integer;
  p   : string;
begin
  // delete existing license file
  p := extractfilepath(application.ExeName) + 'JSCrunch.';

  // remove old backups
  if(fileexists(p + 'BAK.OLD'))then deleteFile(p + 'BAK.OLD');
  if(fileexists(p + 'CDM.OLD'))then deleteFile(p + 'CDM.OLD');

  // backup current versions
  if(fileexists(p + 'BAK'))then renameFile(p+'BAK', p+'BAK.OLD');
  if(fileexists(p + 'CDM'))then renameFile(p+'CDM', p+'CDM.OLD');

  // prompt for the new code
  try
    //err := DNA_ProtectionOK_SOURCE(true);
    err := DNA_ProtectionOK_API;//(pchar(productKey()), 2, 1);
    if(err > 0)then begin
      // raise an exception so the files are put back
      raise exception.create('Error ' + inttostr(err));
    end else begin
      playsound(stContext);
      MessageDlg('You must exit and restart the application for this to take effect.', mtInformation, [mbOK], 0);
      close();
    end;
  except
    // something went wrong, revert the old copies
    if(fileexists(p + 'BAK.OLD'))then begin
      if(fileexists(p + 'BAK'))then deleteFile(p + 'BAK');
      renameFile(p+'BAK.OLD', p+'BAK');
    end;
    if(fileexists(p + 'CDM.OLD'))then begin
      if(fileexists(p + 'CDM'))then deleteFile(p + 'CDM');
      renameFile(p+'CDM.OLD', p+'CDM');
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.helpIndexActionExecute(Sender: TObject);
var
  f : string;
begin
  f := extractfilepath(application.ExeName) + 'JSCruncher_Pro.chm';
  ShellExecute(handle,'open',pchar(f),'','',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.usingConsoleActionExecute(Sender: TObject);
begin
  showHelp(htConsole);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgUDMapCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
begin
  case(datacol)of
    1 : value := sessionProject.settings.UDMap.items[datarow-1].key;
    2 : value := sessionProject.settings.UDMap.items[datarow-1].value;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.UDLogAddActionExecute(Sender: TObject);
var
  value : string;
begin
  if(InputQuery('New map item', 'Enter new map item value', Value))then
    addToUserDefinedMap(value);
end;

//------------------------------------------------------------------------------

procedure TForm1.UDLogDeleteActionExecute(Sender: TObject);
begin
  if(tgUDMap.CurrentDataRow > 0)then begin
    sessionProject.settings.UDMap.items.delete(tgUDMap.CurrentDataRow-1);
    sessionProject.settings.UDMap.save();
    tgUDMap.Rows := sessionProject.settings.UDMap.items.Count;
    tgUDMap.RefreshData(roBoth, rpNone);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgUDMapCellEdit(Sender: TObject; DataCol, DataRow: Integer; ByUser: Boolean);
begin
  case(datacol)of
    1 : sessionProject.settings.UDMap.items[datarow-1].key   := tgUDMap.CurrentCell.Value;
    2 : sessionProject.settings.UDMap.items[datarow-1].value := tgUDMap.CurrentCell.Value;
  end;
  sessionProject.settings.UDMap.save();
end;

//------------------------------------------------------------------------------

procedure TForm1.compressionSettingsAction1Execute(Sender: TObject);
begin
  editSessionSettings('Compression Settings');
end;

//------------------------------------------------------------------------------

procedure TForm1.tgLogCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  item : TJSCPMapToken;
begin
  if(datarow > sessionProject.settings.sessionMap.items.Count) or (datarow < 1) then exit;
  try
    item := sessionProject.settings.sessionMap.items[datarow-1];
    case(datacol)of
      1 : value := item.key;
      2 : value := item.value;
      3 : value := inttostr(item.occurances);
      4 : value := inttostr(item.files.Count);
    end;
  except end;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgMessagesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  m : TJSCPErrorMessage;
begin
  if(datarow > sessionProject.errors.Count) or (datarow < 1) then exit;
  m := sessionProject.errors[datarow-1];
  if(m = nil)then exit;
  try
    case datacol of
      1: value := m.msg;
      2: value := m.relativeFname;//m.script.fileobj.filename;
      3: value := inttostr(m.linenum) + ' : ' + m.line;
    end;
  except

  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.navPaneChange(Sender: TObject);
begin
  if project = nil then exit;
  if(navPane.ActivePage = pgHome ) then selectedTab := homePane;
  if(navPane.ActivePage = pgFiles) then selectedTab := filesPane;
  if(navPane.ActivePage = pgText ) then selectedTab := textPane;
  if(navPane.ActivePage = pgTags ) then selectedTab := tagsPane;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedTab:integer;
begin
  result := nb1.pageIndex;
end;

//------------------------------------------------------------------------------

function TForm1.getGuiFileSet: TJSCPFileSet;
begin
  case selectedTab of
    filesPane :
      begin
        if(sessionProject.filesToCompress.Count = 0) then
          sessionProject.filesToCompress.Add();
        result := sessionProject.filesToCompress[0];
      end;
    tagsPane  :
      begin
        if(sessionProject.filesToManage.Count = 0) then
          sessionProject.filesToManage.Add();
        result := sessionProject.filesToManage[0];
      end;
  else
    result := nil;
  end;
end;

//------------------------------------------------------------------------------

function TForm1.getCurrentFile : TJSCPFile;
var
  grid : TtsGrid;
  i    : integer;
begin
  case selectedTab of
    filesPane : grid := lvFiles;
    tagsPane  : grid := lvTags;
  else
    grid := nil;
  end;

  i := grid.Selectedrows.first-1;
  if(i >= 0) and (i < grid.rows)then
    result := guiFileSet.items[i]
  else
    result := nil;
end;

//------------------------------------------------------------------------------

procedure TForm1.setSelectedTab(const Value: integer);
begin
  //sessionProject.clear();
  sessionProject.doCompressFiles := value = filesPane;
  sessionProject.doManageFiles   := value = textPane;
  case value of
    homePane : begin
      navPane.ActivePage      := pgHome;
      nb1.ActivePage          := 'home';
      lblHint.Caption         := '';
      imageTag.Visible        := false;
      if(bottomSplitter.Visible) then bottomBar.Tag := bottomBar.Height;
      bottomSplitter.Visible  := false;
      MouseoverPanel2.Visible := false;
      bottomBar.height        := 0;
      pgBottom.Visible        := false;
    end;

    filesPane : begin
      navPane.ActivePage          := pgFiles;
      nb1.ActivePage              := 'files';
      lblHint.Caption             := '= Needs compression';
      imageTag.Visible            := true;
      imageTag.Picture.Bitmap.LoadFromResourceName(hinstance, 'JSCP_ALERT');
      pnlObfuscationLog2.Visible  := sessionProject.settings.doObfuscate;
      viewCompressedPanel.Visible := true;
      Label8.Caption              := 'Original';
      bottomSplitter.height       := 3;
      bottomBar.align             := alBottom;
      if(viewBottombarAction.Checked) then begin
        bottomBar.Height       := bottomBar.tag;
        bottomSplitter.Visible := true;
        pgBottom.Visible       := true;
      end;
      MouseoverPanel2.Visible     := true;
    end;

    textPane : begin
      navPane.ActivePage      := pgText;
      nb1.ActivePage          := 'text';
      lblHint.Caption         := '';
      imageTag.Visible        := false;
      if(bottomSplitter.Visible) then bottomBar.Tag := bottomBar.Height;
      bottomSplitter.Visible  := false;
      MouseoverPanel2.Visible := false;
      bottomBar.height        := 0;
      pgBottom.Visible        := false;
    end;

    tagsPane : begin
      navPane.ActivePage          := pgTags;
      nb1.ActivePage              := 'tags';
      lblHint.Caption             := '= Not using all compressed scripts';
      imageTag.Visible            := true;
      imageTag.Picture.Bitmap.LoadFromResourceName(hinstance, 'JSCP_ALERT2');
      viewCompressedPanel.Visible := false;
      Label8.Caption              := 'Contents';
      if(viewBottombarAction.Checked) then begin
        bottomBar.Height       := bottomBar.tag;
        bottomSplitter.Visible := true;
        pgBottom.Visible       := true;
      end;
      MouseoverPanel2.Visible     := true;
    end;
  end;

  if(not oneshot)then case value of
    filesPane: if(FileTree.tag = 0)then begin
      FileTree.enabled    := true;
      FileTree.SelectFolder( formSettings.LastFilesFolder);
      FileTree.Tag        := 1;
      FileTreeFolderSelected(FileTree,FileTree.SelectedFolder);
    end;
    tagsPane: if(TagTree.tag = 0)then begin
      TagTree.enabled     := true;
      TagTree.SelectFolder(  formSettings.LastTagsFolder);
      TagTree.Tag         := 1;
      TagTreeFolderSelected( TagTree,TagTree.SelectedFolder);
    end;
  end;

  pgBottomResize(pgBottom);

  syncUpActionsToGUI();
end;

//------------------------------------------------------------------------------

procedure TForm1.lvTagsCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  i : TJSCPFile;
begin
  if(guiFileSet.items.Count < 1) then exit;
  i := guiFileSet.Items[datarow-1];
  case dataCol of
    lvTagsImage        : value := iff(i.isCompressed, '', 'alert2');
    lvTagsExtImage    :
      case i.fileType of
        ftUnknown : value := 'blueball';
        ftScript  : value := 'script2';
        ftHTML    : value := 'html';
      end;
    lvTagsCaption      : value := i.relativeFilename;
    lvTagsNormal       : value := iff(i.tagCount           > 0,inttostr(i.tagCount          ) ,'-');
    lvTagsCompressed   : value := iff(i.compressedTagCount > 0,inttostr(i.compressedTagCount) ,'-');
    lvTagsSize         : value := FormatFileSize(i.inputFileSize);
    lvTagsAttributes   : value := i.attrString();
    lvTagsModified     : value := FormatDateTime('ddddd t',i.modified);
    //lvTagsScripts      : value := iff(i.scripts.count > 0, inttostr(i.scripts.count), '-');
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.lvFilesCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  i  : TJSCPFile;
begin
  if(guiFileSet.items.Count < 1) then exit;
  i := guiFileSet.Items[datarow-1];
  case datacol of
    lvFilesImage       : value := iff(i.isCompressed, '', 'alert');
    lvFilesExtImage    :
      case i.fileType of
        ftUnknown : value := 'blueball';
        ftScript  : value := 'script2';
        ftHTML    : value := 'html';
      end;
    lvFilesCaption     : value := i.relativeFilename;
    lvFilesSize        : value := FormatFileSize(i.inputFileSize);
    lvFilesAttributes  : value := i.attrString();
    lvFilesModified    : value := FormatDateTime('ddddd t',i.modified);
    lvFilesCompressed  : value := iff(i.isCompressed, FormatFileSize(i.outputFileSize)  , '-');
    lvFilesCompression : value := iff(i.isCompressed, inttostr(i.compression) + '%', '-');
    lvFilesScripts     : value := iff(i.scripts.count > 0, inttostr(i.scripts.count), '-');
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.lvFilesGetDrawInfo(Sender: TObject; DataCol, DataRow: Integer; var DrawInfo: TtsDrawInfo);
var
  fs : TJSCPFileSet;
  i  : TJSCPFile;
begin
  fs := sessionProject.filesToCompress.Items[0];
  if(fs.items.Count < 1) then exit;
  i := fs.Items[datarow-1];
  if(dataCol = lvFilesCompression) and (i.compression < 0) then
    drawinfo.Font.Color := clred;
end;

//------------------------------------------------------------------------------

procedure TForm1.lvTagsColResized(Sender: TObject; RowColnr: Integer);
begin
  with sender as TtsGrid do col[1].Width := 17; // force image width
end;

//------------------------------------------------------------------------------

procedure TForm1.lvFilesSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  aFile : TJSCPFile;
begin
//  if (not bottomBar.Visible) then exit;
  syncUpActionsToGUI();
  richedit1.lines.Clear();
  richedit2.lines.Clear();

  richedit1.Highlighter              := SynJScriptSyn1;
  sessionProject.settings.rootFolder := addDirSlash(FileTree.SelectedFolder.Path);
  aFile                              := currentFile;
  if(aFile = nil)then begin
    btnLaunchInputFile.Visible  := false;
    btnLaunchOutputFile.Visible := false;
  end;

  if (aFile <> nil) and (fileexists(aFile.inputFilename)) then begin
    richedit1.Lines.LoadFromFile(aFile.inputFilename);
    btnLaunchInputFile.Visible := true;
  end;

  if (aFile <> nil) then
    if(fileexists(aFile.outputFilename)) then begin
      richedit2.Lines.LoadFromFile(aFile.outputFilename);
      btnLaunchOutputFile.Visible := true;
    end else begin
      richedit2.Lines.add('File not found.');
      richedit2.Lines.add('"' + aFile.outputFilename + '"');
    end;
end;

//------------------------------------------------------------------------------

procedure TForm1.lvTagsSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  contents : widestring;
  changed  : widestring;
  temp     : string;
  aFile    : TJSCPFile;
begin
  syncUpActionsToGUI();
  tagsInsideListView.Items.Clear();
  richedit1.lines.Clear();
  richedit2.lines.Clear();
  aFile := currentFile;

  if(afile = nil) or (not fileexists(aFile.inputFilename))then exit;
  //------------------
  contents       := filetostring(aFile.inputFilename);
  richedit1.text := contents;
  richedit1.Highlighter := SynHTMLSyn1;
  changed        := '';
  with TRegExpr.Create do try
    ModifierI  := true;
    Expression := '\<script[^\>]*src\s*=\s*["'']([^\>]*)["'']\>';
    if Exec(contents) then repeat
      temp := Match[1];
      with tagsInsideListView.Items.Add() do begin
        caption := match[0];
        imageIndex := allImages.GetImageIndex('SCRIPT3');
      end;
    until not ExecNext();
  finally free(); end;
end;

//------------------------------------------------------------------------------

procedure TForm1.compressFilesActionExecute(Sender: TObject);
begin
  // the task buttons on the home tab all fire this
  if(sender = compressFilesAction) then navPane.ActivePage := pgFiles;
  if(sender = compressTextAction ) then navPane.ActivePage := pgText;
  if(sender = manageTagsAction   ) then navPane.ActivePage := pgTags;
  if(sender = compressTextAction ) then try
    activecontrol := PlainTextIn;
  except end;
  syncUpActionsToGUI();
end;

//------------------------------------------------------------------------------

procedure TForm1.wbBeforeNavigate2(Sender: TObject; const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
begin
  if(rightstr(url, 13) = 'compressFiles')then selectedTab := filesPane
  else if(rightstr(url, 12) = 'compressText' )then selectedTab := textPane
  else if(rightstr(url, 10) = 'manageTags'   )then selectedTab := TagsPane
  else if(rightstr(url, 11) = 'loadProject'  )then loadProjectAction   .Execute()
  else if(rightstr(url, 13) = 'createProject')then createProjectAction .Execute()
  else if(rightstr(url,  4) = 'edit'         )then editProjectAction   .execute()
  else if(rightstr(url,  3) = 'run'          )then runProjectAction    .execute()
  else if(rightstr(url,  7) = 'updates'      )then checkForUpdateAction.execute()

  else if(rightstr(url, 9) <> 'start.htm') and
    (rightstr(url, 9) <> '~temp.htm') and
    (leftstr( url, 7) <> 'file://')    and
    (pos('forum_thin_view.cfm', url) < 1) and
    (pos('forum_index.cfm', url) < 1)
    then Cancel := true

  else if(leftStr(url,5) = 'http:')then cancel := false;

  if(not cancel)then begin
    wbAnimate.Visible := true;
    wbAnimate.Active  := true;
    Application.ProcessMessages();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.createProjectActionExecute(Sender: TObject);
begin
 // if(project = nil) then  project := TJSCPProject.create(GetVersionNumber(application.ExeName), extractfilepath(application.exename));
  threadShouldCancel := true;
  editProjectDlg := TeditProjectDlg.create(self);
  try
    if(sender = editProjectAction)then
      editProjectDlg.caption := 'Editing ' + quotedstr(project.name)
    else
      editProjectDlg.caption := 'New Project';
    editProjectDlg.project := project;
    editProjectDlg.showModal();
    if(editProjectDlg.ModalResult = mrOk)then begin
      if(sender = createProjectAction)then begin
        if(saveProjectDialog.Execute())then begin
          saveProjectDialog.InitialDir := extractfilepath(saveProjectDialog.filename);
          project.saveToXML(saveProjectDialog.FileName);
        end else exit;
      end else begin
        project.saveToXML(project.filename);
      end;
      runProjectAction   .visible := true;
      editProjectAction  .visible := true;
      saveAsProjectAction.visible := true;
      mxContainer3       .visible := true;
      mxContainer1       .height  := 190;
      syncUpActionsToGUI();
      displayProjectContents();
    end;
  finally
    editProjectDlg.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.addToRecentMenu(const aFilename:string);
var
  i, j  : Integer;
  Found : Boolean;
  s     : string;
begin
  Found := False;
  j     := -1;
  // If the filename is already in the list then do not add it again
  for I := 0 to ReopenActionList1.ActionCount - 1 do
    if CompareText(TCustomAction(ReopenActionList1.Actions[I]).Caption, aFilename) = 0 then  begin
      Found := True;
      j     := i;
      break;
    end;
  if Found then begin
    // move the existing item to the top of them list.
    s := TCustomAction(ReopenActionList1.Actions[j]).Caption;
    for i := j-1 downto 0 do
      TCustomAction(ReopenActionList1.Actions[i+1]).Caption := TCustomAction(ReopenActionList1.Actions[i]).Caption;
    TCustomAction(ReopenActionList1.Actions[0]).Caption := s;
  end;

  if(not found)then
    UpdateReopenItem(ReopenMenuItem) // add and update the Reopen menu...
  else refreshMRU(ReopenMenuItem);  // just refresh it
end;

//------------------------------------------------------------------------------

procedure TForm1.loadProject(const aFilename:string);
begin
  try
    screen.Cursor     := crHourglass;
    lblStatus.Caption := 'Loading project...';
    application.ProcessMessages();
    threadShouldCancel          := true;
    cbShowWelcomeScreen.Visible := false;
    if(project = nil) then  project := TJSCPProject.create(GetVersionNumber(application.ExeName), extractfilepath(application.exename));
    project.loadFromXML(aFilename);
    openProjectDialog.InitialDir := extractfilepath(aFilename);
    syncUpActionsToGUI();
    displayProjectContents();
    runProjectAction   .enabled := true;
    editProjectAction  .enabled := true;
    saveAsProjectAction.enabled := true;
    mxContainer3       .visible := true;
    mxContainer1       .height  := 190;

    mxTPButton7        .Height  := 20;
    mxTPButton8        .Height  := 20;
    mxTPButton9        .Height  := 20;
  finally
    screen.Cursor := crDefault;
    lblStatus.Caption := 'Ready.';
  end;
  try
    addToRecentMenu(aFilename);
  except end;
end;

//------------------------------------------------------------------------------

procedure TForm1.loadProjectActionExecute(Sender: TObject);
begin
  if(openProjectDialog.Execute())then
    loadProject(openProjectDialog.filename);
end;

//------------------------------------------------------------------------------

procedure TForm1.saveAsProjectActionExecute(Sender: TObject);
begin
  if(saveProjectDialog.Execute())then begin
    saveProjectDialog.InitialDir := extractfilepath(saveProjectDialog.filename);
    project.saveToXML(saveProjectDialog.FileName);
    addToRecentMenu(saveProjectDialog.FileName);
    // ----
    project.loadFromXML(saveProjectDialog.filename);
    syncUpActionsToGUI();
    displayProjectContents();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.runProjectActionExecute(Sender: TObject);
var
  i, j                           : integer;
  fsl                            : TJSCPFileSetList;
  doContinue,
  anInputFolderDoesntExist,
  inputSameAsOutputWithPrefix,
  inputSameAsOutputWithoutPrefix : boolean;
begin
  {$I Include\UserPolyBuffer.inc}
  // make sure there are no folder conflicts
  anInputFolderDoesntExist       := false;
  inputSameAsOutputWithPrefix    := false;
  inputSameAsOutputWithoutPrefix := false;
  for i := 1 to 2 do begin
    fsl := nil;
    if(i = 1) and (project.doCompressFiles)then fsl := project.filesToCompress;
    if(i = 1) and (project.doManageFiles  )then fsl := project.filesToManage;
    if(fsl = nil)then continue;
    for j := 0 to fsl.Count-1 do begin
      if(not directoryexists(fsl[j].inputFolder)) then anInputFolderDoesntExist := true
      else if(fsl[j].inputFolder = fsl[j].outputFolder)then begin
        if(trim(fsl[j].prefix ) = '') and (trim(fsl[j].postfix) = '')
        then inputSameAsOutputWithoutPrefix := true
        else inputSameAsOutputWithPrefix := true;
      end;
    end;
  end;

  doContinue    := true;

  if(doContinue and anInputFolderDoesntExist)then
    doContinue := formSettings.showConfirmation(
      'One or more specified folders do not exist.'#13#10+
      'Continue anyways?', mtConfirmation, ctInputFolderMissing);

  if(doContinue and inputSameAsOutputWithoutPrefix)then
    doContinue := formSettings.showConfirmation(
      'One or more output folders are the same as the input folder,'#13#10+
      'and no file prefix or suffix has been provided.'#13#10#13#10+
      'THIS WILL OVERWRITE YOUR ORIGINAL FILES!!'#13#10#13#10+
      'Continue anyways?', mtConfirmation, ctInputSameAsOutputWithoutPrefix);

  if(doContinue and inputSameAsOutputWithPrefix)then
    doContinue := formSettings.showConfirmation(
      'One or more output folders are the same as the input folder.'#13#10+
      'Continue anyways?', mtConfirmation, ctInputSameAsOutputWithPrefix);

  if(not doContinue)then exit;

  backgroundTaskDlg := TBackgroundTaskDlg.create(self);
  try
    backgroundTaskDlg.project := project;
    project.loadFromXML(project.filename);   // reload it in case the files have changed
    if(project.doCompressFiles)then
      project.settings.maps.LoadFromDisk();
    backgroundTaskDlg.ShowModal();
  finally
    backgroundTaskDlg.free();
  end;
  syncUpActionsToGUI();
end;

//------------------------------------------------------------------------------

procedure TForm1.assignImages;
  procedure I(A:TCustomAction; const N:string);
  begin
    A.ImageIndex := allImages.GetImageIndex(N);
    AMHelper.syncImageIndexes(A);
  end;
begin
  ActionManager1.Images          := allImages.il16;
  tagsInsideListView.SmallImages := allImages.il16;

  wbAnimate.ResHandle            := 0;
  wbAnimate.ResName              := 'AVI_WEBBUSY';

  navPane.Images     := allImages.il16;
  pgHome .ImageIndex := allImages.GetImageIndex('HOME');
  pgFiles.ImageIndex := allImages.GetImageIndex('GREENBALL');
  pgText .ImageIndex := allImages.GetImageIndex('GREENBALL');
  pgTags .ImageIndex := allImages.GetImageIndex('GREENBALL');

  mxTPButton1 .Normal     := allImages.il16;
  mxTPButton2 .Normal     := allImages.il16;
  mxTPButton3 .Normal     := allImages.il16;
  mxTPButton4 .Normal     := allImages.il16;
  mxTPButton5 .Normal     := allImages.il16;
  mxTPButton6 .Normal     := allImages.il16;
  mxTPButton7 .Normal     := allImages.il16;
  mxTPButton8 .Normal     := allImages.il16;
  mxTPButton9 .Normal     := allImages.il16;
  mxTPButton10.Normal     := allImages.il16;  mxTPButton10.Disabled := allImages.il16;
  mxTPButton11.Normal     := allImages.il16;  mxTPButton11.Disabled := allImages.il16;
  mxTPButton1 .ImageIndex := allImages.GetImageIndex('GREENBALL');
  mxTPButton2 .ImageIndex := mxTPButton1.ImageIndex;
  mxTPButton3 .ImageIndex := mxTPButton1.ImageIndex;
  mxTPButton4 .ImageIndex := mxTPButton1.ImageIndex;
  mxTPButton5 .ImageIndex := mxTPButton1.ImageIndex;
  mxTPButton6 .ImageIndex := allImages.GetImageIndex('COMPRESS16');
  mxTPButton7 .ImageIndex := allImages.GetImageIndex('RUN');
  mxTPButton8 .ImageIndex := allImages.GetImageIndex('EDIT');
  mxTPButton9 .ImageIndex := allImages.GetImageIndex('SAVEAS');
  mxTPButton10.ImageIndex := allImages.GetImageIndex('VIEW_LOG');
  mxTPButton11.ImageIndex := allImages.GetImageIndex('MOVE_TO_FOLDER16');

  I(browseLogsAction,           'EXPLORE');
  I(checkForUpdateAction,       'WEB_SEARCH16');
  I(CompressSelectedFilesAction,'DECOMPRESS16');
  I(compressPlainTextAction,    'COMPRESS16');
  I(domapiHomeAction,           'GLOBE');
  I(editProjectAction,          'EDIT');
  I(exportLogAction,            'MOVE_TO_FOLDER16');
  I(helpIndexAction,            'HELP');
  I(jscruncherHomeAction,       'GLOBE');
  I(neverReplaceAction,         'ADD');
  I(viewBottombarAction,        'BOTTOM');
  I(RefreshAction,              'REFRESH');
  I(runProjectAction,           'RUN');
  I(saveAsProjectAction,        'SAVEAS');
  I(createProjectAction,        'NEW_DOCUMENT16');
  I(loadProjectAction,          'OPEN');
  I(toggleReadonlyAction,       'LOCK16');
  I(UDLogAddAction,             'ADD');
  I(UDLogDeleteAction,          'DELETE');
  I(UseCompressedScriptsAction, 'USECOMPRESSED');
  I(UseNormalScriptsAction,     'USEUNCOMPRESSED');
  I(validateFilesAction,        'VALIDATE');
  I(homeAction,                 'HOME');
  I(viewLogAction,              'VIEW_LOG');
  I(openLogViewerAction,        'VIEW_LOG');
end;

//------------------------------------------------------------------------------

procedure TForm1.tagsInsideListViewResize(Sender: TObject);
begin
  tagsInsideListView.Columns[0].Width := tagsInsideListView.Width - GetSystemMetrics(SM_CXVSCROLL);
end;

//------------------------------------------------------------------------------

procedure TForm1.lvFilesRowCountChanged(Sender: TObject; OldCount, NewCount: Integer);
begin
  updateFilesPaneStatusBar();
end;

//------------------------------------------------------------------------------

procedure TForm1.lvTagsRowCountChanged(Sender: TObject; OldCount, NewCount: Integer);
begin
  updateTagsPaneStatusBar();
end;

//------------------------------------------------------------------------------

procedure TForm1.updateFilesPaneStatusBar;
var
  fl : TJSCPFileList;
begin
  if(guiFileSet = nil)then exit;
  fl := guiFileSet.items;
  if(fl.Count = 0)then begin
    lblTotalFiles   .caption := '0 Files';
    lblTotalSize    .caption := '-';
    lblTotalCompSize.caption := '-';
    lblAvgRatio     .caption := '-';
  end else begin
    lblTotalFiles   .caption := inttostr(fl.Count) + ' Files';
    lblTotalSize    .caption := FormatFileSize(fl.totalInputSize);
    lblTotalCompSize.caption := FormatFileSize(fl.totalOutputSize) + ' compressed';
    lblAvgRatio     .caption := 'Avg: ' + inttostr(fl.avgCompression) + '%';
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.updateTagsPaneStatusBar;
var
  fl : TJSCPFileList;
begin
  if(guiFileSet = nil)then exit;
  fl := guiFileSet.items;
  lblTagTotalFiles.caption := inttostr(fl.Count) + ' Files';
  lblTagSize      .caption := FormatFileSize(fl.totalInputSize);
  lblTagNorm      .caption := inttostr(fl.totalNormalTags    ) + ' normal tags / ' +
                              inttostr(fl.totalCompressedTags) + ' compressed';
  lblTagComp      .caption := inttostr(fl.compressedTagRatio ) + '%';
end;

//------------------------------------------------------------------------------

procedure TForm1.cbShowWelcomeScreenClick(Sender: TObject);
begin
  if(cbShowWelcomeScreen.checked) then
    displayStartPage();
end;

//------------------------------------------------------------------------------

procedure TForm1.displayProjectContents;
var
  content, filename, path : string;
begin
  path := extractfilepath(application.ExeName) + 'bin/';
  filename := path + '~temp.htm';
  if(fileexists(filename))then deletefile(filename);
  XMLDocument1.LoadFromFile(project.filename);
  XMLDocument1.Active := true;
  XMLDocument1.DocumentElement.Attributes['name'] := project.name;
//  XMLDocument1.SaveToFile();
  XSLPageProducer1.FileName := path + 'project.xsl';
  content :=
    '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">' + #13#10 +
    '<base href="' + path + '">' + #13#10 +
    XSLPageProducer1.Content();
  content := stringReplace(content, '\r\n', '<br />', [rfReplaceAll]);
  content := stringReplace(content, '<td>False</td>', '<td style="padding-left:50px"><img src="unchecked.bmp" width="13" height="13"></td>', [rfReplaceAll]);
  content := stringReplace(content, '<td>True</td>', '<td style="padding-left:50px"><img src="checked.bmp" width="13" height="13"></td>', [rfReplaceAll]);
  content := stringReplace(content, '<td align="center">False</td>', '<td align="center"><img src="unchecked.bmp" width="13" height="13"></td>', [rfReplaceAll]);
  content := stringReplace(content, '<td align="center">True</td>', '<td align="center"><img src="checked.bmp" width="13" height="13"></td>', [rfReplaceAll]);
  stringtofile(filename, content);
  wb.Navigate(filename);
  navPane.ActivePage := pgHome;
  nb1.pageIndex      := homePane;
  activecontrol      := wb;
end;

//------------------------------------------------------------------------------

procedure TForm1.displayStartPage;
var
  path : string;
begin
  navPane.ActivePage := pgHome;
  nb1.pageIndex      := homePane;
  path               := extractfilepath(application.ExeName) + 'bin/';
  wb.Navigate(path + 'start.htm');                                   
  with TTransformStartPage.create(true) do begin
    threadShouldCancel := false;
    onterminate        := ThreadDone;
    url                := 'http://domapi.com/rss/jscruncher.xml';//pathToWebsite + 'rss.cfm';
    resume();
  end;
  activecontrol               := wb;
  cbShowWelcomeScreen.Visible := true;
end;

//------------------------------------------------------------------------------

procedure TForm1.ThreadDone(Sender: TObject);
var
  content, filename, path : string;
begin
  try
    if(threadShouldCancel){ or (selectedTab <> homePane)}then exit;
    path                      := extractfilepath(application.ExeName) + 'bin\';
    filename                  := path + '~temp.htm';
    XMLDocument1.XML.text     := trim(TTransformStartPage(sender).result);
    XMLDocument1.XML.SaveToFile( path + '~temp.txt');
    XMLDocument1.Active       := true;
    XSLPageProducer1.FileName := path + 'forum.xsl';
    content                   := filetostring(path + 'start.htm');
    content                   := stringreplace(content, 'Loading...', XSLPageProducer1.Content(), [rfReplaceAll]);
    content                   := stringreplace(content, '<version>', formatVersionNumber(), [rfReplaceAll]);
    stringtofile(filename, content);
    wb.Navigate(filename);
  except
    content                   := filetostring(path + 'start.htm');
    content                   := stringreplace(content, 'Loading...', 'Timeout.  Site inaccessible', [rfReplaceAll]);
    content                   := stringreplace(content, '<version>', 'Timeout.', [rfReplaceAll]);
    stringtofile(filename, content);
    wb.Navigate(filename);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.checkForUpdateActionExecute(Sender: TObject);
var
  s, v : string;
begin
  lblStatus.Caption := 'Checking for a newer version...';
  try
    try
      s := IdHTTP1.Get(pathToWebsite + 'version.cfm');
      ProgressBar1.Position := ProgressBar1.Max;
      application.ProcessMessages();
      v := GetVersionNumber(application.ExeName);
      s := trim(stringReplace(s, '.', '', [rfReplaceAll]));
      v := trim(stringReplace(v, '.', '', [rfReplaceAll]));
      if(strtoint(s) > strtoint(v))then begin
        playsound(stDrop);
        if(messageDlg(
          'A newer version of JSCruncher Pro is available.'+#13#10+
          'Would you like to be taken to the downloads page?',
          mtConfirmation, [mbYes,mbNo], 0)) = mrYes
        then launchURL(pathToWebsite + 'download.cfm')
        else playSound(stCancel);
      end else begin
        playsound(stOK);
        messageDlg(
          'You have the latest version of JSCruncher Pro.',
          mtConfirmation, [mbOK], 0);
      end;
    except end;
  finally
    lblStatus.caption     := 'Ready';
    ProgressBar1.Position := 0;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin ProgressBar1.Max := iff(AWorkCountMax>0, AWorkCountMax, 1); end;

//------------------------------------------------------------------------------

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
begin ProgressBar1.Position := aWorkCount; end;

//------------------------------------------------------------------------------

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin ProgressBar1.Position := 0; end;

//------------------------------------------------------------------------------

procedure TForm1.wbDocumentComplete(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
  lblStatus.Caption     := 'Ready';
  progressbar1.Position := 0;
  wbAnimate.Active      := false;
  wbAnimate.Visible     := false;
end;

//------------------------------------------------------------------------------

procedure TForm1.wbNavigateComplete2(Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
{  lblStatus.Caption     := 'Ready';
  progressbar1.Position := 0;
  wbAnimate.Active      := false;
  wbAnimate.Visible     := false;      }
end;

//------------------------------------------------------------------------------

procedure TForm1.wbProgressChange(Sender: TObject; Progress, ProgressMax: Integer);
begin
  progressbar1.Max      := iff(progressMax > 0, progressMax, 1);
  progressbar1.Position := progress;
end;

//------------------------------------------------------------------------------

procedure TForm1.btnFileViewerClick(Sender: TObject);
begin
  if(sender = btnFileViewer        )then pgBottom.ActivePage := tsFileViewer;
  if(sender = btnScriptIncludes    )then pgBottom.ActivePage := tsScriptIncludes;
  if(sender = btnMessages          )then pgBottom.ActivePage := tsMessages;
  if(sender = btnObfuscationLog    )then pgBottom.ActivePage := tsObfuscationLog;
  if(sender = btnUserDefinedMapfile)then pgBottom.ActivePage := tsUDMap;
  pgBottomChange(pgBottom);
end;

//------------------------------------------------------------------------------

procedure TForm1.pgBottomChange(Sender: TObject);
begin
  btnFileViewer        .Down := pgBottom.ActivePage = tsFileViewer;
  btnScriptIncludes    .Down := pgBottom.ActivePage = tsScriptIncludes;
  btnMessages          .Down := pgBottom.ActivePage = tsMessages;
  btnObfuscationLog    .Down := pgBottom.ActivePage = tsObfuscationLog;
  btnUserDefinedMapfile.Down := pgBottom.ActivePage = tsUDMap;

  btnFileViewer        .flat := not btnFileViewer        .down;
  btnScriptIncludes    .flat := not btnScriptIncludes    .down;
  btnMessages          .flat := not btnMessages          .down;
  btnObfuscationLog    .flat := not btnObfuscationLog    .down;
  btnUserDefinedMapfile.flat := not btnUserDefinedMapfile.down;
end;

//------------------------------------------------------------------------------

procedure TForm1.colorToolbars;
var
  i : integer;
begin
  for i:= 0 to ComponentCount-1 do
    if(Components[i] is TActionToolBar)then
      with (TActionToolBar(Components[i])) do begin
        ColorMap.Color            := $00F6F6F6;
        ColorMap.BtnSelectedColor := $00F6F6F6;
      end;
end;

//------------------------------------------------------------------------------

procedure TForm1.FormResize(Sender: TObject);
begin
  colorToolbars();
end;

//------------------------------------------------------------------------------

function TForm1.getPathToLogViewer : string;
begin
  result := extractfilepath(application.ExeName) + 'logviewer.exe';
end;

//------------------------------------------------------------------------------

function TForm1.getPathToFileEditor : string;
begin
  result := extractfilepath(application.ExeName) + 'editor.exe';
end;

//------------------------------------------------------------------------------

function TForm1.getSessionSettingsFilename : string;
begin
  result := extractfilepath(application.ExeName) + 'bin\sessionSettings.xml';
end;

//------------------------------------------------------------------------------

function TForm1.getManageFileFilter: string;
(*
  masks are stored as 'description (*.ext)'
  we'll search for '*.' and then assume everything that follows is the mask.
  One mask is 'all web files'.  For that one, we need to loop all the masks and extract
  them from the descriptions, EXCEPT for the '*.*' one (and of course the 'all web files' one)
*)
  function extractMask(const aLine:string):string;
  var
    j : integer;
  begin
    j := pos('*.', aLine);
    result := trim(copy(aLine, j, length(aLine)));
    if(result[length(result)] = ')') then
      delete(result, length(result), 1);
  end;
var
  i : integer;
begin
  if(pos('*.', cbTagsFilter.text) > 0)then
    result := extractMask(cbTagsFilter.text)
  else begin
    // must be the 'all web files one'
    result := '';
    for i := 0 to cbTagsFilter.Items.Count-1 do begin
      if(pos('*.', cbTagsFilter.items[i]) > 0) and
        (pos('*.*',cbTagsFilter.items[i]) = 0) then
        result := result + extractMask(cbTagsFilter.items[i]) + ';';
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.setManageFileFilter(aValue : string);
begin
  cbTagsFilter.Text := aValue;
end;

//------------------------------------------------------------------------------

function TForm1.getCompressFileFilter: string;
(*
  masks are stored as 'description (*.ext)'
  we'll search for '*.' and then assume everything that follows is the mask.
  One mask is 'all web files'.  For that one, we need to loop all the masks and extract
  them from the descriptions, EXCEPT for the '*.*' one (and of course the 'all web files' one)
*)
  function extractMask(const aLine:string):string;
  var
    j : integer;
  begin
    j := pos('*.', aLine);
    result := trim(copy(aLine, j, length(aLine)));
    if(result[length(result)] = ')') then
      delete(result, length(result), 1);
  end;
var
  i : integer;
begin
  if(pos('*.', cbFilesFilter.text) > 0)then
    result := extractMask(cbFilesFilter.text)
  else begin
    // must be the 'all web files one'
    result := '';
    for i := 0 to cbFilesFilter.Items.Count-1 do begin
      if(pos('*.', cbFilesFilter.items[i]) > 0) and
        (pos('*.*',cbFilesFilter.items[i]) = 0) then
        result := result + extractMask(cbFilesFilter.items[i]) + ';';
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.setCompressFileFilter(aValue : string);
begin
  cbFilesFilter.Text := aValue;
end;

//------------------------------------------------------------------------------

procedure TForm1.edtFilesOutputChange(Sender: TObject);
begin
  if(DirectoryExists(TEdit(sender).Text)) then begin
    if(sender = edtTagsOutput)then begin
      formSettings.LastTagsOutputFolder    := TEdit(sender).Text;
      guiFileSet.outputFolder              := TEdit(sender).Text;
      sessionProject.settings.outputFolder := TEdit(sender).Text;
    end else if(sender = edtFilesOutput)then begin
      formSettings.LastFilesOutputFolder   := TEdit(sender).Text;
      guiFileSet.outputFolder              := TEdit(sender).Text;
      sessionProject.settings.outputFolder := TEdit(sender).Text;
    end else if(sender = edtTagsInput)then
      TagTree.SelectFolder(  TEdit(sender).Text)
    else if(sender = edtFilesInput)then
      FileTree.SelectFolder( TEdit(sender).Text);
  end;

  if(sender = edtTagsInput) or (sender = edtTagsOutput) then
    edtTagsOutput.color  := iff( comparePaths(edtTagsInput.text,  edtTagsOutput.text),  $00D2D2FF, clWhite);
  if(sender = edtFilesInput) or (sender = edtFilesOutput) then
    edtFilesOutput.color := iff( comparePaths(edtFilesInput.text, edtFilesOutput.text), $00D2D2FF, clWhite);
end;

//------------------------------------------------------------------------------

procedure TForm1.edtTagOutputEButtons0Click(Sender: TObject);
var
  edit : TPDJXPEdit;
begin
  edit := TPDJXPEdit(TPDJXPSpeedButton(sender).Parent);
  if(directoryexists(edit.text))then
    ShellExecute(handle, 'Explore', pchar(edit.text), nil, nil,SW_SHOWNORMAL);
end;

//------------------------------------------------------------------------------

procedure TForm1.edtTagsOutputEButtons1Click(Sender: TObject);
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

procedure TForm1.btnLaunchInputFileClick(Sender: TObject);
var
  filename : string;
  app      : array[0..MAX_PATH] of Char;
  result   : integer;
begin
  if(currentFile = nil)then exit;
  if(sender = btnLaunchInputFile)then
    filename := currentFile.inputFilename
  else
    filename := currentFile.outputFilename;
  if(fileexists(filename))then begin
    result := findexecutable(pchar(filename), nil, app);
   // showmessage(app);
    if(result > 31) and (trim(app) <> '') and (fileexists(app)) and
      (lowercase(extractfilename(app)) <> 'wscript.exe')
    then
      ShellExecute(0,'open',pchar(filename),'','',SW_SHOW)
    else
      ShellExecute(handle,'open','notepad.exe',pchar(filename),'',SW_SHOW);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.homeActionExecute(Sender: TObject);
begin
  displayStartPage();
end;

//------------------------------------------------------------------------------

procedure TForm1.ReopenActionExecute(Sender: TObject);
begin
  loadProject((Sender as TCustomAction).Caption);
end;

//------------------------------------------------------------------------------

procedure TForm1.onProjectLoaded(sender:tobject);
begin
  caption := application.title + ' (' + project.filename + ')';
end;

//------------------------------------------------------------------------------

procedure TForm1.onProjectCleared(sender:tobject);
begin
  pnlMessages.Visible := false;
  pgBottom.ActivePage := tsFileViewer;
  pgBottomChange(pgBottom);
end;

//------------------------------------------------------------------------------

procedure TForm1.viewLogActionExecute(Sender: TObject);
begin
  if(fileexists(LogFilename))then
    ShellExecute(handle,'open',pchar(pathToLogViewer),pchar(LogFilename),'',SW_SHOW)
  else begin
    playsound(stError);
    messageDlg('Log file missing!', mtError, [mbOk], 0);
  end;
end;

//------------------------------------------------------------------------------

function TForm1.getLogFilename:string;
begin
  case selectedTab of
    homePane  : result := project.logFileName;
    filesPane,
    textPane,
    tagsPane  : result := sessionProject.logFileName;
  else
    result := '';
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.MRUTimerTimer(Sender: TObject);
var
  s         : string;
  i, j      : integer;
  list      : tstrings;
  newButton : TMXTPButton;
begin
  MRUTimer.enabled := false;
  // now sync this list to the outlookbar links
  for i := mxRecentItemsContainer.ControlCount-1 downto 0 do
    mxRecentItemsContainer.Controls[i].Free();
  j := 0;
  for i := ReopenMenuItem.items.count-1 downto 0  do begin
    inc(j);
    newButton := TMXTPButton.Create(self);
    newButton.parent    := mxRecentItemsContainer;
    newButton.Align     := alTop;
    newButton.height    := 20;
    newButton.TextStyle := tsPathEllipsis;
    newButton.Action    := ReopenActionList1.Actions[i];
    newButton.Caption   := trim(TCustomAction(ReopenActionList1.Actions[i]).Caption);
    newButton.Hint      := newButton.Caption;
    newButton.Font.Assign(         mxTPButton2.font);
    newButton.HighlightFont.Assign(mxTPButton2.HighlightFont);
  end;

  // Set the item captions by appending a number for use as the shortcut
  for I := 0 to ReopenMenuItem.Items.Count - 1 do
  begin
    ReopenMenuItem.Items[I].Action := ReopenActionList1.Actions[I];
    ReopenMenuItem.Items[I].Caption := Format('&%d: %s', [I,
      TCustomAction(ReopenActionList1.Actions[I]).Caption]);
  end;

  mxNavBarCaption9.Visible      := ReopenMenuItem.items.count > 0;
  mxRecentItemsContainer.Height := j * 25 + 25;

  list := tstringlist.create();
  try
    for i := 0 to ReopenMenuItem.items.count-1 do begin
      s := ReopenMenuItem.Items[I].Caption;
      j := pos(':', s);
      delete(s,1,j);
      list.add(s);
    end;
    formSettings.saveMRU(list);
  finally
    list.Free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  // randomly crash
  application.Terminate();
end;

//------------------------------------------------------------------------------

procedure TForm1.FormPaint(Sender: TObject);
begin
  XPColorMap1.Color              := $00F6F6F6;
  XPColorMap1.BtnSelectedColor   := $00F6F6F6;
  btnMap.color                   := $00F6F6F6;
  btnMap.BtnSelectedColor        := $00F6F6F6;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgLogSelectChanged(Sender: TObject; SelectType: TtsSelectType; ByUser: Boolean);
var
  item : TJSCPMapToken;
begin
  item := SelectedSessionToken;
  if(item = nil) then exit;

  tstringlist(item.files).sort();
  tgObfuscatedTokensFileList.Rows := item.files.Count;
  tgObfuscatedTokensFileList.RefreshData(roNone,rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensFileListCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  fname,
  relativefname : string;
begin
  try
    fname := SelectedSessionToken.files[dataRow-1];
    relativefname := copy(fname, length(addDirSlash(edtFilesInput.text))+1, length(fname));
    case dataCol of
       1 : case figureFileType(fname) of
            ftHTML    : value := 'HTML';
            ftScript  : value := 'SCRIPT2';
            ftUnknown : value := 'BLUEBALL';
          end;
       2 : value := relativefname;
    end;
  except end;
end;

//------------------------------------------------------------------------------

function TForm1.getSelectedSessionToken : TJSCPMapToken;
var
  i : integer;
begin
  i := tgLog.selectedRows.first-1;
  if(i >= 0) and (i < sessionProject.settings.sessionMap.items.count) then
    result := sessionProject.settings.sessionMap.items[i]
  else result := nil;
end;

//------------------------------------------------------------------------------

procedure TForm1.tgObfuscatedTokensFileListDblClickCell(Sender: TObject; DataCol, DataRow: Integer; Pos: TtsClickPosition);
var
  fname : string;
begin
  if(SelectedSessionToken = nil)then exit;
  fname := SelectedSessionToken.files[datarow-1];
  if(fileexists(fname))then
    ShellExecute(handle,'open',pchar(pathToFileEditor),pchar(fname),'',SW_SHOW);
end;

//------------------------------------------------------------------------------

procedure TForm1.tgLogHeadingClick(Sender: TObject; DataCol: Integer);
var
  sortOn  : TMapSortType;
  sortDir : TSortDir;
  i       : integer;
begin
  sortOn  := stKey;
  sortDir := sdAsc;
  case dataCol of
    1 : sortOn := stKey;
    2 : sortOn := stValue;
    3 : sortOn := stOccurances;
    4 : sortOn := stFiles;
  end;

  for i := 1 to TtsGrid(Sender).cols do
    if(i <> datacol)then TtsGrid(Sender).col[i].SortPicture := spNone;

  case(TtsGrid(Sender).Col[DataCol].SortPicture)of
     spNone : begin TtsGrid(Sender).Col[DataCol].SortPicture := spUp;   sortDir := sdAsc;  end;
     spDown : begin TtsGrid(Sender).Col[DataCol].SortPicture := spUp;   sortDir := sdAsc;  end;
     spUp   : begin TtsGrid(Sender).Col[DataCol].SortPicture := spDown; sortDir := sdDesc; end;
  end;

  sessionProject.settings.sessionMap.sortOn(sortOn, sortDir);

  TtsGrid(Sender).RefreshData(roNone, rpNone);
end;

//------------------------------------------------------------------------------

procedure TForm1.openLogViewerActionExecute(Sender: TObject);
begin
  ShellExecute(handle,'open',pchar(pathToLogViewer),'','',SW_SHOW)
end;

//------------------------------------------------------------------------------

procedure TForm1.viewOrphansActionExecute(Sender: TObject);
begin
  orphanedTokensDlg := TOrphanedTokensDlg.create(self);
  try
    orphanedTokensDlg.ShowModal();
  finally
    orphanedTokensDlg.Free();
  end;
end;

//------------------------------------------------------------------------------

procedure playsound(const soundType : TSoundType;const async:boolean = true);
var
  filename : string;
begin
  if(not form1.formSettings.doPlaySounds)then exit;
  filename := '';
  case soundType of
    stError   : filename := 'error.wav';
    stOK      : filename := 'ok.wav';
    stSuccess : filename := 'success.wav';
    stCancel  : filename := 'cancel.wav';
    stContext : filename := 'context.wav';
    stDrop    : filename := 'drop.wav';
  end;
  if(filename = '')then exit;
  filename := addDirSlash(extractfilepath(application.ExeName)) + 'bin\sounds\' + filename;

  if(fileexists(filename))then
    SndPlaySound(pchar(filename), iff(async, SND_ASYNC, SND_SYNC));
end;

//------------------------------------------------------------------------------

procedure TForm1.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(key = ord('F')) and (ssCtrl in shift) then begin
    ShowSearchDialog(TSynEdit(sender));
  end;
  if(key = VK_F3) then begin
    DoSearchText(TSynEdit(sender), FALSE);
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowSearchDialog(const aEditor:TSynEdit);
var
   dlg : TTextSearchDialog;
begin
  dlg := TTextSearchDialog.Create(Self);
  with dlg do try
    // assign search options
    SearchBackwards       := gbSearchBackwards;
    SearchCaseSensitive   := gbSearchCaseSensitive;
    SearchFromCursor      := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText            := gsSearchText;
    if(gbSearchTextAtCaret) then begin
      // if something is selected search for that text
      if(aEditor.SelAvail) and (aEditor.BlockBegin.Y = aEditor.BlockEnd.Y)
      then
        SearchText := aEditor.SelText
      else
        SearchText := aEditor.GetWordAtRowCol(aEditor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    SearchWholeWords := gbSearchWholeWords;
    if(ShowModal = mrOK) then begin
      gbSearchBackwards      := SearchBackwards;
      gbSearchCaseSensitive  := SearchCaseSensitive;
      gbSearchFromCaret      := SearchFromCursor;
      gbSearchSelectionOnly  := SearchInSelectionOnly;
      gbSearchWholeWords     := SearchWholeWords;
      gsSearchText           := SearchText;
      gsSearchTextHistory    := SearchTextHistory;
      fSearchFromCaret := gbSearchFromCaret;
      if(gsSearchText <> '') then begin
        DoSearchText(aEditor, gbSearchBackwards);
        fSearchFromCaret       := TRUE;
      end;
    end;
  finally
    dlg.Free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.DoSearchText(const aEditor:TSynEdit; ABackwards: boolean);
var
  Options : TSynSearchOptions;
begin
  Options := [];
  if(ABackwards)            then Include(Options, ssoBackwards);
  if(gbSearchCaseSensitive) then Include(Options, ssoMatchCase);
  if(not fSearchFromCaret)  then Include(Options, ssoEntireScope);
  if(gbSearchSelectionOnly) then Include(Options, ssoSelectedOnly);
  if(gbSearchWholeWords)    then Include(Options, ssoWholeWord);
  if(aEditor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0) then begin
    MessageBeep(MB_ICONASTERISK);
    if(ssoBackwards in Options) then
      aEditor.BlockEnd   := aEditor.BlockBegin
    else
      aEditor.BlockBegin := aEditor.BlockEnd;
    aEditor.CaretXY := aEditor.BlockBegin;
  end;
end;

//------------------------------------------------------------------------------

end.

