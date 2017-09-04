unit objects;

interface

uses
  classes, xml_lite, Contnrs, sysutils;

const
  extMap     = '.jmap';
  extLog     = '.jlog';
  extProject = '.jpro';

type
  TBadLineEvent  = procedure(Sender: TObject;const filenm, msg, context:string;const line:integer) of object;
  TProgressEvent = procedure(Sender: TObject;const count, total:integer) of object;
  TStatusEvent   = procedure(Sender: TObject;const aStatus:string) of object;
  TFileType      = (ftUnknown, ftScript, ftHTML);
  TScriptType    = (stInline, stBlock);
  TFilesetType   = (ftCompress, ftManage);
  TScriptTagType = (ttCompressed, ttNormal, ttUnknown);
  TSourceType    = (stSource, stDestination);

  TSortDir       = (sdAsc, sdDesc);
  TMapSortType   = (stKey, stValue, stOccurances, stFiles);

  TJSCPProject          = class;
  TJSCPFileSet          = class;
  TJSCPFileSetList      = class;
  TJSCPFile             = class;
  TJSCPFileList         = class;
  TJSCPProjectSettings  = class;
  TJSCPMapList          = class;
  TJSCPMap              = class;
  TJSCPMapTokenList     = class;
  TJSCPMapToken         = class;
  TJSCPFileValidator    = class;
  TJSCPErrorMessage     = class;
  TJSCPErrorMessageList = class;
  TJSCPScriptList       = class;
  TJSCPScript           = class;
  TJSCPScriptTagList    = class;
  TJSCPScriptTag        = class;

  TJSCPProjectSettingsFineTunings = packed record
    ExtraSemicolons,
    Whitespace,
    Comments,
    CombineStrings,
    Tabs,
    Linefeed,
    CarriageReturn,
    Formfeed,
    ExtraSpaces        : boolean;
  end;

  TJSCPProject = class(TObject)
   protected
     fVersion,
     fBasePath         : string;
     fValidator        : TJSCPFileValidator;
     fErrors           : TJSCPErrorMessageList;
     fOnValidatorError : TBadLineEvent;
     fOnProgress       : TProgressEvent;
     fOnStatus,
     fOnStatus2        : TStatusEvent;
     fOnCancelled,
     fOnLoaded,
     fOnCleared,
     fOnSaved          : TNotifyEvent;
     function  runCompression: boolean;
     function  runManangement: boolean;
     function  getName: string;
     procedure setBasePath(const Value: string);
     procedure setVersion( const Value: string);
     procedure saveLog;
   private
     fLogFileName : string;
     procedure doOnProgress(const count, total:integer);
     procedure doOnStatus(  const aStatus:string);
     procedure doOnStatus2( const aStatus:string);
   public
     filename,
     defaultStatus    : string;
     filesToCompress,
     filesToManage    : TJSCPFileSetList;
     settings         : TJSCPProjectSettings;
     doCompressFiles,
     doManageFiles,
     cancelled        : boolean;
     constructor create(const aVersion, aBasePath:string);
     destructor  destroy; override;
     procedure   saveToXML(const aFilename:string);
     procedure   loadFromXML(const aFilename:string);
     function    run:boolean;
     procedure   clear;
     property    name :string read getName;
     property    basePath : string read fBasePath write setBasePath;
     property    version  : string read fVersion  write setVersion;
     property    validator : TJSCPFileValidator read fValidator;
     property    logFileName : string read fLogFileName;
     property    errors : TJSCPErrorMessageList read fErrors;
   published
     property onValidatorError : TBadLineEvent  read fOnValidatorError write fOnValidatorError;
     property onProgress       : TProgressEvent read fOnProgress       write fOnProgress;
     property onStatus         : TStatusEvent   read fOnStatus         write fOnStatus;
     property onStatus2        : TStatusEvent   read fOnStatus2        write fOnStatus2;
     property onCancelled      : TNotifyEvent   read fOnCancelled      write fOnCancelled;
     property onLoaded         : TNotifyEvent   read fOnLoaded         write fOnLoaded;
     property onCleared        : TNotifyEvent   read fOnCleared        write fOnCleared;
     property onSaved          : TNotifyEvent   read fOnSaved          write fOnSaved;
   end;

  TJSCPProjectSettings = class(TObject)
  private
    procedure setHtmMask(const Value: string);
    procedure setJsMask(const Value: string);
   protected
     fVersion,
     fBasePath,
     fjsMask,
     fhtmMask : string;
     function  getWSRE:string;
     procedure setBasePath(const Value: string);
   public
     doPreamble,
     doCompress,
     doObfuscate,
     doAutoFixSemicolons  : boolean;
     fineTunings          : TJSCPProjectSettingsFineTunings;
     preamble_str,
     logFolder,
     mapFolder,
     userDefinedMapName,
     punctMarks,
     punctMarksBefore,
     punctMarksAfter,
     rootFolder,
     outputFolder,
     defPrefix,
     defPostfix       : string;
     maps             : TJSCPMaplist;
     UDMap            : TJSCPMap;
     SessionMap       : TJSCPMap;
     mapFilesToUse    : tstrings;
     function    SaveToXML(fancyIndent:integer = 0):string;
     procedure   loadFromXML(const n:TjanXMLNode);
     procedure   saveToFile(const aFilename:string);
     procedure   loadFromFile(const aFilename:string);
     procedure   init;
     Constructor Create(const aVersion:string);
     Destructor  Destroy;  override;
     procedure   assignTo(const target : TJSCPProjectSettings);
     property    whiteSpaceRegExp : string read getWSRE;
     property    basePath:string read fBasePath write setBasePath;
     property    jsMask :string read fjsMask write setJsMask;
     property    htmMask :string read fhtmMask write setHtmMask;
   end;

  TJSCPFileSetList = class(TCollection)
   protected
     fProject : TJSCPProject;
     procedure setItem(index: integer; value: TJSCPFileSet);
     function  getItem(index: integer):TJSCPFileSet;
     function  saveToXML(fancyIndent:integer = 0):string;
     procedure loadFromXML(const n:TjanXMLNode);
     procedure setProject(const Value: TJSCPProject);
     function  saveLog:string;
   public
     filesetType : TFilesetType;
     function  validate:boolean;
     function  compress:boolean;
     function  manage:boolean;
     property  Items[index: integer]: TJSCPFileSet read getItem write setItem; default;
     function  Add(): TJSCPFileSet;
     property  project:TJSCPProject read fProject write setProject;
   end;

  TJSCPFileSet = class(TCollectionItem)
   private
     function getProject: TJSCPProject;
     function hasPostfix(  const f,ext:string):boolean;
     function hasPrefix(   const f:string):boolean;
     function getOutputFolder: string;
     function _logFunc(const path:string;const SRec:TSearchRec):Boolean;
     procedure setInputFolder(const Value: string);
     function getEnabledCount: integer;
   protected
     fMask,
     fOutputFolder,
     fInputFolder : string;
     function  saveToXML(fancyIndent:integer = 0):string;
     procedure loadFromXML(const n:TjanXMLNode);
     procedure setMask(const Value: string);
     function  saveLog:string;
   public
     prefix,
     postfix               : string;
     includeSubDirectories,
     useCompressed         : boolean;
     items                 : TJSCPFileList;
     Constructor Create(Collection: TCollection); override;
     Destructor  Destroy;  override;
     property    mask :string read fMask write setMask;
     property    outputFolder : string read getOutputFolder write fOutputFolder;
     property    inputFolder : string read fInputFolder write setInputFolder;
     property    project:TJSCPProject read getProject;
     property    enabledCount : integer read getEnabledCount;
     procedure   updateFiles;
   end;

  TJSCPFileList = class(TCollection)
   private
     function getTotalInputSize: integer;
     function getTotalOutputSize: integer;
     function getAvgCompression: integer;
     function getTotalCompressedTags: integer;
     function getTotalNormalTags: integer;
     function getCompressedTagRatio: integer;
   protected
     fProject : TJSCPProject;
     fOwner   : TJSCPFileSet;
     procedure setItem(index: integer; value: TJSCPFile);
     function  getItem(index: integer):TJSCPFile;
     procedure setProject(const Value: TJSCPProject);
     function  saveLog:string;
   public
     procedure updateFiles;
     property  Items[index: integer]: TJSCPFile read getItem write setItem; default;
     function  Add: TJSCPFile;
     procedure clear; reintroduce;
     property  project:TJSCPProject read fProject write setProject;
     property  totalInputSize: integer read getTotalInputSize;
     property  totalOutputSize: integer read getTotalOutputSize;
     property  avgCompression: integer read getAvgCompression;
     property  totalNormalTags     : integer read getTotalNormalTags;
     property  totalCompressedTags : integer read getTotalCompressedTags;
     property  compressedTagRatio : integer read getCompressedTagRatio;
   end;

  TJSCPFile = class(TCollectionItem)
   private
     fCleanTokens,
     fObfuscatedTokens : TJSCPMapTokenList;
     fScriptTags       : TJSCPScriptTagList;
     fErrors           : TJSCPErrorMessageList;
     function  getProject: TJSCPProject;
     function  getFileType: TFileType;
     property  project : TJSCPProject read getProject;
     procedure preProcess;
     procedure tokenize;
     procedure postProcess;
     procedure removeLiteralStrings(var list:tstrings);
     procedure removeComments(var list:tstrings);
     procedure removeWhitespace(var list:tstrings; RE:string);
     procedure processTokensInEvals(var list:tstrings);
     procedure combineLiteralStrings(var list:tstrings);
     procedure removeExtraSemicolons(var list:tstrings);
     procedure restoreLiteralStrings(var list:tstrings);
     procedure restoreComments(var list:tstrings);
     function  getFileSet: TJSCPFileSet;
     procedure parseOutScriptBlocks;
     procedure parseOutHTMLAttributes;
     function  getContent: string;
     procedure parseOutScriptTags(const sourceType:TSourceType);
     function  getFilename: string;
     function  getCompressedTagCount: integer;
     function  getCompression: integer;
     function  getOutputFileSize: integer;
     function  getIsCompressed: boolean;
     function  getRelativeFilename: string;
     function  getOutputTrueFileSize: integer;
     function  getTrueCompression: integer;
     procedure update;
   protected
     fLiteralStrings,
     fComments      : tstrings;
     fInputFilename,
     fContent       : string;
     function  getNormalTagCount: integer;
     function  getTagCount: integer;
     procedure setInputFilename(const Value: string);
     function  getOutputFilename: string;
     function  saveLog:string;
   public
     modified      : tdatetime;
     attributes,
     inputFileSize : integer;
     scripts       : TJSCPScriptList;
     enabled       : boolean; // if not enabled, file is not processed
     constructor create(Collection: TCollection); override;
     destructor  destroy; override;
     function    validate:boolean;
     function    compress:boolean;
     function    manage:boolean;
     function  attrString:string;
     procedure saveToOutput;
     property  inputFilename:string read fInputFilename write setInputFilename;
     property  outputFilename:string read getOutputFilename;
     property  outputFileSize : integer read getOutputFileSize;
     property  outputTrueFileSize : integer read getOutputTrueFileSize;
     property  filename:string read getFilename;
     property  relativeFilename:string read getRelativeFilename;
     property  tagCount:integer read getTagCount;
     property  normalTagCount:integer read getNormalTagCount;
     property  compressedTagCount:integer read getCompressedTagCount;
     property  fileType :TFileType read getFileType;
     property  fileSet : TJSCPFileSet read getFileSet;
     property  literalStrings:tstrings read fLiteralStrings write fLiteralStrings;
     property  comments:tstrings read fComments write fComments;
     property  content:string read getContent;
     property  CleanTokens      : TJSCPMapTokenList read fCleanTokens;
     property  ObfuscatedTokens : TJSCPMapTokenList read fObfuscatedTokens;
     property  errors           : TJSCPErrorMessageList read fErrors;
     property  compression : integer read getCompression;
     property  trueCompression:integer read getTrueCompression;
     property  isCompressed : boolean read getIsCompressed;
   end;

  TJSCPMapToken = class(TObject)
   protected
     fFiles : tstrings;
     function saveLog:string;
   public
     key, value, map : string;
     occurances : integer;
     procedure assign(aSource:TJSCPMapToken);
     property files : TStrings read fFiles;
     constructor create;
     destructor destroy; override;
   end;

  TJSCPMapTokenList = class(TObjectList)
   protected
     FOnRowcountChanged : TNotifyEvent;
     procedure dorowcountchanged;
     procedure setItem(index: integer; value: TJSCPMapToken);
     function  getItem(index: integer):TJSCPMapToken;
   public
     function  indexOf(const aKey : String; var insertionPoint:integer):integer; reintroduce;
     procedure removeAll;
     property  Items[index: integer]: TJSCPMapToken read getItem write setItem; default;
     function  add(AObject: TJSCPMapToken): Integer;
     property  onRowCountChanged : TNotifyEvent read FOnRowcountChanged write FOnRowcountChanged;
   end;

  TJSCPMap = class(TCollectionItem)
   private                     
     fFilename : string;
     fSortOn   : TMapSortType;
     fSortDir  : TSortDir;
     procedure setFilename(const Value: string);
     procedure load();
   protected
     inupdate : boolean;
     FOnRowcountChanged : TNotifyEvent;
     procedure dorowcountchanged(sender:tobject);
   public
     compressed,
     enabled  : boolean;
     items    : TJSCPMapTokenList;
     Constructor Create(Collection: TCollection); override;
     Destructor  Destroy;  override;
     function    keyIndex(  const s:string; var insertionPoint:integer):integer;
     function    valueIndex(const s:string):integer;
     function    newKey:string;
     procedure   toStrings(const s:tstrings);
     procedure   assignTo(const target:TJSCPMap); reintroduce;
     procedure   sort(Compare: TListSortCompare);
     procedure   sortOn(aSortOn: TMapSortType; aSortDir: TSortDir);
     procedure   save;
     procedure   clear;
     procedure   deleteKey(const aKey:string);
     procedure   saveToFile(const aFilename:string);
     property    onRowCountChanged : TNotifyEvent read FOnRowcountChanged write FOnRowcountChanged;
     property    filename : string read fFilename write setFilename;
   end;

  TJSCPMapList = class(TCollection)
   protected
     settings: TJSCPProjectSettings;
     procedure setItem(index: integer; value: TJSCPMap);
     function  getItem(index: integer):TJSCPMap;
   public
     property  Items[index: integer]: TJSCPMap read getItem write setItem; default;
     function  Add(): TJSCPMap;
     procedure LoadFromDisk;
     function  findKey(const s:string;const forFile : string):TJSCPMapToken;
     function  findMapByName(const aName:string):integer;
     function  findMapByFilename(const aFilename:string):integer;
   end;

  TJSCPFileValidator = class(TObject)
   protected
     fLines,
     fOriginal,
     literalStrings,
     comments   : tstrings;
     x,y        : integer;
     function  isFunctionEnd(const vx,vy:integer):boolean;
     function  moveBackOne:string;
     function  previousNonSpaceChar:string;
     function  nextNonSpaceChar(line:integer):string;
     function  previousToken(line:integer):string;
     function  previousSymbol(line:integer):string;
     function  nextToken(line:integer):string;
     procedure removeComments;
     procedure restoreComments;
     procedure replaceLiteralStrings;
     procedure restoreLiteralStrings; overload;
     function  restoreLiteralStrings(const sent:string):string; overload;
     function  allNestedParens(const sent:string):boolean;
   public
     constructor create;
     destructor  destroy; override;
     function    validate(const aScript:TJSCPScript; const autofix, report, doRemoveComments : boolean):boolean;
     function    getLine(const line:integer):string;
   end;

  TJSCPErrorMessage = class(TObject)
   protected
     function saveLog:string;
   public
     msg,
     line,
     fname,
     relativeFname : string;
     linenum  : integer;
//     script  : TJSCPScript;
   end;

  TJSCPErrorMessageList = class(TObjectList)
   protected
     function  GetItem(    Index: Integer):TJSCPErrorMessage;
     procedure SetItem(    Index: Integer; Value: TJSCPErrorMessage);
     function  saveLog:string;
   public
     function  Add(AObject: TJSCPErrorMessage): integer;
     property  Items[Index: Integer]: TJSCPErrorMessage read GetItem write SetItem; default;
   end;

  TJSCPScriptList = class(TCollection)
   protected
     function  GetItem(    Index: Integer):TJSCPScript;
     procedure SetItem(    Index: Integer; Value: TJSCPScript);
     function  saveLog:string;
   public
     function  Add: TJSCPScript;
     property  Items[Index: Integer]: TJSCPScript read GetItem write SetItem; default;
   end;

  TJSCPScript = class(TCollectionItem)
   private
     fScriptType: TScriptType;
   public
     source         : tstrings;
     fileobj        : TJSCPFile;
     baseLineNumber : integer;
     property    scriptType: TScriptType read fScriptType write fScriptType;
     constructor create(Collection: TCollection); override;
     destructor  destroy; override;
   end;

  TJSCPScriptTagList = class(TCollection)
   protected
     function  GetItem(    Index: Integer):TJSCPScriptTag;
     procedure SetItem(    Index: Integer; Value: TJSCPScriptTag);
     function  saveLog:string;
   public
     function  Add: TJSCPScriptTag;
     property  Items[Index: Integer]: TJSCPScriptTag read GetItem write SetItem; default;
   end;

  TJSCPScriptTag = class(TCollectionItem)
   private
     fTagType: TScriptTagType;
   protected
     function saveLog:string;
   public
     source,
     filename   : string;
     lineNumber : integer;
     property tagType: TScriptTagType read fTagType write fTagType;
   end;

function stringToTagType(const aValue:string):TScriptTagType;
function tagTypeToString(const aValue:TScriptTagType):string;
function extractFileMask(const aValue:string):string;
function figureFileType(const fname:string): TFileType;
function tokenSortMethod(Item1, Item2: Pointer): Integer;

implementation

uses
  windows, jclstrings, XmlStringManip, darin_file, jclfileutils, registry,
  blowfish, string_compression, dirscan, regexpr, darin_string, jclsysutils, strutils,
  DateUtils, Math;

const
  RegKey  = '\Software\Nebiru Software\JSCruncher Pro';
  mapKey  = 'eJwryTAsjs8sji/JSI3PNq6MT8svis8qTg4qzUvOSC0KKDIIjs81KYhPy8wxNgUAgb8QpQ==';
  symbols = '!@#$%^&*(){};:"''?/\|><,.`-=[] ' + #9;
  maxValidationErrorsToReport = 50;

var
  {$IFDEF CONSOLE}
  fLastStatusString : string;
  {$ENDIF}
  fGlobalMapSorting : TJSCPMap;

//------------------------------------------------------------------------------

{$HINTS OFF}
function isInt(const s:string):boolean;
var
  i, code: Integer;
begin
  Val(s, i, code);
  result := code = 0;
end;
{$HINTS ON}

//------------------------------------------------------------------------------

function extractFileMask(const aValue:string):string;
(*
  masks are stored as 'description (*.ext)'
  we'll search for '*.' and then assume everything that follows is the mask.
  One mask is 'all web files'.  For that one, we need to loop all the masks and extract
  them from the descriptions, EXCEPT for the '*.*' one (and of course the 'all web files' one)
*)
  function _extractMask(const aLine:string):string;
  var
    j : integer;
  begin
    j := pos('*.', aLine);
    result := trim(copy(aLine, j, length(aLine)));
    if(result[length(result)] = ')') then
      delete(result, length(result), 1);
  end;
begin
  if(pos('*.', aValue) > 0)then
    result := _extractMask(aValue)
  else result := aValue
end;

//------------------------------------------------------------------------------

function tokenSortMethod(Item1, Item2: Pointer): Integer;
begin
  result := AnsiCompareStr(
    TJSCPMapToken(item1).key,
    TJSCPMapToken(item2).key
  );
end;

//------------------------------------------------------------------------------

function fileTypeToString(const aValue:TFileType):string;
begin
  case aValue of
    ftScript : result := 'Script';
    ftHTML   : result := 'HTML';
    else       result := 'Unknown';
  end;
end;

function scriptTypeToString(const aValue:TScriptType):string;
begin
  case aValue of
    stInline : result := 'Inline';
    stBlock  : result := 'Block';
    else       result := 'Unknown';
  end;
end;

function filesetTypeToString(const aValue:TFilesetType):string;
begin
  case aValue of
    ftCompress : result := 'Compress';
    ftManage   : result := 'Manage';
    else         result := 'Unknown';
  end;
end;

function tagTypeToString(const aValue:TScriptTagType):string;
begin
  case aValue of
    ttCompressed : result := 'Compressed';
    ttNormal     : result := 'Normal';
    else           result := 'Unknown';
  end;
end;

function stringToTagType(const aValue:string):TScriptTagType;
begin
  if(     aValue = 'Compressed')then result := ttCompressed
  else if(aValue = 'Normal'    )then result := ttNormal
  else if(aValue = 'Unknown'   )then result := ttUnknown
  else result := ttUnknown;
end;

//------------------------------------------------------------------------------

function MapSortCompare(Item1, Item2: Pointer): Integer;
var
  aSortOn  : TMapSortType;
  aSortDir : TSortDir;
  f1, f2   : TJSCPMapToken;
begin
  f1 := TJSCPMapToken(item1);
  f2 := TJSCPMapToken(item2);
  aSortOn  := fGlobalMapSorting.fSortOn;
  aSortDir := fGlobalMapSorting.fSortDir;
  case aSortOn of
    stKey        : result := CompareText( f1.key,         f2.key);
    stValue      : result := CompareText( f1.value,       f2.value);
    stOccurances : result := CompareValue(f1.occurances,  f2.occurances);
    stFiles      : result := CompareValue(f1.files.Count, f2.files.Count);
  else result := 0;
  end;
  if(aSortDir = sdDesc)then begin
    if(result > 0)then result := -1
    else if(result < 0)then result := 1;
  end;
end;

//------------------------------------------------------------------------------

{ TJSCPProject }

procedure TJSCPProject.clear;
begin
  fErrors        .Clear();
  filesToCompress.Clear();
  filesToManage  .clear();
  fLogFileName := '';
  if(assigned(fOnCleared))then fOnCleared(self);
end;

//------------------------------------------------------------------------------

constructor TJSCPProject.create(const aVersion, aBasePath: string);
begin
  inherited create();
  Version             := aVersion;
  doCompressFiles     := true;
  doManageFiles       := true;
  filename            := 'New Project.jpro';
  defaultStatus       := 'Ready.';
  fValidator          := TJSCPFileValidator.create();
  fErrors             := TJSCPErrorMessageList.Create();
  fErrors.OwnsObjects := false;
  settings            := TJSCPProjectSettings.create(fVersion);
  BasePath            := aBasePath;
  settings.loadFromXML(nil);
  settings.maps.LoadFromDisk();
  settings.SessionMap            := settings.maps.add();
  settings.SessionMap.enabled    := true;
  settings.SessionMap.filename   := '';
  settings.SessionMap.compressed := false;
  filesToCompress                := TJSCPFileSetList.create(TJSCPFileSet);
  filesToManage                  := TJSCPFileSetList.create(TJSCPFileSet);
  filesToCompress.project        := self;  filesToCompress.filesetType := ftCompress;
  filesToManage  .project        := self;  filesToManage  .filesetType := ftManage;
end;

//------------------------------------------------------------------------------

destructor TJSCPProject.destroy;
begin
  fErrors        .free();
  settings       .Free();
  filesToCompress.Free();
  filesToManage  .free();
  fValidator     .free();
  inherited;
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.doOnProgress(const count, total: integer);
{$IFDEF CONSOLE}
var
  percentage : integer;
{$ENDIF}
begin
{$IFDEF CONSOLE}
  //Write( fLastStatusString + ' ' + Format( '%3d %% complete'#13, [trunc((count/total)/100)] ));
  percentage := trunc((count/total)*100);
  write(fLastStatusString + '   ' + Format( '%3d%% complete'#13, [percentage] ));
  if(percentage = 100)then write(#13#10);
{$ELSE}
  if(assigned(fOnProgress))then fOnProgress(self, count, total);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.doOnStatus(const aStatus: string);
begin
{$IFDEF CONSOLE}
  if(aStatus = defaultStatus)then exit;
  write(aStatus + #13);
  fLastStatusString := aStatus;
{$ELSE}
  if(assigned(fonStatus))then fOnStatus(self, aStatus);
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.doOnStatus2(const aStatus: string);
begin
{$IFDEF CONSOLE}
  //if(aStatus = defaultStatus)then exit;
  write(aStatus + #13);
//fLastStatusString := aStatus;
{$ELSE}
  if(assigned(fonStatus2))then fOnStatus2(self, aStatus);
{$ENDIF}
end;

//------------------------------------------------------------------------------

function TJSCPProject.getName: string;
var
  i : integer;
begin
  result := extractfilename(filename);
  i := LastDelimiter('.', result);
  result := copy(result, 1, i-1);
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.loadFromXML(const aFilename: string);
var
  x     : TjanXMLTree;
  n, n2 : TjanXMLNode;
begin
  doOnStatus('Loading '''+extractFileName(aFilename)+'''...');
  filename := aFilename;
  x := TjanXMLTree.Create('tree',0,nil);
  try
    x.Text := fileToString(filename);
    x.ParseXML();
    n := x.findNamedNode('Project');
    if(n = nil) then exit;
    doCompressFiles :=  strtobool(assert(n, 'DoCompressFiles', 'False'));
    doManageFiles   :=  strtobool(assert(n, 'DoManageFiles',   'False'));
    n2 := n.findNamedNode('Settings'       );  settings       .loadFromXML(n2);
    n2 := n.findNamedNode('FilesToCompress');  filesToCompress.loadFromXML(n2);
    n2 := n.findNamedNode('FilesToManage'  );  filesToManage  .loadFromXML(n2);
  finally
    x.Free();
  end;
  doOnProgress(100,100);
  doOnStatus(defaultStatus);
  if(assigned(fOnLoaded))then fOnLoaded(self);
end;

//------------------------------------------------------------------------------

function TJSCPProject.run: boolean;
begin
  result    := true;
  cancelled := false;
  settings.init();
  if(result) and (doCompressFiles) then result := runCompression();
  if(result) and (doManageFiles  ) then result := runManangement();
  if (not cancelled)then
    saveLog()
  else begin
    if(assigned(fOnCancelled)) then fOnCancelled(self);
  end;
end;

//------------------------------------------------------------------------------

function TJSCPProject.runCompression: boolean;
begin
  doOnStatus('Compressing...');
  result := filesToCompress.compress();
  doOnStatus(defaultStatus);
end;

//------------------------------------------------------------------------------

function TJSCPProject.runManangement: boolean;
begin
  doOnStatus('Managing...');
  result := filesToManage.manage();
  doOnStatus(defaultStatus);
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.saveLog;
var
  result : string;
begin
  doOnStatus('Saving log...');
  result := xmlheader + br +
    OpenTag('ProjectLog consumer="JSCruncher Pro" version="'+fVersion+'"') + br;

  result := result + openTag('Settings') + settings.SaveToXML() + closeTag('Settings') + br;

  if(doCompressFiles)then begin
    result :=
      result                     + br +
      OpenTag('CompressionJob')  + br +
      filesToCompress.saveLog()  + br +
      CloseTag('CompressionJob') + br;
  end;

  if(doManageFiles)then begin
    result :=
      result                     + br +
      OpenTag('ManageJob')  + br +
      filesToManage.saveLog()  + br +
      CloseTag('ManageJob') + br;
  end;

  result := result + CloseTag('ProjectLog');

  fLogFileName := settings.logFolder + formatDateTime('yyyymmdd_hhnn',now()) + '.jlog';

  stringToFile(fLogFileName, result);
  doOnStatus('Log saved to ''' + extractfilename(logFileName) + '''');
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.saveToXML(const aFilename: string);
var
  result : string;
begin
  filename := aFilename;
  result :=
    xmlheader + br +
    '<Project consumer="JSCruncher Pro" version="'+fVersion+'">' + br +
    FillTag('DoCompressFiles', boolToStr(doCompressFiles, true), 1) + br +
    FillTag('DoManageFiles',   boolToStr(doManageFiles,   true), 1) + br +

    OpenTag('FilesToCompress', 1)  +
    filesToCompress.saveToXML(2)   +
    CloseTag('FilesToCompress', 1) + br +

    OpenTag('FilesToManage', 1)    +
    filesToManage.saveToXML(2)     +
    CloseTag('FilesToManage', 1)   + br +

    OpenTag('Settings', 1)         +
    settings.SaveToXML(2)          +
    CloseTag('Settings', 1)        + br +

    '</Project>';
  forcedirectories(extractfilepath(filename));
  stringToFile(filename, result);
  if(assigned(fOnSaved))then fOnSaved(self);
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.setBasePath(const Value: string);
begin
  fBasePath         := Value;
  settings.basePath := value;
end;

//------------------------------------------------------------------------------

procedure TJSCPProject.setVersion(const Value: string);
begin
  fVersion := Value;
end;

//------------------------------------------------------------------------------

{ TJSCPProjectSettings }

procedure TJSCPProjectSettings.assignTo(const target: TJSCPProjectSettings);
var
  i : integer;
begin
//  target.fFilename	                := fFilename;
  target.doPreamble	                := doPreamble;
  target.doCompress	                := doCompress;
  target.doObfuscate	              := doObfuscate;
  //target.doReportSemicolons	        := doReportSemicolons;
  target.doAutoFixSemicolons	      := doAutoFixSemicolons;
//  target.doShowCompressionSettings	:= doShowCompressionSettings;
//  target.StateForShow	              := StateForShow;
//  target.LastFilesFolder	          := LastFilesFolder;
//  target.LastTagsFolder	            := LastTagsFolder;
  target.preamble_str	              := preamble_str;
  target.logFolder	                := logFolder;
  target.mapFolder	                := mapFolder;
  target.userDefinedMapName	        := userDefinedMapName;
  target.jsMask	                    := jsMask;
  target.htmMask	                  := htmMask;
  target.mapFilesToUse.Assign( mapFilesToUse);
  target.punctMarks	                := punctMarks;
  target.punctMarksBefore	          := punctMarksBefore;
  target.punctMarksAfter	          := punctMarksAfter;
  target.rootFolder	                := rootFolder;

  target.maps.Clear();
  for i := 0 to maps.Count-1 do begin
    target.maps.Add();
    maps[i].assignTo(target.maps[i]);
  end;

  if(UDMap             = nil) then UDMap             := target.maps.Add();
  if(SessionMap        = nil) then SessionMap        := target.maps.Add();
  if(target.UDMap      = nil) then target.UDMap      := target.maps.Add();
  if(target.SessionMap = nil) then target.SessionMap := target.maps.Add();
  UDMap.assignTo(        target.UDMap     );
  SessionMap.assignTo(   target.SessionMap);

 // target.confirmations.addsToUserMap  := confirmations.addsToUserMap;
  //target.confirmations.combineStrings := confirmations.combineStrings;

  target.fineTunings.ExtraSemicolons    := fineTunings.ExtraSemicolons;
  target.fineTunings.Whitespace         := fineTunings.Whitespace;
  target.fineTunings.Comments           := fineTunings.Comments;
  target.fineTunings.CombineStrings     := fineTunings.CombineStrings;
  target.fineTunings.Tabs               := fineTunings.Tabs;
  target.fineTunings.Linefeed           := fineTunings.Linefeed;
  target.fineTunings.CarriageReturn     := fineTunings.CarriageReturn;
  target.fineTunings.Formfeed           := fineTunings.Formfeed;
  target.fineTunings.ExtraSpaces        := fineTunings.ExtraSpaces;
end;

//------------------------------------------------------------------------------

constructor TJSCPProjectSettings.Create(const aVersion: string);
begin
  inherited create();
  mapFilesToUse := tstringlist.create();
  fVersion      := aVersion;
  maps          := TJSCPMaplist.create(TJSCPMap);
  maps.settings := self;
end;

//------------------------------------------------------------------------------

destructor TJSCPProjectSettings.Destroy;
begin
  maps.free();
  mapFilesToUse.free();
  inherited;
end;

//------------------------------------------------------------------------------

function TJSCPProjectSettings.getWSRE: string;
begin
  result := '';
  if(fineTunings.ExtraSpaces    )then result := result + ' ';
  if(fineTunings.Tabs           )then result := result + '\t';
  if(fineTunings.Linefeed       )then result := result + '\n';
  if(fineTunings.CarriageReturn )then result := result + '\r';
  if(fineTunings.Formfeed       )then result := result + '\f';
  result := '[' + result + ']+';
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.init;
var
  i : integer;
begin
  maps.LoadFromDisk();
  for i := 0 to maps.count-1 do
    if(lowercase(trim(extractfilename(maps[i].filename))) = lowercase(trim(userDefinedMapName)))then
      UDMap := maps[i];
  if(UDMap = nil)then begin
    // no user defined map, create one
    UDMap := maps.Add();
    UDMap.filename := mapFolder + userDefinedMapName;
    UDMap.enabled  := true;
    UDMap.save();
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.loadFromXML(const n: TjanXMLNode);
var
  n2 : TjanXMLNode;
  s  : string;
  i  : integer;
begin
  n2 := nil;
  if(n <> nil) then n2 := n.findNamedNode('Basic');
  preamble_str       := StrEscapedToString(assert(n2, 'Preamble', strStringToEscaped(
                        'Compressed and obfuscated by JSCruncher Pro.'+#13#10+
                        'http://nebiru.com/jscruncherpro')));
  doPreamble         := StrToBool(assert(n2, 'DoPreamble',            'True'));
  doCompress         := StrToBool(assert(n2, 'DoCompress',            'True'));
  doObfuscate        := StrToBool(assert(n2, 'DoObfuscate',           'False'));
  doAutoFixSemicolons:= StrToBool(assert(n2, 'DoAutoFixSemicolons',   'False'));
  logFolder          := XmlDecode(assert(n2, 'LogFolder',             basePath+'logs\'));
  mapFolder          := XmlDecode(assert(n2, 'MapFolder',             basePath+'maps\'));
  userDefinedMapName := XmlDecode(assert(n2, 'UserDefinedMap',        'user_defined.jmap'));
  outputFolder       := XmlDecode(assert(n2, 'OutputFolder',          basePath+'output\'));
  s                  := XmlDecode(assert(n2, 'MapFilesToUse',         'ecma.jmapx;style.jmapx;user_defined.jmap;'));
  StrToStrings(s, ';', mapFilesToUse, false);
  defPrefix          := XmlDecode(assert(n2, 'DefaultPrefix',         ''));
  defPostfix         := XmlDecode(assert(n2, 'DefaultSuffix',         '_c'));
  jsMask             := XmlDecode(assert(n2, 'JSMask',                '*.js'));
  htmMask            := XmlDecode(assert(n2, 'HTMMask',               '*.htm*'));
  if(n <> nil) then n2 := n.findNamedNode('FineTuning');
  fineTunings.ExtraSemicolons    := StrToBool(assert(n2, 'RemoveExtraSemicolons', 'True'));
  fineTunings.Whitespace         := StrToBool(assert(n2, 'RemoveWhitespace',      'True'));
  fineTunings.Comments           := StrToBool(assert(n2, 'RemoveComments',        'True'));
  fineTunings.CombineStrings     := StrToBool(assert(n2, 'CombineLiteralStrings', 'True'));
  fineTunings.Tabs               := StrToBool(assert(n2, 'RemoveTabs',            'True'));
  fineTunings.Linefeed           := StrToBool(assert(n2, 'RemoveLineFeeds',       'True'));
  fineTunings.CarriageReturn     := StrToBool(assert(n2, 'RemoveCarriageReturns', 'True'));
  fineTunings.FormFeed           := StrToBool(assert(n2, 'RemoveFormFeeds',       'True'));
  fineTunings.ExtraSpaces        := StrToBool(assert(n2, 'RemoveExtraSpaces',     'True'));
  if(n <> nil) then n2 := n.findNamedNode('PuctuationMarks');
  punctMarks         := XmlDecode(assert(n2, 'All',                   '+;(){}*-=/,!<>?:|&%'));
  punctMarksBefore   := XmlDecode(assert(n2, 'NoWhitespaceBefore',    '+;(){}*-=/,!<>?:|&%'));
  punctMarksAfter    := XmlDecode(assert(n2, 'NoWhiteSpaceAfter',     '+;(){}*-=/,!<>?:|&%'));

  // cleanup values
  if(logFolder = '')then logFolder := basePath + 'logs\';
  if(mapFolder = '')then mapFolder := basePath + 'maps\';
  for i := 0 to mapFilesToUse.Count-1 do
    mapFilesToUse[i] := lowercase(mapFilesToUse[i]);

  forcedirectories(mapFolder);
  forcedirectories(logFolder);

  init();
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.saveToFile(const aFilename: string);
var
  result : string;
begin
  result :=
    xmlheader + br +
    '<ProjectSettings consumer="JSCruncher Pro" version="'+ fVersion+'">' + br +
    SaveToXML(2) +
    '</ProjectSettings>';
  forcedirectories(extractfilepath(aFilename));
  stringToFile(aFilename, result);
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.loadFromFile(const aFilename: string);
var
  x : TjanXMLTree;
  n : TjanXMLNode;
begin
  x := TjanXMLTree.Create('tree',0,nil);
  try
    x.Text := fileToString(aFilename);
    x.ParseXML();
    n := x.findNamedNode('ProjectSettings');
    loadFromXML(n);
  finally
    x.Free();
  end;
//  init();
end;

//------------------------------------------------------------------------------

function TJSCPProjectSettings.SaveToXML(fancyIndent: integer): string;
begin
  result :=  br +
    OpenTag('Basic', fancyIndent) + br +
    Filltag( 'Preamble',              XmlEncode( StrStringToEscaped(preamble_str)), fancyIndent + 1) + br +
    Filltag( 'DoPreamble',            booltostr( doPreamble, true),                 fancyIndent + 1) + br +
    Filltag( 'DoCompress',            booltostr( doCompress, true),                 fancyIndent + 1) + br +
    Filltag( 'DoObfuscate',           booltostr( doObfuscate, true),                fancyIndent + 1) + br +
    Filltag( 'DoAutoFixSemicolons',   booltostr( doAutoFixSemicolons, true),        fancyIndent + 1) + br +
    Filltag( 'LogFolder',             XmlEncode( logFolder),                        fancyIndent + 1) + br +
    Filltag( 'MapFolder',             XmlEncode( mapFolder),                        fancyIndent + 1) + br +
    Filltag( 'UserDefinedMap',        XmlEncode( userDefinedMapName),               fancyIndent + 1) + br +
    Filltag( 'OutputFolder',          XmlEncode( outputFolder),                     fancyIndent + 1) + br +
    Filltag( 'MapFilesToUse',         XmlEncode( StringsToStr(mapFilesToUse,';',false)),fancyIndent + 1) + br +
    Filltag( 'DefaultPrefix',         XmlEncode( defPrefix),                        fancyIndent + 1) + br +
    Filltag( 'DefaultSuffix',         XmlEncode( defPostfix),                       fancyIndent + 1) + br +
    FillTag( 'JSMask',                XmlEncode( jsMask),                           fancyIndent + 1) + br +
    FillTag( 'HTMMask',               XmlEncode( htmMask),                          fancyIndent + 1) + br +
    CloseTag('Basic', fancyIndent) + br +

    OpenTag('FineTuning', fancyIndent) + br +
    Filltag( 'RemoveExtraSemicolons', booltostr( fineTunings.ExtraSemicolons, true),    fancyIndent + 1) + br +
    Filltag( 'RemoveWhitespace',      booltostr( fineTunings.Whitespace, true),         fancyIndent + 1) + br +
    Filltag( 'RemoveComments',        booltostr( fineTunings.Comments, true),           fancyIndent + 1) + br +
    Filltag( 'CombineLiteralStrings', booltostr( fineTunings.CombineStrings, true),     fancyIndent + 1) + br +
    Filltag( 'RemoveTabs',            booltostr( fineTunings.Tabs, true),               fancyIndent + 1) + br +
    Filltag( 'RemoveLineFeeds',       booltostr( fineTunings.Linefeed, true),           fancyIndent + 1) + br +
    Filltag( 'RemoveCarriageReturns', booltostr( fineTunings.CarriageReturn, true),     fancyIndent + 1) + br +
    Filltag( 'RemoveFormFeeds',       booltostr( fineTunings.Formfeed, true),           fancyIndent + 1) + br +
    Filltag( 'RemoveExtraSpaces',     booltostr( fineTunings.ExtraSpaces, true),        fancyIndent + 1) + br +
    CloseTag('FineTuning', fancyIndent) + br +

    OpenTag('PuctuationMarks', fancyIndent) + br +
    Filltag( 'All',                   XmlEncode( punctMarks),                       fancyIndent + 1) + br +
    Filltag( 'NoWhitespaceBefore',    XmlEncode( punctMarksBefore),                 fancyIndent + 1) + br +
    Filltag( 'NoWhiteSpaceAfter',     XmlEncode( punctMarksAfter),                  fancyIndent + 1) + br +
    CloseTag('PuctuationMarks', fancyIndent) + br;
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.setBasePath(const Value: string);
begin
  fBasePath := Value;
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.setHtmMask(const Value: string);
begin
  fhtmMask := extractFileMask(Value);
end;

//------------------------------------------------------------------------------

procedure TJSCPProjectSettings.setJsMask(const Value: string);
begin
  fjsMask := extractFileMask(Value);
end;

//------------------------------------------------------------------------------

{ TJSCPFileSetList }

function TJSCPFileSetList.Add: TJSCPFileSet;
begin
  result := TJSCPFileSet(inherited Add);
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.compress: boolean;
var
  i, j,
  total,
  position    : integer;
  mapFileName : string;
  fileSet     : TJSCPFileSet;
  fileList    : TJSCPFileList;
begin
  // first, validate all the files
  result := validate();

  // before we start, let's mark all the maps as enabled/disabled.
  // that way we don't waste time doing it over and over.
  project.doOnStatus('Updating maps...');
  for i := 0 to project.settings.maps.Count-1 do
    if(project.settings.maps[i] <> project.settings.SessionMap)then begin
      mapFileName := trim(lowercase(extractFilename(project.settings.maps[i].filename)));
      project.settings.maps[i].enabled := project.settings.mapFilesToUse.IndexOf(mapFileName) >= 0;
      project.doOnProgress(i+1,project.settings.maps.Count);
      project.doOnStatus2(project.settings.maps[i].filename);
    end;

  // now flush the session map file
  if(project.settings.SessionMap <> nil) then
    project.settings.SessionMap.clear();
  project.doOnStatus2('');
  project.doOnStatus('Compressing files...');
  total    := 0;
  position := 0;
  for i:=0 to count-1 do begin
    fileSet  := items[i];
    filelist := fileSet.items;
    total    := total + filelist.Count;
  end;

  for i:=0 to count-1 do if(not project.cancelled)then begin
    fileSet  := items[i];
    filelist := fileSet.items;
    for j := 0 to filelist.Count-1 do if(not project.cancelled)then begin
      project.doOnStatus2(filelist[j].inputFilename);
      if(not filelist[j].compress())then result := false;
      inc(position);
      project.doOnProgress(position, total);
    end;
  end;
  project.doOnStatus2('');
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.manage: boolean;
var
  i, j,
  total,
  position    : integer;
  fileSet     : TJSCPFileSet;
  fileList    : TJSCPFileList;
begin
  project.doOnStatus('Managing tags...');
  total    := 0;
  position := 0;
  result   := true;
  for i:=0 to count-1 do begin
    fileSet  := items[i];
    filelist := fileSet.items;
    total    := total + filelist.Count;
  end;

  for i:=0 to count-1 do if(not project.cancelled)then begin
    fileSet  := items[i];
    filelist := fileSet.items;
    for j := 0 to filelist.Count-1 do if(not project.cancelled)then begin
      project.doOnStatus2(filelist[j].inputfilename);
      if(not filelist[j].manage())then result := false;
      inc(position);
      project.doOnProgress(position, total);
    end;
  end;
  project.doOnStatus2('');
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.getItem(index: integer): TJSCPFileSet;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TJSCPFileSet(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSetList.loadFromXML(const n: TjanXMLNode);
var
  i : integer;
begin
  clear();
  for i:= 0 to n.Nodes.count-1 do
    add().loadFromXML(TjanXMLNode(n.nodes[i]));
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.saveLog: string;
var
  i : integer;
begin
  result := OpenTag('FileSets') + br;
  for i := 0 to count-1 do begin
    project.doOnProgress(i,count);
    result := result + items[i].saveLog() + br;
  end;
  result := result + CloseTag('FileSets') + br;
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.saveToXML(fancyIndent: integer): string;
var
  i : integer;
begin
  result := '';
  for i:= 0 to count-1 do
    result := result + items[i].saveToXML(fancyIndent) + br;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSetList.setItem(index: integer; value: TJSCPFileSet);
begin
  if ((Index >= 0) and (Index < Count)) then
  if (Value <> nil) then
    inherited Items[Index].Assign(Value)
  else
    inherited Items[Index].Free;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSetList.setProject(const Value: TJSCPProject);
begin
  fProject := Value;
end;

//------------------------------------------------------------------------------

function TJSCPFileSetList.validate: boolean;
var
  i,j,total,position:integer;
begin
  project.doOnStatus('Validating files...');
  result := true;
  total    := 0;
  position := 0;
  for i:=0 to count-1 do
    for j := 0 to items[i].items.Count-1 do inc(total);

  for i:=0 to count-1 do
    for j := 0 to items[i].items.Count-1 do begin
      project.doOnStatus2(items[i].items[j].inputFilename);
      if(not items[i].items[j].validate())then result := false;
      inc(position);
      project.doOnProgress(position, total);
    end;
  //project.doOnStatus(project.defaultStatus);
  project.doOnStatus2('');
end;

//------------------------------------------------------------------------------

{ TJSCPFileList }

function TJSCPFileList.Add: TJSCPFile;
begin
  result := TJSCPFile(inherited Add);
end;

//------------------------------------------------------------------------------

procedure TJSCPFileList.clear;
begin
  project.errors.Clear();
  if(assigned(project.fOnValidatorError))then project.fOnValidatorError(self,'','','',-1);
  inherited;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getAvgCompression: integer;
var
  i : integer;
begin
  result := 0;
  if(count = 0)then exit;
  for i := 0 to count-1 do
    result := result + items[i].trueCompression;
  result := result div count;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getCompressedTagRatio: integer;
var
  total : integer;
begin
  total := (totalNormalTags + totalCompressedTags);
  if(total > 0) then
    result := trunc((totalCompressedTags / total ) * 100)
  else
    result := 0;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getItem(index: integer): TJSCPFile;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TJSCPFile(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getTotalCompressedTags: integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + items[i].compressedTagCount;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getTotalInputSize: integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + items[i].inputFileSize;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getTotalNormalTags: integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + items[i].normalTagCount;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.getTotalOutputSize: integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to count-1 do
    result := result + items[i].outputTrueFileSize;
end;

//------------------------------------------------------------------------------

function TJSCPFileList.saveLog: string;
begin

end;

//------------------------------------------------------------------------------

procedure TJSCPFileList.setItem(index: integer; value: TJSCPFile);
begin
  if ((Index >= 0) and (Index < Count)) then
  if (Value <> nil) then
    inherited Items[Index].Assign(Value)
  else
    inherited Items[Index].Free;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileList.setProject(const Value: TJSCPProject);
begin
  fProject := Value;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileList.updateFiles;
var
  i : integer;
begin
  for i := 0 to count-1 do
    items[i].update();
end;

//------------------------------------------------------------------------------

{ TJSCPMapTokenList }

function TJSCPMapTokenList.add(AObject: TJSCPMapToken): Integer;
begin
  Result := inherited Add(AObject);
  dorowcountchanged();
end;

//------------------------------------------------------------------------------

procedure TJSCPMapTokenList.removeAll;
var
  i : integer;
begin
  if(assigned(list))then begin
    for i := count-1 downto 0 do
      if(assigned(items[i]))then
        remove(items[i]);
    dorowcountchanged();
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPMapTokenList.dorowcountchanged;
begin
  if(assigned(fOnRowCountChanged))then
    fOnRowCountChanged(self);
end;

//------------------------------------------------------------------------------

function TJSCPMapTokenList.getItem(index: integer): TJSCPMapToken;
begin
  Result := TJSCPMapToken(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TJSCPMapTokenList.setItem(index: integer; value: TJSCPMapToken);
begin
  inherited Items[Index] := value;
end;

//------------------------------------------------------------------------------

{function TJSCPMapTokenList.indexOf(const aKey: string): integer;
var
  i : integer;
begin
  result := -1;
  for i:= 0 to count-1 do
    if(items[i].key = aKey) then begin
      result := i;
      break;
    end;
end;  }

//------------------------------------------------------------------------------

function TJSCPMapTokenList.indexof(const aKey : String; var insertionPoint:integer) : Integer;
  function compare(const i:integer):integer;
  begin
    if(copy(items[i].key,1,2) = '//')then result := -1
    else begin
      result := AnsiCompareStr(items[i].key, aKey);
    end;
  end;
var
  comp,
  First,
  Last,
  Pivot : Integer;
  Found : Boolean;
begin
  // performs a binary search on the map items - make sure they are always sorted!
  // this method returns -1 if no item was found.  when that's the case, insertionPoint is
  // given the index where you would insert the the new item
  insertionPoint := 0;
  First  := 0; //Sets the first item of the range
  Last   := count-1; //Sets the last item of the range
  Found  := False; //Initializes the Found flag (Not found yet)
  Result := -1; //Initializes the Result

  //If First > Last then the searched item doesn't exist
  //If the item is found the loop will stop
  while (First <= Last) and (not Found) do begin
    //Gets the middle of the selected range
    Pivot := (First + Last) div 2;
    //Compares the String in the middle with the searched one
    comp := compare(pivot);
    if(comp = 0) then begin
      Found  := True;
      Result := Pivot;
    end else if(comp > 0) then begin
      //If the Item in the middle has a bigger value than
      //the searched item, then select the first half
      Last           := Pivot - 1;
  //    insertionPoint := last;
    end else begin
      //else select the second half
      First          := Pivot + 1;
    //  insertionPoint := pivot;
    end;
  end;
  //if(insertionPoint >= count)then insertionPoint := count-1;
  //if(insertionPoint < 0)then insertionPoint := 0;
  insertionPoint := first;
end;

//------------------------------------------------------------------------------

{ TJSCPMapList }

function TJSCPMapList.Add: TJSCPMap;
begin
  result := TJSCPMap(inherited Add);
end;

//------------------------------------------------------------------------------

function TJSCPMapList.findKey(const s: string; const forFile : string): TJSCPMapToken;
  function exists(const ss:string; var innerInsertionPoint:integer):TJSCPMapToken;
  var
    i,j : integer;
  begin
    result := nil;
    for i := 0 to settings.maps.Count-1 do
      if(settings.maps[i].enabled) then begin
        // search for an existing mapping
        j := settings.maps[i].keyIndex(ss, innerInsertionPoint);
        if (j > -1) then begin
          result := settings.maps[i].items[j];
          inc(result.occurances);
          exit;
        end;
      end;
    // no match found, now check ones we've already replaced
    j := settings.SessionMap.keyIndex(ss, innerInsertionPoint);
    if j > -1 then
      result := settings.SessionMap.items[j];
  end;

var
  t,
  newValue       : string;
  lookup,
  newToken       : TJSCPMapToken;
  insertionPoint : integer;
begin
  result := exists(s, insertionPoint);
  if(result <> nil)then begin
    if(result.files.IndexOf(forFile) < 0)then result.files.Add(forFile);
    exit;
  end;

  // no existing key, create a new one
  t := s;
  newValue := settings.SessionMap.newKey();
  lookup   := exists(newValue, insertionPoint);
  while(lookup <> nil)do begin
    newValue := settings.SessionMap.newKey();
    lookup   := exists(newValue, insertionPoint);
  end;

  newToken          := TJSCPMapToken.Create();
  settings.SessionMap.keyIndex(s, insertionPoint); // find insertion point
  settings.SessionMap.items.Insert(insertionPoint, newToken);
  result            := settings.SessionMap.items.Items[insertionPoint];
  result.map        := settings.SessionMap.filename;
  result.key        := s;
  result.value      := newValue;             
  if(result.files.IndexOf(forFile) < 0)then result.files.Add(forFile);
  result.occurances := 1;
end;

//------------------------------------------------------------------------------

function TJSCPMapList.findMapByFilename(const aFilename: string): integer;
var
  i : integer;
begin
  result := -1;
  for i:= 0 to count-1 do
    if(lowercase(trim(items[i].fFilename)) = lowercase(trim(aFilename)))then result := i;
end;

//------------------------------------------------------------------------------

function TJSCPMapList.findMapByName(const aName: string): integer;
var
  i : integer;
begin
  result := -1;
  for i:= 0 to count-1 do
    if(lowercase(extractfilename(items[i].fFilename)) = lowercase(aName))then result := i;
end;

//------------------------------------------------------------------------------

function TJSCPMapList.getItem(index: integer): TJSCPMap;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TJSCPMap(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TJSCPMapList.LoadFromDisk;
var
  list : tstrings;
  i    : integer;
begin
  list := tstringlist.Create();
  try
    buildfilelist(addDirSlash(settings.mapFolder) + '*.jmap*',faAnyfile,list);
    for i := count-1 downto 0 do
      if(items[i] <> settings.SessionMap)then delete(i);
    for i := 0 to list.Count-1 do
      with add() do begin
        enabled  := true;
        filename := addDirSlash(settings.mapFolder) + list[i];
      end;
  finally
     list.free();
  end;
  if(settings.SessionMap<> nil) and (settings.SessionMap.items <> nil) then
    settings.SessionMap.load();
end;

//------------------------------------------------------------------------------

procedure TJSCPMapList.setItem(index: integer; value: TJSCPMap);
begin
  if ((Index >= 0) and (Index < Count)) then
  if (Value <> nil) then
    inherited Items[Index].Assign(Value)
  else
    inherited Items[Index].Free;
end;

//------------------------------------------------------------------------------

{ TJSCPMap }

procedure TJSCPMap.assignTo(const target: TJSCPMap);
begin
  target.filename := filename;
  target.enabled  := enabled;
  target.items.Assign(items);
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.clear;
begin
  items.removeAll();
  items.Clear();
  items.dorowcountchanged();
end;

//------------------------------------------------------------------------------

constructor TJSCPMap.Create(Collection: TCollection);
begin
  inherited;
  randomize();
  items    := TJSCPMapTokenList.create();
  items.OwnsObjects       := true;
  items.onRowCountChanged := dorowcountchanged;
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.deleteKey(const aKey: string);
var
  i,
  insertionPoint : integer;
begin
  i := keyIndex(aKey, insertionPoint);
  if(i > -1)then items.Delete(i);
  if(assigned(onRowCountChanged))then onRowCountChanged(self); 
end;

//------------------------------------------------------------------------------

destructor TJSCPMap.Destroy;
begin
  items.free();
  inherited;
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.dorowcountchanged(sender: tobject);
begin
  if(assigned(fonrowcountchanged)) and (not inupdate)then
    fonrowcountchanged(self);
end;

//------------------------------------------------------------------------------

{function TJSCPMap.keyIndex(const s: string): integer;
var
  i : integer;
begin
  result := -1;
  for i:= 0 to items.Count-1 do
    if (items[i].key = s)and(copy(items[i].key,1,2)<>'//') then begin
      result := i;
      exit;
    end;
end;    }

function TJSCPMap.keyIndex(const s : String; var insertionPoint:integer) : Integer;
  function compare(const i:integer):integer;
  begin
    if(copy(items[i].key,1,2) = '//')then result := -1
    else begin
      result := AnsiCompareStr(items[i].key, s);
    end;
  end;
var
  comp,
  First,
  Last,
  Pivot : Integer;
  Found : Boolean;
begin
  // performs a binary search on the map items - make sure they are always sorted!
  // this method returns -1 if no item was found.  when that's the case, insertionPoint is
  // given the index where you would insert the the new item
  insertionPoint := 0;
  First  := 0; //Sets the first item of the range
  Last   := items.count-1; //Sets the last item of the range
  Found  := False; //Initializes the Found flag (Not found yet)
  Result := -1; //Initializes the Result
//savetofile('c:\temp.txt');
  //If First > Last then the searched item doesn't exist
  //If the item is found the loop will stop
  while (First <= Last) and (not Found) do begin
    //Gets the middle of the selected range
    Pivot := (First + Last) div 2;
    //Compares the String in the middle with the searched one
    comp := compare(pivot);
    if(comp = 0) then begin
      Found  := True;
      Result := Pivot;
    end else if(comp > 0) then begin
      //If the Item in the middle has a bigger value than
      //the searched item, then select the first half
      Last           := Pivot - 1;
    //  insertionPoint := last;
    end else begin
      //else select the second half
      First          := Pivot + 1;
  //    insertionPoint := pivot;
    end;
  end;
  insertionPoint := first;
//  if(insertionPoint >= items.count)then insertionPoint := items.count-1;
//  if(insertionPoint < 0)then insertionPoint := 0;
end;


//------------------------------------------------------------------------------

procedure TJSCPMap.load;
var
  list,
  line  : tstringlist;
  i     : integer;
  e     : string;
  token : TJSCPMapToken;
begin
  items.removeAll();
  if not fileexists(filename) then exit;
  e := ExtractFileExt(filename);
  list := tstringlist.create();
  line := tstringlist.Create();
  try
    list.LoadFromFile(filename);
    compressed := (e = '.jmapx');
    if(compressed)then
      list.Text := DecryptText(decodeanduncompress(mapKey),filetostring(filename));
    list.CaseSensitive := true;
    list.Sort();
    for i := 0 to list.Count -1 do begin
       line.CommaText := list[i];
       if (line.Count = 1) then line.Add(line[0]);
       if (line.Count = 2) then begin
         token       := TJSCPMapToken.Create();
         token.key   := line[0];
         token.value := line[1];
         token.map   := filename;
         items.add(token);
       end;
    end;
  finally
    list.Free();
    line.free();
  end;
end;

//------------------------------------------------------------------------------

function TJSCPMap.newKey: string;
// this function spits out a random 3-5 character var name.
// the first char is always a letter (upper or lower case)
// the other two are letters but can also be a digit
// this mean we can have up 180,000 vars

  function randomLetter:string;
  begin
    if(random(10) > 8) then begin // >20% of the time, get a $ or _
      if(random(10) > 4) then result := '$' else result := '_';
    end else begin
      result := chr(random(25)+65); // uppercase
      if random(10) > 4 then result := lowercase(result); // lowercase 50% of the time
    end;
  end;

  function randomNumberLetter:string;
  begin
     if random(10) > 4 then  // use a numeric 50% of the time
        result := randomLetter()
     else
        result := inttostr(random(10));
  end;
var
  i, length : integer;
begin
  length := 2 + random(3);
  result := randomLetter();
  for i := 1 to length do
    result := result + randomNumberLetter();
  if valueIndex(result) > -1 then // already in use
    result := newKey();          // try again
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.save;
begin
  SaveToFile(filename);
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.saveToFile(const aFilename: string);
var
  list : tstrings;
begin
  list := tstringlist.create();
  try
    toStrings(list);
    list.SaveToFile(aFilename);
  finally
    list.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.setFilename(const Value: string);
begin
  fFilename := Value;
  load();
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.sort(Compare: TListSortCompare);
begin
  items.sort(Compare);
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.sortOn(aSortOn: TMapSortType; aSortDir: TSortDir);
begin
  fGlobalMapSorting := self;
  fSortOn  := aSortOn;
  fSortDir := aSortDir;
  self.sort(MapSortCompare);
end;

//------------------------------------------------------------------------------

procedure TJSCPMap.toStrings(const s: tstrings);
var
  i : integer;
begin
  s.Clear();
  for i := 0 to items.Count-1 do
    if(items[i].key <> items[i].value)then
      s.Add(items[i].key + #9 + ',' + items[i].value)
    else
      s.Add(items[i].key);
end;

//------------------------------------------------------------------------------

function TJSCPMap.valueIndex(const s: string): integer;
var
  i : integer;
begin
  result := -1;
  for i:= 0 to items.Count-1 do
    if (items[i].value = s)and(copy(items[i].key,1,2)<>'//') then begin
       result := i;
       exit;
    end;
end;

//------------------------------------------------------------------------------

{ TJSCPFileSet }

constructor TJSCPFileSet.Create(Collection: TCollection);
begin
  inherited;
  items         := TJSCPFileList.create(TJSCPFile);
  items.project := project;
  items.fOwner  := self;
  prefix        := project.settings.defPrefix;
  postfix       := project.settings.defPostfix;
  outputFolder  := project.settings.outputFolder;
end;

//------------------------------------------------------------------------------

destructor TJSCPFileSet.Destroy;
begin
  items.Free();
  inherited;
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.getEnabledCount: integer;
var
  i : integer;
begin
  result := 0;
  for i:=0 to items.Count-1 do
    if(items[i].enabled)then inc(result);
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.getOutputFolder: string;
begin
  Result := fOutputFolder;
  if(result = '')then begin
    // output folder has not been specified - have it default to the projects output folder
    result := project.settings.outputFolder;
  end;
  result := addDirSlash(result);
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.getProject: TJSCPProject;
begin
  if(collection = nil)then result := nil
  else
    result := TJSCPFileSetList(Collection).project;
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.hasPostfix(const f, ext: string): boolean;
begin
  if (postfix <> '') then
    result := pos(postfix + ext, f) > 0
  else
    result := false;
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.hasPrefix(const f: string): boolean;
begin
  if (prefix <> '') then
    result := uppercase(copy(f,1,length(prefix))) = uppercase(prefix)
  else
    result := false;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSet.loadFromXML(const n: TjanXMLNode);
begin
  inputFolder           := XmlDecode(assert(n, 'InputFolder', ''));
  prefix                := XmlDecode(assert(n, 'Prefix', ''));
  postfix               := XmlDecode(assert(n, 'Suffix', '_c'));
  useCompressed         := StrToBool(assert(n, 'useCompressed', 'True'));
  if(n.findNamedNode('OutputFolder') <> nil)then
    outputfolder        := XmlDecode(assert(n, 'OutputFolder', ''))
  else outputfolder := inputFolder;
  includeSubDirectories := strtobool(XmlDecode(assert(n, 'DoSubDirs', false)));
  // always set mask last, triggers the population
  mask                  := XmlDecode(assert(n, 'Mask', '*.*'));
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.saveLog: string;
var
  i : integer;
begin
  result := result +
    OpenTag('FileSet') + br +
    FillTag('InputFolder', inputFolder) + br +
    FillTag('OutputFolder', outputFolder) + br +
    FillTag('Prefix', prefix) + br +
    FillTag('Suffix', postfix) + br +
    FillTag('Mask', mask) + br +
    FillTag('IncludeSubDirectories', boolToStr(IncludeSubDirectories, true)) + br;

  if(TJSCPFileSetList(collection).filesetType = ftManage)then
    result := result +
    FillTag('UseCompressed', boolToStr(UseCompressed, true)) + br;
  result := result + OpenTag('Files') + br;
  for i := 0 to items.count-1 do
    result := result + items[i].saveLog() + br;
  result := result + CloseTag('Files') + br;
  result := result + CloseTag('FileSet');
end;

//------------------------------------------------------------------------------

function TJSCPFileSet.saveToXML(fancyIndent: integer): string;
begin
  result := br +
    OpenTag('Item', fancyIndent) + br +
    FillTag('InputFolder',   XmlEncode(inputFolder),                fancyIndent + 1) + br +
    FillTag('OutputFolder',  XmlEncode(outputfolder),               fancyIndent + 1) + br +
    FillTag('Mask',          XmlEncode(mask),                       fancyIndent + 1) + br +
    FillTag('DoSubDirs',     boolToStr(includeSubDirectories, true),fancyIndent + 1) + br +
    Filltag('Prefix',        XmlEncode(prefix),                     fancyIndent + 1) + br +
    Filltag('Suffix',        XmlEncode(postfix),                    fancyIndent + 1) + br;
  if(TJSCPFileSetList(collection).filesetType = ftManage)then
    result := result +
    FillTag('UseCompressed', booltostr(useCompressed, true),        fancyIndent + 1) + br;
  result := result +
    CloseTag('Item', fancyIndent);
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSet.setInputFolder(const Value: string);
begin
  fInputFolder := addDirSlash(Value);
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSet.setMask(const Value: string);
var
  //list,
  extensions : tstrings;
  i          : integer;
  //aFile      : TJSCPFile;
begin
  fMask := trim(Value);
  if (length(fMask) > 0) and (fMask[length(fMask)] = ';')then
    delete(fMask, length(fMask), 1);
  // folder and includeSubDirectories should have been set before setting the mask
  // populate the list based on these three items
 // list       := tstringlist.create();
  extensions := tstringlist.Create();
  try
    extensions.Delimiter := ';';
    extensions.DelimitedText := fMask;
    items.clear();
    for i := 0 to extensions.count-1 do
      //fileRecurse.findFiles(folder, extensions[i], list, includeSubDirectories, false);
      FindRecursive( inputFolder, extractFileMask(extensions[i]), _logFunc, includeSubDirectories);
   {
    for i := 0 to list.count-1 do begin
      aFile := items.Add();
      aFile.inputFilename := list[i];
    end;}
  finally
   // list      .free();
    extensions.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileSet.updateFiles;
var
  i : integer;
begin
  for i:= 0 to items.Count-1 do
    items[i].update();
end;

//------------------------------------------------------------------------------

function TJSCPFileSet._logFunc(const path: string; const SRec: TSearchRec): Boolean;
var
  aFile     : TJSCPFile;
  i         : integer;
  aFilename : string;
begin
  result := true;
  aFilename := path + SRec.Name;
  for i := 0 to items.count-1 do
    if(items[i].inputFilename = aFilename)then exit; // filter doubles

  aFile := items.Add();
  aFile.inputFilename := aFilename;
  aFile.inputFileSize := srec.Size;
  aFile.modified      := FileDateToDateTime(SRec.Time);
  aFile.attributes    := SRec.Attr;
end;

//------------------------------------------------------------------------------

{ TJSCPFile }

function TJSCPFile.compress: boolean;
var
  i : integer;
begin
  result := true;
  if(not enabled)then exit;
  self.preProcess();
  if(project.settings.doObfuscate)then begin
    self.tokenize();
    for i:= 0 to self.scripts.Count-1 do
      self.processTokensInEvals(self.scripts[i].source);
  end;
  self.postProcess();
  self.saveToOutput();
end;

//------------------------------------------------------------------------------

constructor TJSCPFile.create(Collection: TCollection);
begin
  inherited;
  enabled             := true;
  scripts             := TJSCPScriptList.Create(TJSCPScript);
  fLiteralStrings     := tstringlist.create();
  fComments           := tstringlist.create();
  fCleanTokens        := TJSCPMapTokenList.Create(true);
  fObfuscatedTokens   := TJSCPMapTokenList.Create(true);
  fScriptTags         := TJSCPScriptTagList.Create(TJSCPScriptTag);
  fErrors             := TJSCPErrorMessageList.Create();
  fErrors.OwnsObjects := true;
end;

//------------------------------------------------------------------------------

destructor TJSCPFile.destroy;
begin
  fLiteralStrings  .free();
  fComments        .free();
  scripts          .Free();
  fCleanTokens     .Free();
  fObfuscatedTokens.Free();
  fScriptTags      .Free();
  fErrors          .free();
  inherited;
end;

//------------------------------------------------------------------------------

function figureFileType(const fname:string): TFileType;
const
  htmlExt = '.html.cfml.asp.jsp.php';
  jsExt   = '.js';
var
  ext : string;
begin
  result := ftUnknown;
  ext := extractFileExt(fname);
  if(pos(ext, jsExt) > 0)then
    result := ftScript
  else if(pos(ext, htmlExt) > 0)then
    result := ftHTML;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getFileType: TFileType;
begin
  result := figureFileType(inputFilename);
end;

//------------------------------------------------------------------------------

function TJSCPFile.getNormalTagCount: integer;
var
  i : integer;
begin
  result := 0;
  for i := 0 to fScriptTags.Count-1 do
    if(fScriptTags[i].tagType = ttNormal)then inc(result);
end;

//------------------------------------------------------------------------------

function TJSCPFile.getTagCount: integer;
begin
  result := fScriptTags.Count;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getOutputFilename: string;
var
  fname,
  outputfolder : string;
  i            : integer;
begin
  fname        := extractfilename(inputFilename);
  outputfolder := ExtractFilePath(inputFilename);
  delete(outputFolder,1,length(fileset.inputFolder));
  outputFolder := fileset.outputFolder + outputFolder;

  i := LastDelimiter('.', fname);
  result :=
    fileset.prefix  +
    copy(fname, 1, i - 1)   +
    fileset.postfix +
    extractFileExt(fname);

  result := addDirSlash(outputFolder) + result;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getProject: TJSCPProject;
begin
  result := TJSCPFileList(collection).project;
end;

//------------------------------------------------------------------------------

function TJSCPFile.manage: boolean;
var
  contents,
  changed       : widestring;
  prevpos       : integer;
  temp,
  finalFilename : string;
begin
  result := false;
  if(not enabled)then exit;
  if not fileexists(inputFilename) then exit;
  //------------------
  contents := filetostring(inputFilename);
  changed  := '';
  PrevPos  := 1;
  with TRegExpr.Create do try
    ModifierI  := true;
    Expression := '\<script[^\>]*src\s*=\s*["'']([^\>]*)["'']\>';
    if Exec(contents) then repeat
      temp := Match[1];
      if(fileset.useCompressed) then begin
        if(not fileset.hasPostfix(temp,'.js')) then
          temp := StringReplace(temp,'.js',fileset.postfix+'.js',[rfIgnoreCase]);
        if(not fileset.hasPrefix( temp)) then
          temp := fileset.prefix + temp;
      end else begin
        if(fileset.hasPostfix(temp,'.js')) then
          temp := StringReplace(temp,fileset.postfix+'.js','.js',[rfIgnoreCase]);
        if(fileset.hasPrefix( temp)) then
          temp := copy(temp,length(fileset.prefix)+1,length(temp));
      end;
      changed := changed+
                 Copy(contents, PrevPos, MatchPos[1]-PrevPos)+
                 temp;
      PrevPos := MatchPos[1] + MatchLen[1];
    until not ExecNext();
    changed    := changed+Copy(contents,PrevPos,MaxInt);
    finalFilename := outputFilename;
    forceDirectories(ExtractFilePath(finalFilename));
    StringToFile(finalFilename, changed);
  finally free(); end;

  result := true;

  parseOutScriptTags(stDestination);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.preProcess;
var
  i : integer;
begin
  for i:= 0 to scripts.Count-1 do begin
    removeLiteralStrings(scripts[i].source);
    removeComments(      scripts[i].source);

    // ** MOVED TO POST PROCESS **
    {if( project.settings.doCompress and
        project.settings.fineTunings.Whitespace)then
      removeWhitespace(scripts[i].source, project.settings.whiteSpaceRegExp); }
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.tokenize;
const
  vars = 'A-Za-z0-9_';
var
  contents,
  result   : string;
  PrevPos,
  tokenIndex,
  insertionPoint,
  i        : integer;
  r        : TRegExpr;
  token    : TJSCPMapToken;
begin
  for i:= 0 to scripts.Count-1 do begin
    contents := ' ' + scripts[i].source.text + ' ';
    Result   := '';
    PrevPos  := 1;

    r := TRegExpr.Create();
    with r do try        //stringtofile('c:\temp.txt',contents);
      Expression := '[^'+vars+'](['+vars+']+)[^'+vars+']';
      if Exec(contents) then repeat
        if (pos('_s_',match[1])<1) and
           (pos('_c_',match[1])<1) and
           (copy(contents,MatchPos[0],1)<>'\')and
           (not isInt(match[1]))
        then begin
          token := project.settings.maps.findKey(match[1], inputFilename);
          Result :=
            Result+
            Copy(contents, PrevPos,MatchPos[0]-PrevPos+1)+
            token.value;

          if(token.key = token.value)then begin // was not altered, ie found in UD map
            tokenIndex := CleanTokens.IndexOf(token.key, insertionPoint);
            if(tokenIndex = -1) then begin // not yet added
              cleanTokens.Insert(insertionPoint, TJSCPMapToken.create());
              tokenIndex := insertionPoint;
              CleanTokens[tokenIndex].assign(token);
              CleanTokens[tokenIndex].occurances := 1;
            end else begin // already added - increment occurance count
              inc(CleanTokens[tokenIndex].occurances);
            end;
          end else begin // was obfuscated
            tokenIndex := ObfuscatedTokens.IndexOf(token.key, insertionPoint);
            if(tokenIndex = -1) then begin // not yet added
              ObfuscatedTokens.Insert(insertionPoint, TJSCPMapToken.create());
              tokenIndex := insertionPoint;
              ObfuscatedTokens[tokenIndex].assign(token);
              ObfuscatedTokens[tokenIndex].occurances := 1;
            end else begin // already added - increment occurance count
              inc(ObfuscatedTokens[tokenIndex].occurances);
            end;
          end;

        end else
          result :=
            Result+
            Copy(contents, PrevPos,MatchPos[0]-PrevPos+MatchLen[0]-1);
        PrevPos := MatchPos[0] + MatchLen[0]-1;
      until not ExecPos(MatchPos[0] + MatchLen[0]-1); //ExecNext();
      Result := Result+Copy(contents,PrevPos,MaxInt);
    finally free(); end;
    scripts[i].source.text := trim(result);
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.postProcess;
var
  i,j : integer;
begin
  for i:= 0 to scripts.Count-1 do begin
    if(project.settings.doCompress and
       project.settings.fineTunings.CombineStrings)
      then
        combineLiteralStrings(scripts[i].source);

    if(project.settings.doCompress and
       project.settings.fineTunings.Whitespace)
      then
        removeWhitespace(scripts[i].source, project.settings.whiteSpaceRegExp);

    if(project.settings.doCompress and
       project.settings.fineTunings.Comments)
      then for j := 0 to comments.Count-1 do
        comments[j] := ''; // removes them
    restoreComments(scripts[i].source);

    restoreLiteralStrings(scripts[i].source);

    if(project.settings.doCompress and
       project.settings.fineTunings.ExtraSemicolons)
      then
        removeExtraSemicolons(scripts[i].source);

    if(project.settings.doPreamble) and
      (fileType = ftScript)         and
      (scripts[i].scriptType = stBlock)
    then
      scripts[i].source.text :=
        '/*' + br + project.settings.preamble_str + br + '*/' + br + scripts[i].source.text;
  end;
  if(project.settings.doPreamble) and (fileType = ftHTML)then
    fContent := '<!--' + br + trim(project.settings.preamble_str) + br + '-->' + br + br + fContent;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.setInputFilename(const Value: string);
var
  script : TJSCPScript;
  i, j   : integer;
  list   : tstrings;
  key    : string;
begin
  fInputFilename := Value;
  fContent       := fileToString(fInputFilename);
  scripts.Clear();
  if(TJSCPFileSetList(fileSet.collection).filesetType = ftCompress)then
    case fileType of
      ftScript : begin
        script             := scripts.Add();
        script.fileobj     := self;
        script.scriptType  := stBlock;
        script.source.text := fContent;
        fContent           := '_s_0_s_;';
      end;
      ftHTML: begin
        // always do blocks before inline
        parseOutScriptBlocks();
        parseOutHTMLAttributes();
      end;
    end;

  // now that we've parsed out all the scripts into objects, find out the base line numbers
  list := tstringlist.create();
  try
    // make a local copy of the parsed file
    list.Text := fContent;
    // search for each script block and record it's line number, inserting the block as we go
    for i := 0 to scripts.Count-1 do
      if(scripts[i].scriptType = stBlock)then begin
        key := '_s_' + inttostr(i) + '_s_;';
        for j := 0 to list.Count-1 do begin
          if(pos(key, list[j])> 0) then begin
            scripts[i].baseLineNumber := j;
            list.text := stringReplace(list.text, key, scripts[i].source.Text,[]);
            break;
          end;
        end;
      end;
    // now do the same for each inline script
    for i := 0 to scripts.Count-1 do
      if(scripts[i].scriptType = stInline)then begin
        key := '_s_' + inttostr(i) + '_s_;';
        for j := 0 to list.Count-1 do begin
          if(pos(key, list[j])> 0) then begin
            scripts[i].baseLineNumber := j;
            list.text := stringReplace(list.text, key, scripts[i].source.Text,[]);
            break;
          end;
        end;
      end;
  finally
    list.free();
  end;

  if(TJSCPFileSetList(fileSet.collection).filesetType = ftManage)then
    parseOutScriptTags(stSource);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.parseOutScriptBlocks;
var
  contents,
  result   : string;
  PrevPos  : integer;
  r        : TRegExpr;
begin
  contents := ' ' + fContent + ' ';
  Result   := '';
  PrevPos  := 1;

  r := TRegExpr.Create();
  try
    r.ModifierG  := false;
    r.Expression := '<script[^>]*>(.*)<\/script>';
    if r.Exec(contents) then repeat
      Result := Result +
                Copy(contents, PrevPos, r.MatchPos[1] - PrevPos) +
                '_s_' + inttostr(scripts.count) + '_s_;';
      PrevPos := r.MatchPos[1] + r.MatchLen[1];
      with scripts.Add() do begin
        fileObj     := self;
        scriptType  := stBlock;
        source.text := r.match[1];
      end;
    until not r.ExecPos(r.MatchPos[0] + r.MatchLen[0]);
    Result := Result + Copy(contents,PrevPos,MaxInt);
  finally r.free(); end;
  fContent := trim(result);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.parseOutHTMLAttributes;
const
  events =
    '(' +
    'onabort|onactivate|onafterprint|onafterupdate|onbeforeactivate|onbeforecopy|onbeforecut|' +
    'onbeforedeactivate|onbeforeeditfocus|onbeforepaste|onbeforeprint|onbeforeunload|' +
    'onbeforeupdateonbegin|onblur|onbounce|oncellchange|onchange|onclick|oncontextmenu|' +
    'oncontrolselect|oncopy|oncut|ondataavailable|ondatasetchanged|ondatasetcomplete|' +
    'ondblclick|ondeactivate|ondrag|ondragend|ondragenter|ondragleave|ondragover|ondragstart|' +
    'ondragdrop|ondrop|onend|onerror|onerrorupdate|onfilterchange|onfinish|' +
    'onfocus|onfocusin|onfocusout|onhelp|onkeydown|onkeypress|onkeyup|onlayoutcomplete|onload|' +
    'onlosecapture|onmousedown|onmouseenter|onmouseleave|onmousemove|onmouseout|onmouseover|' +
    'onmouseup|onmousewheel|onmove|onmoveend|onmovestart|onpaste|onpropertychange|' +
    'onreadystatechange|onrepeat|onreset|onresize|onresizeend|onresizestart|onrowenter|' +
    'onrowexit|onrowsdelete|onrowsinserted|onscroll|onselect|onselectionchange|' +
    'onselectstart|onstart|onstop|onsubmit|onunload|onzoom' +
    ')';
var
  contents,
  result   : string;
  PrevPos  : integer;
  r        : TRegExpr;
begin
  contents := ' ' + fContent + ' ';
  Result   := '';
  PrevPos  := 1;

  r := TRegExpr.Create();
  try
    r.ModifierG  := false;
    r.Expression := events + '\s*=\s*([''"])((\\"|\\''|.)*)\2';
    if r.Exec(contents) then repeat
      Result := Result +
                Copy(contents, PrevPos, r.MatchPos[3] - PrevPos) +
                '_s_' + inttostr(scripts.count) + '_s_;';
      PrevPos := r.MatchPos[3] + r.MatchLen[3];
      with scripts.Add() do begin
        fileObj     := self;
        scriptType  := stInline;
        source.text := r.match[3];
      end;
    until not r.ExecPos(r.MatchPos[0] + r.MatchLen[0]);
    Result := Result + Copy(contents,PrevPos,MaxInt);
  finally r.free(); end;
  fContent := trim(result);
end;

//------------------------------------------------------------------------------

function TJSCPFile.validate: boolean;
var
  P : TJSCPProject;
  i : integer;
  b : boolean;
begin
  result := true;
  if(not enabled)then exit;
  P := TJSCPFileList(Collection).project;
  fErrors.Clear();
  for i := 0 to scripts.Count-1 do begin
    b := P.validator.validate(
      scripts[i],
      P.settings.doAutoFixSemicolons,
      true,
      P.settings.fineTunings.Comments
    );
    if(not b)then result := false;
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.removeLiteralStrings(var list: tstrings);
  function escaped(const s:string; const i : integer):boolean;
  begin
     result :=
       (i>2) and
       (s[i-1] =  '\') and
       (s[i-2] <> '\');
  end;

var
  i,j,
  parenDepth : integer;
  inQuote,
  inEval,
  inRunon    : boolean;
  quoteChar,
  c          : string[1];
  literal,
  result     : string;
begin
  // TODO - when processing inline scripts, the quotes may be legitimately escaped.
  // need to treat \" and \' as though they were " and '
  // ONLY do this for inline scripts
  inEval     := false;
  inQuote    := false;
  inRunon    := false;
  parenDepth := 0;
  for i:=0 to list.Count-1 do begin
    list[i] := stringReplace(list[i],#9,'  ',[rfReplaceAll]);
    if(not inRunon)then inquote := false;
    for j:=1 to length(list[i]) do begin
      if(inRunon and (j > length(list[i]))) then continue;
      c := list[i][j];

      if(not inEval) and
        ((c = 'e') or (c = 's')) and
        ((copy(list[i], j, 4) = 'eval') or (copy(list[i], j, 10) = 'setTimeout') or (copy(list[i], j, 11) = 'setInterval')) and
        not inquote
      then begin
        inEval     := true;
        parenDepth := 0;
      end;
      if((inEval) and (c = '('))then inc(parenDepth);
      if((inEval) and (c = ')'))then begin
        dec(parenDepth);
        if(parenDepth = 0)then inEval := false;
      end;

      // If not already in a string, look for the start of one.
      if(not inEval)then begin
        if (not inQuote) then begin
          if (c = '"') or (c = '''') then begin
            inQuote   := true;
            quoteChar := c;
            literal   := '';
            result    := result + c;
            if(list[i][length(list[i])] = '\')then begin
              list[i] := copy(list[i], 1, length(list[i]) - 1);
              inRunon := true;
            end;
          end
          else
             result := result + c;
        end
        // Already in a string, look for end and copy characters.
        else begin
          if (c = quoteChar) and (not escaped(list[i],j)) then begin
            inQuote := false;
            inRunon := false;
            literal := literal;
            result  := result + '_s_' + inttostr(literalStrings.count) + '_s_' + quoteChar;
            literalStrings.add(literal);
          end;
          literal:=literal + c;
        end;
      end else result := result + c;
    end;

    if (inQuote and not inRunon) then result := result +literal; // we never found a matching set on this line, so put it back
    result:=result + #13#10;
  end;
  list.text := result;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.removeComments(var list:tstrings);
var
//  i, j,
  PrevPos : integer;
  result  : string;
begin
  Result:='';
   PrevPos:=1;
   with TRegExpr.Create do try
      //ModifierI:=false;
      ModifierM  := true;
      Expression := '\/\/[^\n]*$';
      if Exec(list.text) then repeat
         if(not project.settings.fineTunings.Comments) then begin
           Result:= Result+
                    Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+
                    '_c_' + inttostr(comments.count) + '_c_;';
           comments.Add(match[0]);
         end else begin
           Result:= Result + Copy(list.text, PrevPos, MatchPos[0]-PrevPos);
         end;
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      Result:=Result+Copy(list.text,PrevPos,MaxInt);
   finally free(); end;
   list.text := result;
   //-----
   Result:='';
   PrevPos:=1;
   with TRegExpr.Create do try
      ModifierG  := false;
      //ModifierM  := true;
      Expression := '(/\*.*\*/)';
      if Exec(list.Text) then repeat
         if(not project.settings.fineTunings.Comments) then begin
           Result:= Result+
                    Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+
                    '_c_' + inttostr(comments.count) + '_c_;';
           comments.Add(match[0]);
         end else begin
           Result := Result + Copy(list.text, PrevPos, MatchPos[0]-PrevPos);
         end;
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      Result := Result+Copy(list.text,PrevPos,MaxInt);
   finally free(); end;
   //-----
   list.text := result;
end;

//------------------------------------------------------------------------------

(*procedure TJSCPFile.removeWhitespace(var list:tstrings; RE: string);
var
  // PrevPos : integer;
   a       : integer;
   s,
   result  : string;
   RegExpr : TRegExpr;
begin
  Result:='';
  //PrevPos:=1;
  RegExpr := TRegExpr.Create();
  try
    RegExpr.ModifierI  := false;
    RegExpr.modifierM  := true;
    RegExpr.modifierG  := true;
    RegExpr.Expression := RE;
    {if Exec(list.text) then repeat
       Result:= Result+
                Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+' ';
       PrevPos := MatchPos[0] + MatchLen[0];
    until not ExecNext();
    Result:=Result+Copy(list.text,PrevPos,MaxInt);  }
    result := RegExpr.Replace(list.text,'');
  finally
    RegExpr.free();
  end;

  // Remove uneccessary white space around operators, braces and parenthices.
  for a:=1 to length(project.settings.punctMarks) do begin
    s := project.settings.punctMarks[a];
    if(pos(s,  project.settings.punctMarksAfter) > 0)then
      result := stringReplace(result, s + ' ', s, [rfReplaceAll]);
    if(pos(s, project.settings.punctMarksBefore) > 0)then
      result := stringReplace(result, ' ' + s, s, [rfReplaceAll]);
  end;
  list.text := trim(result);
end;     *)

procedure TJSCPFile.removeWhitespace(var list:tstrings; RE: string);
var
   PrevPos : integer;
   a       : integer;
   s,
   result  : string;
begin
  if(RE <> '[]+')then begin
    Result:='';
    PrevPos:=1;
    with TRegExpr.Create do try
      ModifierI  := false;
      Expression := RE;
      if Exec(list.text) then repeat
         Result:= Result+
                  Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+' ';
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      Result:=Result+Copy(list.text,PrevPos,MaxInt);
    finally free(); end;
  end else result := list.text;

  // Remove uneccessary white space around operators, braces and parenthices.
  // to guard against the sequence + ++, replace with non-visible ctrl character first

  result := stringReplace(result, ' ++', chr(7) + '++', [rfReplaceAll]);
  result := stringReplace(result, '++ ', '++' + chr(7), [rfReplaceAll]);

  result := stringReplace(result, ' --', chr(7) + '--', [rfReplaceAll]);
  result := stringReplace(result, '-- ', '--' + chr(7), [rfReplaceAll]);

  for a:=1 to length(project.settings.punctMarks) do begin
    s := project.settings.punctMarks[a];
    if(pos(s,  project.settings.punctMarksAfter) > 0)then
      result := stringReplace(result, s + ' ', s, [rfReplaceAll]);
    if(pos(s, project.settings.punctMarksBefore) > 0)then
      result := stringReplace(result, ' ' + s, s, [rfReplaceAll]);
  end;

  result := stringReplace(result, chr(7), ' ', [rfReplaceAll]);

  list.text := trim(result);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.saveToOutput;
var
  filename : string;
begin
  if(not enabled)then exit;
  filename := outputFilename;
  if(fileexists(filename))then begin
      SetFileReadOnlyStatus(filename,false);
      deleteFile(pchar(filename));
   end;
  forcedirectories(extractfilepath(filename));
  stringToFile(filename, content);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.combineLiteralStrings(var list: tstrings);
begin
  list.text := stringReplace(list.text, '"+"'  , '', [rfReplaceAll]);
  list.text := stringReplace(list.text, '''+''', '', [rfReplaceAll]);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.removeExtraSemicolons(var list: tstrings);
begin
  list.text := stringReplace(list.text,  ';}','}',  [rfReplaceAll]);
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.restoreLiteralStrings(var list: tstrings);
var
  prevpos : integer;
  result  : string;
begin      
  Result  := '';
  PrevPos := 1;
  with TRegExpr.Create do try
    ModifierI  := false;
    Expression := '_s_([\d]+)_s_';
    if Exec(list.text) then repeat
       Result := Result +
                 Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+
                 literalStrings[strtoint(Match[1])];
       PrevPos := MatchPos[0] + MatchLen[0];
    until not ExecNext();
    Result := Result + Copy(list.text, PrevPos,MaxInt);
  finally free(); end;
  list.text := result;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.restoreComments(var list: tstrings);
var
  prevpos : integer;
  result  : string;
begin
  if(project.settings.fineTunings.Comments) then exit; // nothing to do
  result  := '';
  PrevPos := 1;
  with TRegExpr.Create do try
    ModifierI  := false;
    Expression := '_c_([\d]+)_c_;';
    if Exec(list.text) then repeat
       result := result +
         Copy(list.text, PrevPos, MatchPos[0]-PrevPos)+
         comments[strtoint(Match[1])];
      // if(comments[strtoint(Match[1])] <> '')then result := result + #13#10;
       PrevPos := MatchPos[0] + MatchLen[0];
    until not ExecNext();
    result := result + Copy(list.text ,PrevPos, MaxInt);
  finally free(); end;
  list.text := result;
end;


//------------------------------------------------------------------------------

function TJSCPFile.getFileSet: TJSCPFileSet;
begin
  result := TJSCPFileSet(TJSCPFileList(collection).fOwner);
end;

//------------------------------------------------------------------------------

function TJSCPFile.getContent: string;
var
  i   : integer;
  key : string;
begin
  result := fContent;
  for i:= 0 to scripts.Count-1 do begin
    key := '_s_' + inttostr(i) + '_s_;';
    result := stringReplace(result, key, trim(scripts[i].source.Text), []);
  end;
end;

//------------------------------------------------------------------------------

function TJSCPFile.saveLog: string;
var
  i : integer;
begin
  result :=
    OpenTag( 'File') + br +
    FillTag( 'Type',           fileTypeToString(fileType)) + br +
    FillTag( 'Input',          inputFilename) + br +
    FillTag( 'Output',         outputFilename) + br +
    FillTag( 'InputSize',      inttostr(inputFileSize)) + br;
  case TJSCPFileSetList(fileSet.collection).filesetType of
    ftCompress: begin
        result := result +
          FillTag( 'Scripts',        inttostr(scripts.Count))        + br +
          FillTag( 'Comments',       inttostr(comments.Count))       + br +
          FillTag( 'StringLiterals', inttostr(literalStrings.Count)) + br +
          FillTag( 'OutputSize',     inttostr(outputFileSize))            + br +
          FillTag( 'Compression',    inttostr(compression)) + br +
          fErrors.saveLog() + br;
        if(project.settings.doObfuscate)then begin
          CleanTokens.Sort(tokenSortMethod);
          result := result + OpenTag('ClearedTokens') + br;
          for i := 0 to CleanTokens.Count -1 do
            result := result + CleanTokens[i].saveLog + br;
          result := result + CloseTag('ClearedTokens') + br;

          ObfuscatedTokens.Sort(tokenSortMethod);
          result := result + OpenTag('ObfuscatedTokens') + br;
          for i := 0 to ObfuscatedTokens.Count -1 do
            result := result + ObfuscatedTokens[i].saveLog + br;
          result := result + CloseTag('ObfuscatedTokens') + br;
        end;
      end;
    ftManage  : begin
        result := result + fScriptTags.saveLog();
//          FillTag( 'ScriptIncludes', inttostr(tagCount)) + br;
      end;
  end;

  result := result + CloseTag('File');
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.parseOutScriptTags(const sourceType:TSourceType);
var
  contents : tstrings;
  tag      : TJSCPScriptTag;
  i        : integer;
  regexp   : TRegExpr;
begin
  fScriptTags.Clear();
  contents := tstringlist.create();
  regexp   := TRegExpr.Create();
  try
    if(sourceType = stSource)then
      contents.LoadFromFile(inputFilename)
    else
      contents.LoadFromFile(outputFilename);
    regexp.ModifierI  := true;
    regexp.Expression := '\<script[^\>]*src\s*=\s*["'']([^\>]*)["'']\>';
    for i := 0 to contents.Count-1 do begin
      if(regexp.Exec(contents[i])) then repeat
        tag            := fScriptTags.add();
        tag.FileName   := regexp.match[1];
        tag.source     := regexp.match[0];
        tag.lineNumber := i + 1;
        if (fileset.hasPrefix(tag.FileName)) or (fileset.hasPostfix(tag.FileName,'.js')) then
          tag.tagType := ttCompressed
        else
          tag.tagType := ttNormal;
      until not regexp.ExecNext();
    end;
  finally
    contents.Free();
    regexp  .free();
  end;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getRelativeFilename: string;
begin
  result := fInputFilename;
  delete(result, 1, length(fileSet.inputFolder));
end;

//------------------------------------------------------------------------------

function TJSCPFile.getFilename: string;
begin
  result := extractfilename(fInputFilename);
end;

//------------------------------------------------------------------------------

function TJSCPFile.getCompressedTagCount: integer;
begin
  result := tagCount - normalTagCount;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getCompression: integer;
begin
  if(inputFileSize > 0)then
    result := 100-trunc((outputFileSize/inputFileSize)*100)
  else
    result := 0;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getTrueCompression: integer;
begin
  if(inputFileSize > 0)then
    result := 100-trunc((outputTrueFileSize/inputFileSize)*100)
  else
    result := 0;
end;

//------------------------------------------------------------------------------

function TJSCPFile.getOutputFileSize: integer;
begin
  result := getFileSize(outputFilename);
end;

//------------------------------------------------------------------------------

function TJSCPFile.getOutputTrueFileSize: integer;
begin
  if(fileexists(outputFilename))then
    result := getFileSize(outputFilename)
  else
    result := getFileSize(inputFilename);
end;

//------------------------------------------------------------------------------

function TJSCPFile.attrString: string;
begin
  result := '';
  if((attributes and faReadOnly) = faReadOnly) then result := result + 'R';
  if((attributes and faArchive)  = faArchive ) then result := result + 'A';
  if((attributes and faSysFile)  = faSysFile ) then result := result + 'S';
  if((attributes and faHidden)   = faHidden  ) then result := result + 'H';
end;

//------------------------------------------------------------------------------

function TJSCPFile.getIsCompressed: boolean;
begin
  result := false;
  case TJSCPFileSetList(fileSet.Collection).fileSetType of
    ftCompress : begin
      result := fileExists(outputFilename);
      if(result)then
        result := CompareDateTime(modified, GetFileAge(outputFilename) ) <= 0;
     end;
    ftManage : result := tagCount = CompressedTagCount;
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.update;
begin
  // causes the file to 'update' it's status and contents
  // used by the gui for updating the columns displayed in the listgrid
  // should never clear any errors or alter the results of a 'run'
  case fileType of
    ftScript : begin
      setInputFilename(inputfilename);
    end;
    ftHTML : begin
      setInputFilename(inputfilename);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFile.processTokensInEvals(var list: tstrings);
begin
  // we need to also tokenize any strings that appear in eval(), setInterval() and setTimeout
  
end;

//------------------------------------------------------------------------------

{ TJSCPFileValidator }

constructor TJSCPFileValidator.create;
begin
  inherited;
  fLines         := TStringlist.create();
  fOriginal      := TStringlist.create();
  literalStrings := TStringlist.create();
  comments       := TStringlist.Create();
end;

//------------------------------------------------------------------------------

destructor TJSCPFileValidator.destroy;
begin
  fLines        .Free();
  fOriginal     .free();
  literalStrings.Free();
  comments      .Free();
  inherited;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.moveBackOne:string;
begin
   result := #0;
   if(x=1)and(y=0) then exit;
   if (x>1) then x := x-1
   else begin
      y := y - 1;
      x := length(flines[y]);
   end;
   if(x>0) and (y>0)then result := flines[y][x]
   else result := '';
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.previousNonSpaceChar:string;
begin
   result := moveBackOne();
   while(result<>#0)do begin
      if (length(result) = 0) or (ord(result[1]) > 32) then exit;
      result := moveBackOne();
   end;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.previousToken(line:integer): string;
var
  i : integer;
  s : string;
begin
  result := '';
  if(line = 0)then exit;
  try
    while (line > -1) and (line < flines.count) do begin
      for i:= length(flines[line])downto 1 do begin
         s := flines[line][i];
         if(pos(s, symbols)>0)then exit;
         result := s + result;
      end;
      dec(line);
    end;
  except end;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.nextToken(line:integer): string;
var
  i : integer;
  s : string;
begin
  result := '';
  if(line = 0)then exit;
  try
    while (line > -1) and (line < flines.count) do begin
      for i:= 1 to length(flines[line]) do begin
         s := trim(flines[line][i]);
         if(pos(s, symbols)>0)then exit;
         result := result + s;
      end;
      inc(line);
    end;
  except end;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.previousSymbol(line:integer): string;
var
   i : integer;
   s : string;
begin
   result := #0;
   while (line > -1) do begin
      for i:= length(flines[line])downto 1 do begin
         s := flines[line][i];
         if(pos(s, symbols)>0)then begin
           result := s;
           exit;
         end;
      end;
      dec(line);
   end;
end;

//------------------------------------------------------------------------------

function  TJSCPFileValidator.nextNonSpaceChar(line:integer):string;
var
   i : integer;
   s : string;
begin
   result := #0;
   while (line < flines.Count) do begin
      for i:= 1 to length(flines[line])do begin
         s := flines[line][i];
         if(ord(s[1]) > 32) then begin
            result := s;
            exit;
         end;
      end;
      inc(line);
   end;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.getLine(const line:integer):string;
begin
   result := fOriginal[line-1];
end;

//------------------------------------------------------------------------------

procedure TJSCPFileValidator.replaceLiteralStrings;
  function escaped(const s:string; const i : integer):boolean;
  begin
     result :=
       (i>2) and
       (s[i-1] =  '\') and
       (s[i-2] <> '\');
  end;

var
   i,j         : integer;
   inQuote     : boolean;
   quoteChar,c : string[1];
   literal,
   line        : string;
begin
   for i:=0 to flines.Count-1 do begin
      flines[i] := stringReplace(flines[i],#9,'  ',[rfReplaceAll]);
      line := '';
      inQuote := false;
      for j := 1 to length(flines[i]) do begin
        c := flines[i][j];
        // If not already in a string, look for the start of one.
        if not inQuote then begin
          if (c = '"') or (c = '''') then begin
            inQuote   := true;
            quoteChar := c;
            literal   := '';
            line      := line + c;
          end
         else
           line := line + c;
        end
        // Already in a string, look for end and copy characters.
        else begin
          if (c = quoteChar) and (not escaped(flines[i],j)) then begin
            inQuote := false;
            literal :=literal ;
            line := line + '_s_' + inttostr(literalStrings.count) + '_s_' + quoteChar;
            literalStrings.add(literal);
          end;
          literal:=literal + c;
        end;
      end;

      if inQuote then line := line +literal; // we never found a matching set on this line, so put it back
      //result    := result + #13#10;
      flines[i] := line;
  { todo
   strings are not being maintained in this routine like they are in the crunch version }

   end;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileValidator.restoreLiteralStrings;
var
   prevpos : integer;
   s       : string;
begin 
   s       := '';
   PrevPos := 1;
   with TRegExpr.Create do try
      ModifierI  := false;
      Expression := '_s_([\d]+)_s_';
      if Exec(flines.text) then repeat
         s := s+
           Copy(flines.text, PrevPos, MatchPos[0]-PrevPos)+
           literalStrings[strtoint(Match[1])];
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      s := s + Copy(flines.text,PrevPos,MaxInt);
   finally free(); end;
   flines.text := s;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.restoreLiteralStrings(const sent: string): string;
var
   prevpos : integer;
   s       : string;
begin
   s       := '';
   PrevPos := 1;
   with TRegExpr.Create do try
      ModifierI  := false;
      Expression := '_s_([\d]+)_s_';
      if Exec(sent) then repeat
         s := s+
           Copy(sent, PrevPos, MatchPos[0]-PrevPos)+
           literalStrings[strtoint(Match[1])];
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      s := s + Copy(sent,PrevPos,MaxInt);
   finally free(); end;
   result := s;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileValidator.removeComments;
var
   PrevPos,
   linefeeds,
   i         : integer;
   Result    : string;
begin
   Result := '';
   PrevPos:=1;
   with TRegExpr.Create do try
      ModifierG  := false;
      Expression := '(/\*.*\*/)';
      if Exec(flines.text) then repeat
        linefeeds := CountChar(match[0], #13);
         Result:= Result+
                  Copy(flines.text, PrevPos, MatchPos[0]-PrevPos) +
                  '_c_' + inttostr(comments.count) + '_c_;';
         for i := 1 to linefeeds do
          result := result + #13;
         PrevPos := MatchPos[0] + MatchLen[0];
         comments.Add(match[0]);
      until not ExecNext();
      Result := Result+Copy(flines.text,PrevPos,MaxInt);
   finally free(); end;
   //-----
   flines.text := result;
   //-----
   Result:='';
   PrevPos:=1;
   with TRegExpr.Create do try
      //ModifierI:=false;
      ModifierM  := true;
      Expression := '\/\/[^\n]*$';
      if Exec(flines.text) then repeat
         Result:= Result+
                  Copy(flines.text, PrevPos, MatchPos[0]-PrevPos) +
                  '_c_' + inttostr(comments.count) + '_c_;';
         PrevPos := MatchPos[0] + MatchLen[0];
         comments.Add(match[0]);
      until not ExecNext();
      Result:=Result+Copy(flines.text,PrevPos,MaxInt);
   finally free(); end;
   flines.text := result;
end;

//------------------------------------------------------------------------------

procedure TJSCPFileValidator.restoreComments;
var
   prevpos : integer;
   s       : string;
   i       : integer;
begin
   s       := '';
   PrevPos := 1;
   with TRegExpr.Create do try
      ModifierI  := false;
      Expression := '_c_([\d]+)_c_;';
      if Exec(flines.text) then repeat
         s := s+
           Copy(flines.text, PrevPos, MatchPos[0]-PrevPos)+
           comments[strtoint(Match[1])];
         PrevPos := MatchPos[0] + MatchLen[0];
      until not ExecNext();
      s := s + Copy(flines.text,PrevPos,MaxInt);
   finally free(); end;
   flines.text := trim(s);
   for i := flines.Count-1 downto 0 do
     if(trim(flines[i]) = ';')then flines.Delete(i);
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.isFunctionEnd(const vx,vy:integer):boolean;
var
   char  : string;
   depth,
   i     : integer;
begin
   result := false;
   x := vx;  y := vy;
   depth := 0;
   char := moveBackOne();
   while(char<>#0)do begin
      if(char = '}') then depth := depth + 1;
      if(char = '{') then
         if(depth > 0) then depth := depth - 1
         else begin
            // we have now found the opening curly.. search for }
            if (previousNonSpaceChar() = '=') then begin
               result := true;
               exit;
            end else begin
               for i:= y downto 0 do
                  if(pos(')',flines[i])>0) then begin
                     result := pos('function',flines[i])>0;
//                     if not result then result := previousToken(i) = 'function';
                     exit;
                  end
            end;
            char := #0;
         end;
      char := moveBackOne();
   end;
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.validate(const aScript:TJSCPScript; const autofix, report, doRemoveComments : boolean):boolean;
const
  ok = ';,{|=(';
var
  i,j,
  errorIndex : integer;
  line,
  lineNoSpaces,
  lastChar,
  nextChar,
  lastToken,
  theNextToken : string;
  project    : TJSCPProject;
  error      : TJSCPErrorMessage;
begin
  project := TJSCPFileList(aScript.fileobj.Collection).project;

  fLines.assign(   aScript.source);
  fOriginal.Assign(fLines);

   result := true;

   replaceLiteralStrings();
   removeComments();

   for i := 0 to fLines.Count-1 do begin // loop file
      line := trim(fLines[i]);
      if (length(line)=0)     then continue;
      lastChar := line[length(line)];

      // check for common RegExp errors
      {if(project.settings.doObfuscate)then} begin
        lineNoSpaces := StringReplace(line, ' ', '', [rfReplaceAll]);
        if((pos('(/', lineNoSpaces) > 0) or
           (pos('=/', lineNoSpaces) > 0)) then begin
          errorIndex    := aScript.fileobj.fErrors.Add(TJSCPErrorMessage.Create());
          error         := aScript.fileobj.fErrors[errorIndex];
          error.msg     := 'Possible inline RegExp.';
          error.line    := restoreLiteralStrings(line);
          error.linenum := aScript.baseLineNumber + i + 1;
          error.fname   := aScript.fileobj.inputFilename;
          error.relativeFname := aScript.fileobj.relativeFilename;
//          error.script  := aScript;

          project.fErrors.Add(error);
          if(report) and (assigned(project.fOnValidatorError)) then
            project.fOnValidatorError(
              self,
              aScript.fileobj.inputFilename,
              'Possible inline RegExp.',
              restoreLiteralStrings(line),
              aScript.baseLineNumber + i + 1
            );
          if(project.fErrors.Count > maxValidationErrorsToReport)then begin
            errorIndex    := aScript.fileobj.fErrors.Add(TJSCPErrorMessage.Create());
            error         := aScript.fileobj.fErrors[errorIndex];
            error.msg     := 'Exceeded maximum error limit ('+inttostr(maxValidationErrorsToReport)+').';
            error.line    := restoreLiteralStrings(line);
            error.linenum := aScript.baseLineNumber + i + 1;
            error.fname   := aScript.fileobj.inputFilename;
            error.relativeFname := aScript.fileobj.relativeFilename;

            project.fErrors.Add(error);
            if(report) and (assigned(project.fOnValidatorError)) then
              project.fOnValidatorError(self,error.fname,error.msg,error.line,error.linenum);
            result := false;
            break;
          end;
        end;
      end;

      // check for missing semicolons
      if(lastChar = ';') or (lastChar = '')then continue;
      j := pos('//',line);
      if (j=1)                then continue;
      if (j>1)                then begin
         line     := trim(copy(line,1,j-1));
         if (length(line)=0)  then continue;
         lastChar := line[length(line)];
      end;

      if(copy(line,length(line)-3,4)='else')then continue;
      if (pos(lastChar,ok)>0) then continue;
      if (pos('for',line)>0)  then continue;
      nextChar     := nextNonSpaceChar(i+1);
      lastToken    := previousToken(i);
      if (nextChar = ')') or
         (nextChar = '}') or
         (nextChar = '{') or
         (nextChar = ';') or
         (nextChar = ']') or
         (nextChar = '+') or
         (lastChar = '{') or
         (lastChar = '(') or
         (lastChar = '[') or
         (lastChar = '&') or
         (lastChar = '|') or
         //(lastChar = '+') or
         //(lastChar = '-') or
         (lastChar = '=') or
         (lastChar = '*') or
         (lastChar = '/') or
         (lastChar = '\') then continue;
      if (lastChar = ')') and (allNestedParens(line)) then begin
         if (pos('if'    ,line)>0)or
            (pos('for'   ,line)>0)or
            (pos('with'  ,line)>0)or
            (pos('while' ,line)>0)or
            (pos('repeat',line)>0)or
            (lastToken = 'if'){or
            (nextChar <> #0)} then continue;
      end;
      if(lastToken = 'end') and (previousSymbol(i) = '@') then continue; // for @if @end

      if (lastChar = '+') then if(line[length(line)-1] <> '+')then continue; // ++, -- ok, no others
      if (lastChar = '-') then if(line[length(line)-1] <> '-')then continue;
      if (lastChar = '}') then begin
         if not isFunctionEnd(length(line),i) then continue;
      end;
      if(lastChar = ':')or(lastChar = '=')then continue;
      if((lastChar = '}') and (i = flines.Count-1)) then continue;
      if((lastChar = '}') and (pos('catch',line)>0)) then continue;

      if{(aScript.scriptType = stInline) and} (i = fLines.Count-1)then continue; // last line does not require semicolon is inline

      theNextToken := nextToken(i+1);
      if(theNextToken = 'catch') or (theNextToken = 'finally') then continue;

      errorIndex    := aScript.fileobj.fErrors.Add(TJSCPErrorMessage.Create());
      error         := aScript.fileobj.fErrors[errorIndex];
      error.msg     := 'Possible missing semicolon.';
      error.line    := restoreLiteralStrings(line);
      error.linenum := aScript.baseLineNumber + i + 1;
      error.fname   := aScript.fileobj.inputFilename;
      error.relativeFname := aScript.fileobj.relativeFilename;
//      error.script  := aScript;

      project.fErrors.Add(error);

      if(report) and (assigned(project.fOnValidatorError)) then
        project.fOnValidatorError(
          self,
          aScript.fileobj.inputFilename,
          'Possible missing semicolon.',
          restoreLiteralStrings(line),
          aScript.baseLineNumber + i + 1
        );
      if(project.fErrors.Count > maxValidationErrorsToReport)then begin
        errorIndex    := aScript.fileobj.fErrors.Add(TJSCPErrorMessage.Create());
        error         := aScript.fileobj.fErrors[errorIndex];
        error.msg     := 'Exceeded maximum error limit ('+inttostr(maxValidationErrorsToReport)+').';
        error.line    := restoreLiteralStrings(line);
        error.linenum := aScript.baseLineNumber + i + 1;
        error.fname   := aScript.fileobj.inputFilename;
        error.relativeFname := aScript.fileobj.relativeFilename;

        project.fErrors.Add(error);
        if(report) and (assigned(project.fOnValidatorError)) then
          project.fOnValidatorError(self,error.fname,error.msg,error.line,error.linenum);
        result := false;
        break;
      end;

      if(autofix)then begin
         fLines[i] := line + ';';
         continue;
      end;

      result := false;
   end;

   if(doRemoveComments)then
    for i := 0 to comments.Count-1 do
      comments[i] := '';  // replaces _c_0_c_ with blanks

   restoreComments();
   restoreLiteralStrings();
end;

//------------------------------------------------------------------------------

function TJSCPFileValidator.allNestedParens(const sent: string): boolean;
var
  i,
  depth,
  pairs : integer;
begin
  depth := 0;
  pairs := 0;
  for i := 1 to length(sent) do begin
    if(sent[i] = '(')then
      inc(depth);
    if(sent[i] = ')')then begin
      dec(depth);
      if(depth = 0)then begin
        inc(pairs);
        if(pairs > 1)then
          break;
      end;
    end;
  end;
  result := (pairs <= 1);
end;

//------------------------------------------------------------------------------

{ TJSCPErrorMessageList }

function TJSCPErrorMessageList.Add(AObject: TJSCPErrorMessage): integer;
begin
  Result := inherited Add(AObject);
end;

//------------------------------------------------------------------------------

function TJSCPErrorMessageList.GetItem(Index: Integer): TJSCPErrorMessage;
begin
  Result := TJSCPErrorMessage(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TJSCPErrorMessageList.saveLog: string;
var
  i : integer;
begin
  if(count = 0)then result := '<Errors />'
  else begin
    result := OpenTag('Errors') + br;
    for i := 0 to count-1 do
      result := result + items[i].saveLog() + br;
    result := result + CloseTag('Errors');
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPErrorMessageList.SetItem(Index: Integer; Value: TJSCPErrorMessage);
begin
  inherited Items[Index] := value;
end;

//------------------------------------------------------------------------------

{ TJSCPScriptList }

function TJSCPScriptList.Add(): TJSCPScript;
begin
  result := TJSCPScript(inherited Add);
end;

//------------------------------------------------------------------------------

function TJSCPScriptList.GetItem(Index: Integer): TJSCPScript;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TJSCPScript(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TJSCPScriptList.saveLog: string;
begin

end;

//------------------------------------------------------------------------------

procedure TJSCPScriptList.SetItem(Index: Integer; Value: TJSCPScript);
begin
  if ((Index >= 0) and (Index < Count)) then
    if (Value <> nil) then
      inherited Items[Index].Assign(Value)
    else
      inherited Items[Index].Free();
end;

//------------------------------------------------------------------------------

{ TJSCPScript }

constructor TJSCPScript.create(Collection: TCollection);
begin
  inherited;
  source := tstringlist.create();
end;

//------------------------------------------------------------------------------

destructor TJSCPScript.destroy;
begin
  source.free();
  inherited;
end;

//------------------------------------------------------------------------------

{ TJSCPMapToken }

procedure TJSCPMapToken.assign(aSource: TJSCPMapToken);
begin
  key   := aSource.key;
  value := aSource.value;
  map   := aSource.map;
end;

//------------------------------------------------------------------------------

constructor TJSCPMapToken.create;
begin
  inherited;
  fFiles := tstringlist.create();
end;

//------------------------------------------------------------------------------

destructor TJSCPMapToken.destroy;
begin
  fFiles.free();
  inherited;
end;

//------------------------------------------------------------------------------

function TJSCPMapToken.saveLog: string;
begin
  if(key = value)then
    result := '<Token key="' + key + '" occurances="' + inttostr(occurances) + '" map="'+extractfilename(map)+'" />'
  else
    result := '<Token key="' + key + '" value="' + value + '" occurances="' + inttostr(occurances) +'" />';
end;

//------------------------------------------------------------------------------

{ TJSCPScriptTagList }

function TJSCPScriptTagList.Add: TJSCPScriptTag;
begin
  result := TJSCPScriptTag(inherited Add);
end;

//------------------------------------------------------------------------------

function TJSCPScriptTagList.GetItem(Index: Integer): TJSCPScriptTag;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TJSCPScriptTag(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TJSCPScriptTagList.saveLog: string;
var
  i : integer;
begin
  if(count = 0)then result := '<ScriptTags />'
  else begin
    result := OpenTag('ScriptTags') + br;
    for i := 0 to count-1 do
      result := result + items[i].saveLog() + br;
    result := result + CloseTag('ScriptTags');
  end;
end;

//------------------------------------------------------------------------------

procedure TJSCPScriptTagList.SetItem(Index: Integer; Value: TJSCPScriptTag);
begin
  if ((Index >= 0) and (Index < Count)) then
    if (Value <> nil) then
      inherited Items[Index].Assign(Value)
    else
      inherited Items[Index].Free();
end;

//------------------------------------------------------------------------------

{ TJSCPErrorMessage }

function TJSCPErrorMessage.saveLog: string;
begin
  result := '<Error line="' + inttostr(linenum) + '" context="' + XmlEncode(line) + '" error="' + XmlEncode(msg) + '" />';
end;

//------------------------------------------------------------------------------

{ TJSCPScriptTag }

function TJSCPScriptTag.saveLog: string;
begin
  result := '<ScriptTag ' +
    'filename="'   + filename                 + '" ' +
    'linenumber="' + inttostr(linenumber)     + '" ' +
    'type="'       + tagTypeToString(tagType) + '" />';
end;

//------------------------------------------------------------------------------

end.
