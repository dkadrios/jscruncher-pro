unit logObjects;

interface

uses
  classes, Contnrs, xml_lite, xmlStringManip, objects;

type
  TLogSortType = (
    stFileType,
    stFilename,
    stFilepath,
    stOutputSize,
    stCompression,
    stTokens,
    stErrors,
    stScripts,
    stComments,
    stStrings,
    stScriptTags
  );

  TLogProject          = class;
  TLogFileSet          = class;
  TLogFileSetList      = class;
  TLogFileList         = class;
  TLogFile             = class;
  TLogMapToken         = class;
  TLogMapTokenList     = class;
  TLogScriptTag        = class;
  TLogScriptTagList    = class;
  TLogErrorMessage     = class;
  TLogErrorMessageList = class;

  TLogProject = class(TObject)
   private
     fFilename,
     fConsumer,
     fVersion : string;
     fSettings : TJSCPProjectSettings;
   public
     filesToCompress,
     filesToManage    : TLogFileSetList;
     constructor create;
     destructor destroy; override;
     procedure clear;
     procedure load(const aFilename:string);
     property filename : string read fFilename write load;
     property consumer : string read fConsumer;
     property version  : string read fVersion;
     property settings : TJSCPProjectSettings read fSettings;
   end;

  TLogFileSetList = class(TCollection)
   protected
     fFlatFileList : TLogFilelist;
     fFlatMapTokenList : TLogMapTokenList;
     procedure setItem(index: integer; value: TLogFileSet);
     function  getItem(index: integer):TLogFileSet;
     procedure loadFromXML(const n:TjanXMLNode);
   public
     present     : boolean;
     filesetType : TFilesetType;
     property  Items[index: integer]: TLogFileSet read getItem write setItem; default;
     function  Add(): TLogFileSet;
     constructor create(ItemClass: TCollectionItemClass);
     destructor destroy; override;
     property flatFileList : TLogFilelist read fFlatFileList;
     property flatMapTokenList : TLogMapTokenList read fFlatMapTokenList;
     procedure clear();
   end;

  TLogFileSet = class(TCollectionItem)
   private
    function getFileSetList: TLogFileSetList;
   protected
     fMask : string;
     procedure loadFromXML(const n:TjanXMLNode);
   public
     folder,
     outputFolder          : string;
     includeSubDirectories,
     useCompressed         : boolean;
     items                 : TLogFileList;
     Constructor Create(Collection: TCollection); override;
     Destructor  Destroy;  override;
     property    mask :string read fMask;
     property    fileSetList : TLogFileSetList read getFileSetList;
   end;

  TLogFileList = class(TObjectList)
   protected
     fOwner   : TLogFileSet;
     fSortOn  : TLogSortType;
     fSortDir : TSortDir;
     procedure setItem(index: integer; value: TLogFile);
     function  getItem(index: integer):TLogFile;
   public
     property  Items[index: integer]: TLogFile read getItem write setItem; default;
     function  add(AObject: TLogFile): Integer;
     procedure sortOn(aSortOn : TLogSortType; aSortDir: TSortDir);
     property  SortFilesOn : TLogSortType read fSortOn;
     property  SortDir : TSortDir read fSortDir;
   end;

  TLogFile = class(TObject)
   private
     fOwner            : TLogFileList;
     fFileType         : TFileType;
     fCleanTokens,
     fObfuscatedTokens : TLogMapTokenList;
     fErrors           : TLogErrorMessageList;
     fScriptIncludes   : TLogScriptTagList;
     function getFileSet: TLogFileSet;
     function getFlatList: TLogFileList;
   protected
     fInputFilename,
     fOutputFilename  : string;
     procedure loadFromXML(const n:TjanXMLNode);
   public
     inputSize,
     outputSize,
     scripts,
     comments,
     stringLiterals,
     compression : integer;
     constructor create;
     destructor  destroy; override;
     property  fileType :TFileType read fFileType;
     property  fileSet : TLogFileSet read getFileSet;
     property  CleanTokens      : TLogMapTokenList read fCleanTokens;
     property  ObfuscatedTokens : TLogMapTokenList read fObfuscatedTokens;
     property  errors           : TLogErrorMessageList read fErrors;
     property  inputFilename    : string read fInputFilename;
     property  outputFilename   : string read fOutputFilename;
     property  fileList         : TLogFileList read fOwner;
     property  flatList         : TLogFileList read getFlatList;
     property  scriptIncludes   : TLogScriptTagList read fScriptIncludes;
   end;

  TLogMapToken = class(TObject)
   protected
     fFiles : TLogFileList;
     procedure loadFromXML(const n:TjanXMLNode);
   public
     key, value, map : string;
     occurances : integer;
     constructor create;
     destructor  destroy; override;
     property files: TLogFileList read fFiles;
   end;

  TLogMapTokenList = class(TObjectList)
   protected
     procedure setItem(index: integer; value: TLogMapToken);
     function  getItem(index: integer):TLogMapToken;
     procedure loadFromXML(const n:TjanXMLNode);
   public
     property  Items[index: integer]: TLogMapToken read getItem write setItem; default;
     function  add(AObject: TLogMapToken): Integer;
     function  addFlat(AObject: TLogMapToken; aFile :TLogFile): Integer;
     function  indexOf(aKey:string):integer; overload;
   end;

  TLogScriptTagList = class(TCollection)
   protected
     function  GetItem(    Index: Integer):TLogScriptTag;
     procedure SetItem(    Index: Integer; Value: TLogScriptTag);
     procedure loadFromXML(const n:TjanXMLNode);
   public
     function  Add: TLogScriptTag;
     property  Items[Index: Integer]: TLogScriptTag read GetItem write SetItem; default;
   end;

  TLogScriptTag = class(TCollectionItem)
   private
     fTagType: TScriptTagType;
   protected
     procedure loadFromXML(const n:TjanXMLNode);
   public
     lineNumber : integer;
     filename   : string;
     property tagType: TScriptTagType read fTagType;
   end;

  TLogErrorMessage = class(TCollectionItem)
   protected
     procedure loadFromXML(const n: TjanXMLNode);
   public
     msg,
     line    : string;
     linenum : integer;
   end;

  TLogErrorMessageList = class(TCollection)
   protected
     function  GetItem(    Index: Integer):TLogErrorMessage;
     procedure SetItem(    Index: Integer; Value: TLogErrorMessage);
     procedure loadFromXML(const n:TjanXMLNode);
   public
     function  Add: TLogErrorMessage;
     property  Items[Index: Integer]: TLogErrorMessage read GetItem write SetItem; default;
   end;

  function FileListSortCompare(Item1, Item2: Pointer): Integer;

implementation

uses
  sysutils, jclStrings, Math;

var
  fGlobalFileListSorting : TLogFileList;

//------------------------------------------------------------------------------

function stringToFileType(const aValue:string):TFileType;
begin
  result := ftUnknown;
  if(upperCase(aValue) = 'HTML'  )then result := ftHTML;
  if(upperCase(aValue) = 'SCRIPT')then result := ftScript;
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

//------------------------------------------------------------------------------

function FileListSortCompare(Item1, Item2: Pointer): Integer;
var
  aSortOn  : TLogSortType;
  aSortDir : TSortDir;
  f1, f2   : TLogFile;
begin
  f1 := TLogFile(item1);
  f2 := TLogFile(item2);
  aSortOn  := fGlobalFileListSorting.fSortOn;
  aSortDir := fGlobalFileListSorting.fSortDir;
  case aSortOn of
    stFileType : result := CompareText(fileTypeToString(f1.fileType), fileTypeToString(f2.fileType));
    stFilename : result := CompareText(extractfilename(f1.inputFilename), extractfilename(f2.inputFilename));
    stFilepath : result := CompareText(
      copy(extractfilepath(f1.inputFilename), length(f1.fileSet.folder)+2, length(f1.inputFilename)),
      copy(extractfilepath(f2.inputFilename), length(f2.fileSet.folder)+2, length(f2.inputFilename))
    );
    stOutputSize  : result := CompareValue(f1.outputSize,              f2.outputSize);
    stCompression : result := CompareValue(f1.compression,             f2.compression);
    stTokens      : result := CompareValue(f1.fObfuscatedTokens.Count, f2.fObfuscatedTokens.Count);
    stErrors      : result := CompareValue(f1.errors.count,            f2.errors.count);
    stScripts     : result := CompareValue(f1.scripts,                 f2.scripts);
    stComments    : result := CompareValue(f1.comments,                f2.comments);
    stStrings     : result := CompareValue(f1.stringLiterals,          f2.stringLiterals);
    stScriptTags  : result := CompareValue(f1.fScriptIncludes.Count,   f2.fScriptIncludes.Count);
  else result := 0;
  end;
  if(aSortDir = sdDesc)then begin
    if(result > 0)then result := -1
    else if(result < 0)then result := 1;
  end;
end;

//------------------------------------------------------------------------------

function FlatFileListSortCompare(Item1, Item2: Pointer): Integer;
var
  aSortOn  : TLogSortType;
  aSortDir : TSortDir;
  f1, f2   : TLogFile;
begin
  f1 := TLogFile(item1);
  f2 := TLogFile(item2);
  aSortOn  := f1.flatList.fSortOn;
  aSortDir := f1.flatList.fSortDir;
  case aSortOn of
    stFileType : result := CompareText(fileTypeToString(f1.fileType), fileTypeToString(f2.fileType));
    stFilename : result := CompareText(extractfilename(f1.inputFilename), extractfilename(f2.inputFilename));
    stFilepath : result := CompareText(
      copy(extractfilepath(f1.inputFilename), length(f1.fileSet.folder)+2, length(f1.inputFilename)),
      copy(extractfilepath(f2.inputFilename), length(f2.fileSet.folder)+2, length(f2.inputFilename))
    );
    stOutputSize  : result := CompareValue(f1.outputSize,              f2.outputSize);
    stCompression : result := CompareValue(f1.compression,             f2.compression);
    stTokens      : result := CompareValue(f1.fObfuscatedTokens.Count, f2.fObfuscatedTokens.Count);
    stErrors      : result := CompareValue(f1.errors.count,            f2.errors.count);
    stScripts     : result := CompareValue(f1.scripts,                 f2.scripts);
    stComments    : result := CompareValue(f1.comments,                f2.comments);
    stStrings     : result := CompareValue(f1.stringLiterals,          f2.stringLiterals);
  else result := 0;
  end;
  if(aSortDir = sdDesc)then begin
    if(result > 0)then result := -1
    else if(result < 0)then result := 1;
  end;
end;

//------------------------------------------------------------------------------

{ TLogProject }

procedure TLogProject.clear;
begin
  filesToCompress.clear();
  filesToManage  .clear();
end;

//------------------------------------------------------------------------------

constructor TLogProject.create;
begin
  inherited;
  filesToCompress := TLogFileSetList.Create(TLogFileSet);
  filesToManage   := TLogFileSetList.Create(TLogFileSet);
  fSettings       := TJSCPProjectSettings.Create('');
end;

//------------------------------------------------------------------------------

destructor TLogProject.destroy;
begin
  filesToCompress.free();
  filesToManage  .free();
  fSettings      .free();
  inherited;
end;

//------------------------------------------------------------------------------

procedure TLogProject.load(const aFilename: string);
var
  x     : TjanXMLTree;
  n, n2 : TjanXMLNode;
begin
  clear();
  fFilename := aFilename;
  x := TjanXMLTree.Create('tree',0,nil);
  try
    x.Text := fileToString(aFilename);
    x.ParseXML();
    n := x.findNamedNode('ProjectLog');
    if(n = nil) then exit;
    fConsumer := assertAttr(n, 'Consumer', 'unknown');
    fVersion  := assertAttr(n, 'Version',  'unknown');

    n2 := n.findNamedNode('Settings');
    if(n2 <> nil)then settings.loadFromXML(n2);

    n2 := n.findNamedNode('CompressionJob');
    filesToCompress.present := n2 <> nil;
    if(filesToCompress.present)then filesToCompress.loadFromXML(n2);

    n2 := n.findNamedNode('ManageJob');
    filesToManage.present := n2 <> nil;
    if(filesToManage.present)then filesToManage.loadFromXML(n2);
  finally
    x.Free();
  end;
end;

//------------------------------------------------------------------------------

{ TLogFileSetList }

function TLogFileSetList.Add: TLogFileSet;
begin
  result := TLogFileSet(inherited Add);
end;

//------------------------------------------------------------------------------

procedure TLogFileSetList.clear;
begin
  fFlatFileList    .Clear();
  fFlatMapTokenList.clear();
  inherited;
end;

//------------------------------------------------------------------------------

constructor TLogFileSetList.create(ItemClass: TCollectionItemClass);
begin
  inherited;
  fFlatFileList                 := TLogFilelist.create();
  fFlatFileList.OwnsObjects     := false;

  fFlatMapTokenList             := TLogMapTokenList.Create();
  fFlatMapTokenList.OwnsObjects := false;
end;

//------------------------------------------------------------------------------

destructor TLogFileSetList.destroy;
begin
  fFlatFileList    .free();
  fFlatMapTokenList.free();
  inherited;
end;

//------------------------------------------------------------------------------

function TLogFileSetList.getItem(index: integer): TLogFileSet;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TLogFileSet(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TLogFileSetList.loadFromXML(const n: TjanXMLNode);
var
  i : integer;
begin
  for i := 0 to n.Nodes.Count-1 do
    add.loadFromXML(n.nodes[i]);
end;

//------------------------------------------------------------------------------

procedure TLogFileSetList.setItem(index: integer; value: TLogFileSet);
begin
  if ((Index >= 0) and (Index < Count)) then
  if (Value <> nil) then
    inherited Items[Index].Assign(Value)
  else
    inherited Items[Index].Free;
end;

//------------------------------------------------------------------------------

{ TLogFileSet }

constructor TLogFileSet.Create(Collection: TCollection);
begin
  inherited;
  items             := TLogFileList.create();
  items.OwnsObjects := true;
  items.fOwner      := self;
end;

//------------------------------------------------------------------------------

destructor TLogFileSet.Destroy;
begin
  items.Free();
  inherited;
end;

//------------------------------------------------------------------------------

function TLogFileSet.getFileSetList: TLogFileSetList;
begin
  result := TLogFileSetList(collection);
end;

//------------------------------------------------------------------------------

procedure TLogFileSet.loadFromXML(const n: TjanXMLNode);
var
  n2   : TjanXMLNode;
  i, j : integer;
  item : TLogFile;
begin
  folder                := assert(n, 'Folder',       '');
  outputFolder          := assert(n, 'OutputFolder', '');
  fMask                 := assert(n, 'Mask',         '');
  includeSubDirectories := assert(n, 'IncludeSubDirectories', 'NO') = 'YES';
  useCompressed         := assert(n, 'UseCompressed',         'NO') = 'YES';
  n2 := n.findNamedNode('Files');
  if(n2 <> nil)then for i:= 0 to n2.Nodes.count-1 do begin
    item := TLogFile.create();
    item.loadFromXML(n2.nodes[i]);
    items.Add(item);
    fileSetList.fFlatFileList.add(item);
    for j := 0 to item.fObfuscatedTokens.Count-1 do
      fileSetList.fFlatMapTokenList.addFlat(item.fObfuscatedTokens.Items[j], item);
    item.fOwner := items;
  end;
end;

//------------------------------------------------------------------------------

{ TLogFileList }

function TLogFileList.Add(AObject: TLogFile): Integer;
begin
  AObject.fOwner := self;
  result := inherited Add(AObject);
end;

//------------------------------------------------------------------------------

function TLogFileList.getItem(index: integer): TLogFile;
begin
  Result := TLogFile(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TLogFileList.setItem(index: integer; value: TLogFile);
begin
  inherited Items[Index] := value;
end;

//------------------------------------------------------------------------------

procedure TLogFileList.sortOn(aSortOn: TLogSortType; aSortDir: TSortDir);
begin
  fGlobalFileListSorting := self;
  fSortOn  := aSortOn;
  fSortDir := aSortDir;
  self.sort(FileListSortCompare);
end;

//------------------------------------------------------------------------------

{ TLogFile }

constructor TLogFile.create;
begin
  inherited;
  fCleanTokens      := TLogMapTokenList.Create(true);
  fObfuscatedTokens := TLogMapTokenList.Create(true);
  fErrors           := TLogErrorMessageList.Create(TLogErrorMessage);
  fScriptIncludes   := TLogScriptTagList.Create(TLogScriptTag);
end;

//------------------------------------------------------------------------------

destructor TLogFile.destroy;
begin
  fCleanTokens     .Free();
  fObfuscatedTokens.Free();
  fErrors          .free();
  fScriptIncludes  .free();
  inherited;
end;

//------------------------------------------------------------------------------

function TLogFile.getFileSet: TLogFileSet;
begin
  if(fOwner <> nil)then
    result := TLogFileSet(TLogFileList(fOwner).fOwner)
  else result := nil;
end;

//------------------------------------------------------------------------------

function TLogFile.getFlatList: TLogFileList;
begin
  result := fOwner.fOwner.fileSetList.flatFileList;
end;

//------------------------------------------------------------------------------

procedure TLogFile.loadFromXML(const n: TjanXMLNode);
var
  n2 : TjanXMLNode;
begin
  fFileType       := stringToFileType(assert(n, 'Type', 'HTML'));
  fInputFilename  := assert(n, 'Input',          '');
  fOutputFilename := assert(n, 'Output',         '');
  inputSize       := assert(n, 'InputSize',      0);
  outputSize      := assert(n, 'OutputSize',     0);
  scripts         := assert(n, 'Scripts',        0);
  comments        := assert(n, 'Comments',       0);
  stringLiterals  := assert(n, 'StringLiterals', 0);
  compression     := assert(n, 'Compression',    0);
  n2 := n.findNamedNode('ClearedTokens');    if(n2 <> nil)then fCleanTokens.loadFromXML(n2);
  n2 := n.findNamedNode('ObfuscatedTokens'); if(n2 <> nil)then fObfuscatedTokens.loadFromXML(n2);
  n2 := n.findNamedNode('Errors');           if(n2 <> nil)then fErrors.loadFromXML(n2);
  n2 := n.findNamedNode('ScriptTags');       if(n2 <> nil)then fScriptIncludes.loadFromXML(n2);
end;

//------------------------------------------------------------------------------

{ TLogMapTokenList }

function TLogMapTokenList.add(AObject: TLogMapToken): Integer;
begin
  Result := inherited Add(AObject);
end;

//------------------------------------------------------------------------------

function TLogMapTokenList.addFlat(AObject: TLogMapToken; aFile :TLogFile): Integer;
var
  i : integer;
begin
  // search if we already have this key.
  // if we do, just merge the occurance counts
  for i:= 0 to Count-1 do
    if(items[i].key = aObject.key) then begin
      items[i].occurances := items[i].occurances + aObject.occurances;
      items[i].fFiles.add(aFile);
      result := -1;
      exit;
    end;
  // first occurance in the flat list
  aFile.fOwner := AObject.fFiles;
  AObject.fFiles.add(aFile);
  result := add(AObject);
end;

//------------------------------------------------------------------------------

function TLogMapTokenList.getItem(index: integer): TLogMapToken;
begin
  Result := TLogMapToken(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TLogMapTokenList.indexOf(aKey: string): integer;
begin
  for result := 0 to Count-1 do
    if(items[result].key = aKey)then
      exit;
  result := -1;
end;

//------------------------------------------------------------------------------

procedure TLogMapTokenList.loadFromXML(const n: TjanXMLNode);
var
  i     : integer;
  token : TLogMapToken;
begin
  for i := 0 to n.Nodes.count-1 do begin
    token := TLogMapToken.Create();
    token.loadFromXML(n.Nodes[i]);
    add(token);
  end;
end;

//------------------------------------------------------------------------------

procedure TLogMapTokenList.setItem(index: integer; value: TLogMapToken);
begin
  inherited Items[Index] := value;
end;

//------------------------------------------------------------------------------

{ TLogScriptTagList }

function TLogScriptTagList.Add: TLogScriptTag;
begin
  result := TLogScriptTag(inherited Add);
end;

//------------------------------------------------------------------------------

function TLogScriptTagList.GetItem(Index: Integer): TLogScriptTag;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TLogScriptTag(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TLogScriptTagList.loadFromXML(const n: TjanXMLNode);
var
  i : integer;
begin
  for i := 0 to n.Nodes.Count-1 do
    add.loadFromXML(n.nodes[i]);
end;

//------------------------------------------------------------------------------

procedure TLogScriptTagList.SetItem(Index: Integer; Value: TLogScriptTag);
begin
  if ((Index >= 0) and (Index < Count)) then
    if (Value <> nil) then
      inherited Items[Index].Assign(Value)
    else
      inherited Items[Index].Free();
end;

//------------------------------------------------------------------------------

{ TLogErrorMessageList }

function TLogErrorMessageList.Add: TLogErrorMessage;
begin
  result := TLogErrorMessage(inherited Add);
end;

//------------------------------------------------------------------------------

function TLogErrorMessageList.GetItem(Index: Integer): TLogErrorMessage;
begin
  result := nil;
  if ((Index >= 0) and (Index < Count)) then
    result := TLogErrorMessage(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

procedure TLogErrorMessageList.loadFromXML(const n: TjanXMLNode);
var
  i : integer;
begin
  for i:= 0 to n.Nodes.Count-1 do
    add().loadFromXML(n.Nodes[i]);
end;

//------------------------------------------------------------------------------

procedure TLogErrorMessageList.SetItem(Index: Integer; Value: TLogErrorMessage);
begin
  if ((Index >= 0) and (Index < Count)) then
    if (Value <> nil) then
      inherited Items[Index].Assign(Value)
    else
      inherited Items[Index].Free();
end;

//------------------------------------------------------------------------------

{ TLogMapToken }

constructor TLogMapToken.create;
begin
  inherited;
  fFiles := TLogFileList.Create();
  fFiles.OwnsObjects := false;
end;

//------------------------------------------------------------------------------

destructor TLogMapToken.destroy;
begin
  fFiles.Free();
  inherited;
end;

//------------------------------------------------------------------------------

procedure TLogMapToken.loadFromXML(const n: TjanXMLNode);
begin
  key        := assertAttr(n, 'key',        '');
  value      := assertAttr(n, 'value',      '');
  map        := assertAttr(n, 'map',        '');
  occurances := assertAttr(n, 'occurances', 0);
end;

//------------------------------------------------------------------------------

{ TLogErrorMessage }

procedure TLogErrorMessage.loadFromXML(const n: TjanXMLNode);
begin
  msg     := assertAttr(n, 'error',   '');
  line    := assertAttr(n, 'context', '');
  linenum := assertAttr(n, 'line',    0);
end;

//------------------------------------------------------------------------------

{ TLogScriptTag }

procedure TLogScriptTag.loadFromXML(const n: TjanXMLNode);
var
  s : string;
begin
  lineNumber := assertAttr(n, 'linenumber', 0);
  filename   := assertAttr(n, 'filename',   '');
  s          := assertAttr(n, 'type',       'Unknown');
  fTagType   := stringToTagType(s);
end;

//------------------------------------------------------------------------------

end.
