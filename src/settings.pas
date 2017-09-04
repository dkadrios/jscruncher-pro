unit settings;

interface

uses
  comctrls, windows, dialogs, classes, xml_lite, objects;

type
  TBackupType = (btOnlyOne, btAll);
  //--------------------------------
  TConfirmationType = (
    ctAddsToUserMap,
    ctCombineStrings,
    ctInputSameAsOutputWithPrefix,
    ctInputSameAsOutputWithoutPrefix,
    ctInputFolderMissing
  );
  TConfirmations = packed record
    addsToUserMap,
    combineStrings,
    inputSameAsOutputWithPrefix,
    inputSameAsOutputWithoutPrefix,
    inputFolderMissing : boolean;
  end;
  //--------------------------------
  TFormSettings = class(TObject)
    private
      {$IFDEF CONSOLE}{$ELSE}
      procedure SaveCoolBar( const cb:TCoolBar;const regkey:string;const Root:HKEY=HKEY_CURRENT_USER);
      procedure LoadCoolBar( const cb:TCoolBar;const regkey:string;const Root:HKEY=HKEY_CURRENT_USER);
      {$ENDIF}
    public
      {$IFDEF CONSOLE}{$ELSE}
      StateForShow                : integer;
      lastTabIndexInProjectEditor : string;
      {$ENDIF}
      LastFilesFolder,
      LastTagsFolder,
      LastFilesOutputFolder,
      LastTagsOutputFolder,
      LastFilesMask,
      LastTagsMask,
      backupFolder                : string;
      doReportSemicolons,
      doShowCompressionSettings,
      doCreateBackups,
      doShowBottombar,
      firstRun,
      doPlaySounds                : boolean;
      backupType                  : TBackupType;
      confirmations               : TConfirmations;
      Constructor Create;
      Destructor  Destroy;  override;
      procedure   SaveFormSettings;
      procedure   LoadFormSettings;
      procedure   loadMRU(var listOut:tstrings);
      procedure   saveMRU(const listIn:tstrings);
      {$IFDEF CONSOLE}{$ELSE}
      function    showConfirmation(const msg : string; const messageType : TMsgDlgType; const confirmationType:TConfirmationType):boolean;
      {$ENDIF}
  end;

implementation

uses
   {$IFDEF CONSOLE}{$ELSE}unit1, confirmation,controls,{$ENDIF} registry, sysutils, forms, jclstrings, darin_file, blowfish,
   jclfileutils, string_compression, XmlStringManip, HTTPApp;

const
   RegKey    = '\Software\Nebiru Software\JSCruncher Pro';
   MRURegKey = RegKey + '\MRU';
   mapKey    = 'eJwryTAsjs8sji/JSI3PNq6MT8svis8qTg4qzUvOSC0KKDIIjs81KYhPy8wxNgUAgb8QpQ==';

//------------------------------------------------------------------------------

function rootPath:string;
begin
  result := extractfilepath(paramstr(0));
end;

//------------------------------------------------------------------------------

constructor TFormSettings.Create;
var
  list     : tstrings;
  i        : integer;
  filename : string;
begin
  loadFormSettings();
  if(firstRun)then try
    // cleanup any crap from a previous install

    // delete obsolete folders
    if(directoryExists(rootPath() + 'database'))then deleteDirectory(rootPath() + 'database', false);
    if(directoryExists(rootPath() + 'profiles'))then deleteDirectory(rootPath() + 'profiles', false);

    // delete any old *.mapx files
    list := tstringlist.create();
    try
      BuildFileList(rootPath() + 'maps/*.mapx', faAnyFile, list);
      for i := 0 to list.count-1 do begin
        SetFileReadOnlyStatus(rootPath() + 'maps/' + list[i], false);
        deletefile(rootPath() + 'maps/' + list[i]);
      end;
    finally
      list.free();
    end;

    // if there are *.map files, rename them to *.jmap (if doens't already exist)
    list := tstringlist.create();
    try
      BuildFileList(rootPath() + 'maps/*.map', faAnyFile, list);
      for i := 0 to list.count-1 do begin
        filename := rootPath() + 'maps/' + list[i];
        if(not fileexists( ChangeFileExt(filename, '.jmap' )))then
          renameFile(filename, ChangeFileExt(filename, '.jmap' ));
      end;
    finally
      list.free();
    end;

    // delete registry
    with TRegistry.Create() do try
      RootKey := HKEY_CURRENT_USER;
      deleteKey(RegKey);
    finally
      free();
    end;

    firstRun := false;
    saveFormSettings(); // to save the firstRun change
    LoadFormSettings(); // to reload the correct defaults
  except
  end;
end;

//------------------------------------------------------------------------------

destructor TFormSettings.Destroy;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TFormSettings.SaveFormSettings;
{$IFDEF CONSOLE}{$ELSE}
var
  i    : integer;
  temp : tstrings;
{$ENDIF}
begin
  {$IFDEF CONSOLE}{$ELSE}
  with form1 do begin
    for i := 0 to componentCount-1 do
      if(components[i] is TCoolbar) then
        SaveCoolBar(Coolbar1,RegKey + '\' + components[i].name);

    with Treginifile.create(RegKey) do try
      Rootkey := HKEY_CURRENT_USER;
      writeinteger('FORM',   'ACTIVETAB',     SelectedTab);
      if windowstate=wsNormal then begin
        writeinteger('FORM', 'LEFT',   left);
        writeinteger('FORM', 'TOP',    top);
        writeinteger('FORM', 'WIDTH',  width);
        writeinteger('FORM', 'HEIGHT', height);
      end;
      writeBool(   'FORM',   'FIRSTRUN',      firstRun);
      writeinteger('FORM',   'WINDOWSTATE',   ord(WindowState));
      writeinteger('FORM',   'TREEWIDTH',     FileTree.Width);
      writeinteger('FORM',   'TREE2WIDTH',    TagTree.Width);
      writeinteger('FORM',   'BOTTOMBAR',     bottomBar.tag);

      writestring( 'FORM',   'LastFilesFolder',       LastFilesFolder);
      writestring( 'FORM',   'LastTagsFolder',        LastTagsFolder);
      writestring( 'FORM',   'LastFilesOutputFolder', LastFilesOutputFolder);
      writestring( 'FORM',   'LastTagsOutputFolder',  LastTagsOutputFolder);
      writestring( 'FORM',   'LastFilesMask',         LastFilesMask);
      writestring( 'FORM',   'LastTagsMask',          LastTagsMask);

      writestring('PROJECTEDIT', 'LASTPAGE', lastTabIndexInProjectEditor);

      writebool(   'FORM',   'SHOW_COMPRESSION_SETTINGS',    doShowCompressionSettings);
      writebool(   'FORM',   'DO_REPORT_MISSING_SEMICOLONS', doReportSemicolons);
      writebool(   'FORM',   'DO_PLAY_SOUNDS',               doPlaySounds);
      writestring( 'BACKUP', 'BACKUP_FOLDER', backupFolder);
      writebool(   'BACKUP', 'ENABLED',       doCreateBackups);
      writebool(   'BACKUP', 'SHOW_BOTTOM_BAR', doShowBottombar);
      writeinteger('BACKUP', 'TYPE',          ord(backupType));
      writebool(   'FORM',   'SHOW_WELCOME',  cbShowWelcomeScreen.checked);

      writeString( 'FORM',   'PROJECT_DIR',   saveProjectDialog.InitialDir);

      writebool(   'CONFIRMATIONS', 'ADDS_TO_USERMAP',                confirmations.addsToUserMap);
      writebool(   'CONFIRMATIONS', 'COMBINE_STRINGS',                confirmations.combineStrings);
      writebool(   'CONFIRMATIONS', 'INPUT_SAME_AS_OUTPUT',           confirmations.inputSameAsOutputWithPrefix);
      writebool(   'CONFIRMATIONS', 'INPUT_SAME_AS_OUTPUT_NO_PREFIX', confirmations.inputSameAsOutputWithoutPrefix);
      writebool(   'CONFIRMATIONS', 'INPUT_FOLDER_MISSING',           confirmations.inputFolderMissing);

      temp := tstringlist.create();
      try
        for i := 3 to lvFiles.Cols do // start from 3 to ignore image col
          temp.add(inttostr(lvFiles.Col[i].Width));
        writestring( 'FORM', 'LISTCOLS',  temp.CommaText);
        temp.clear();
        for i := 3 to lvTags.Cols do
          temp.add(inttostr(lvTags.Col[i].Width));
        writestring( 'FORM', 'LISTCOLS2',  temp.CommaText);
      finally
        temp.Free();
      end;
    finally free; end;
  end;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TFormSettings.LoadFormSettings;
{$IFDEF CONSOLE}{$ELSE}
var
  temp : tstrings;
  i    : integer;
{$ENDIF}
begin
  {$IFDEF CONSOLE}{$ELSE}
  for i := 0 to form1.componentCount-1 do
    if(form1.components[i] is TCoolbar) then
       LoadCoolBar(form1.Coolbar1,RegKey + '\' + form1.components[i].name);
  {$ENDIF}

  {$IFDEF CONSOLE}{$ELSE}
  with Treginifile.create(RegKey) do try
    with form1 do begin
      Rootkey := HKEY_CURRENT_USER;
      //selectedTab        := readinteger('FORM',    'ACTIVETAB',     filesPane);
      firstRun           := readBool(   'FORM',    'FIRSTRUN',      true);
      left               := readinteger('FORM',    'LEFT',          100);
      top                := readinteger('FORM',    'TOP',           100);
      width              := readinteger('FORM',    'WIDTH',         750);
      height             := readinteger('FORM',    'HEIGHT',        550);
      StateForShow       := readinteger('FORM',    'WINDOWSTATE',   ord(wsNormal));
      FileTree.Width     := readinteger('FORM',    'TREEWIDTH',     200);
      TagTree.Width      := readinteger('FORM',    'TREE2WIDTH',    200);
      PlainTextIn.Height := readinteger('FORM',    'PLAINHEIGHT',   130);

      LastFilesFolder       := readstring( 'FORM',   'LastFilesFolder',       appPath());
      LastTagsFolder        := readstring( 'FORM',   'LastTagsFolder',        appPath());
      LastFilesOutputFolder := readstring( 'FORM',   'LastFilesOutputFolder', rootPath() + 'output\');
      LastTagsOutputFolder  := readstring( 'FORM',   'LastTagsOutputFolder',  rootPath() + 'output\');
      LastFilesMask         := readstring( 'FORM',   'LastFilesMask',         '*.js');
      LastTagsMask          := readstring( 'FORM',   'LastTagsMask',          '*.htm');

      lastTabIndexInProjectEditor := readstring('PROJECTEDIT', 'LASTPAGE', 'basic');

      bottomBar.tag      := readinteger('FORM',    'BOTTOMBAR',     170);
      doShowCompressionSettings:= readbool('FORM', 'SHOW_COMPRESSION_SETTINGS',    true);
      doReportSemicolons := readbool(   'FORM',    'DO_REPORT_MISSING_SEMICOLONS', true);
      doPlaySounds       := readbool(   'FORM',    'DO_PLAY_SOUNDS',               true);
      backupFolder       := readstring( 'BACKUP',  'BACKUP_FOLDER', appPath() + 'backup\');
      doCreateBackups    := readbool(   'BACKUP',  'ENABLED',       true);
      doShowBottombar    := readbool(   'BACKUP',  'SHOW_BOTTOM_BAR', false);
      backupType         := TBackupType(readinteger('BACKUP', 'TYPE',          0));
      cbShowWelcomeScreen.checked := readBool('FORM',   'SHOW_WELCOME',  true);

      openProjectDialog.InitialDir := readString('FORM', 'PROJECT_DIR', rootPath() + 'projects');
      saveProjectDialog.InitialDir := openProjectDialog.InitialDir;

      confirmations.addsToUserMap                  := readbool( 'CONFIRMATIONS', 'ADDS_TO_USERMAP',                true);
      confirmations.combineStrings                 := readbool( 'CONFIRMATIONS', 'COMBINE_STRINGS',                true);
      confirmations.inputSameAsOutputWithPrefix    := readbool( 'CONFIRMATIONS', 'INPUT_SAME_AS_OUTPUT',           true);
      confirmations.inputSameAsOutputWithoutPrefix := readbool( 'CONFIRMATIONS', 'INPUT_SAME_AS_OUTPUT_NO_PREFIX', true);
      confirmations.inputFolderMissing             := readbool( 'CONFIRMATIONS', 'INPUT_FOLDER_MISSING',           true);

      if bottomBar.tag > (nb1.Height - 40) then bottomBar.tag := (nb1.Height - 40);
      bottomBar.Height   := bottomBar.tag;

      temp := tstringlist.create();
      try
        temp.CommaText:=readstring( 'FORM','LISTCOLS', '150,70,60,130,70,70,40');
        for i:=0 to temp.Count-1 do
          if(lvFiles.Cols > i+2)then
            lvFiles.Col[i+3].Width := strtoint(temp[i]);

        temp.CommaText:=readstring( 'FORM','LISTCOLS2','150,60,70,70,60,130,40');
        for i:=0 to temp.Count-1 do
          if(lvTags.Cols > i+2)then
            lvTags.Col[i+3].Width := strtoint(temp[i]);
      finally
        temp.free();
      end;

      if(not DirectoryExists(LastFilesFolder))then LastFilesFolder := appPath();
      if(not DirectoryExists(LastTagsFolder)) then LastTagsFolder  := appPath();
      if(not DirectoryExists(backupFolder))   then backupFolder    := appPath()+'backup\';

      //if (PageControl1.ActivePageIndex<0) or (PageControl1.ActivePageIndex>2) then PageControl1.ActivePageIndex:=0;
      if height<280 then PlainTextIn.Height:=trunc(height*0.4);
    end;
  finally free; end;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

{$IFDEF CONSOLE}{$ELSE}
procedure TFormSettings.SaveCoolBar(const cb:TCoolBar;const regkey:string;const Root:HKEY=HKEY_CURRENT_USER);
var
   i     : Integer;
   IdStr : String;
begin
   with TReginifile.create(regkey) do try
      RootKey := Root;
      with cb, Bands do begin
         for i := 0 to Count-1 do with Bands[i] do begin
            IdStr      := IntToStr( Id );
            EraseSection( IdStr );
            writebool(    IdStr, 'Break', Break );
            WriteInteger( IdStr, 'Width', Width );
            WriteInteger( IdStr, 'Index', Index );
         end;
      end;
   finally free() end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF CONSOLE}{$ELSE}
procedure TFormSettings.LoadCoolBar(const cb:TCoolBar;const regkey:string;const Root:HKEY=HKEY_CURRENT_USER);
var
   i     : Integer;
   band  : TCoolBand;
   IdStr : String;
begin
   with TReginifile.create(regkey) do try
      RootKey := Root;
      with cb, Bands do begin
         for i := 0 to Count-1 do begin
            band := TCoolband(Bands.FindItemID(i));
            if band = nil then Continue;
            with band do begin
               IdStr := IntToStr(    Id );
               Break := ReadBool(    IdStr, 'Break', Break );
               Width := ReadInteger( IdStr, 'Width', Width );
               Index := ReadInteger( IdStr, 'Index', Index );
            end;
         end;
      end;
   finally free() end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TFormSettings.loadMRU(var listOut:tstrings);
var
  list : tstrings;
  i    : integer;
begin
  list := tstringlist.create();
  try
    with TRegistry.Create() do try
      RootKey := HKEY_CURRENT_USER;
      openkey(MRURegkey, true);
      GetValueNames(list);
      for i := 0 to list.count-1 do
        if(readstring(list[i]) <> '') then
          listOut.add(readstring(list[i]));
    finally
      free();
    end;
  finally
    list.free();
  end;
end;

//------------------------------------------------------------------------------

procedure TFormSettings.saveMRU(const listIn:tstrings);
var
  i : integer;
begin
  with TRegistry.Create() do try
    RootKey := HKEY_CURRENT_USER;
    deleteKey(MRURegkey);
    openkey(MRURegkey, true);
    for i := 0 to listIn.count-1 do begin
      if(trim(listIn[i]) <> '') then
        WriteString(chr(65+i), trim(listIn[i]));
    end;
  finally
    free();
  end;
end;


//------------------------------------------------------------------------------

{$IFDEF CONSOLE}{$ELSE}
function TFormSettings.showConfirmation(const msg: string; const messageType: TMsgDlgType; const confirmationType:TConfirmationType): boolean;
var
  b : boolean;
begin
  result := false;
  b := false;
  case confirmationType of
    ctAddsToUserMap                  : b := confirmations.addsToUserMap;
    ctCombineStrings                 : b := confirmations.combineStrings;
    ctInputSameAsOutputWithPrefix    : b := confirmations.inputSameAsOutputWithPrefix;
    ctInputSameAsOutputWithoutPrefix : b := confirmations.inputSameAsOutputWithoutPrefix;
    ctInputFolderMissing             : b := confirmations.inputFolderMissing;
  end;
  if(not b)then begin
    result := true;
    exit;
  end;

  ConfirmationDlg := TConfirmationDlg.create(form1);
  try
    ConfirmationDlg.label1.Caption := msg;

    case messageType of
      mtInformation :  begin
        ConfirmationDlg.width           := 295;
        ConfirmationDlg.Button1.caption := 'OK';
        ConfirmationDlg.caption         := 'Information';
      end;

      mtConfirmation : begin
        ConfirmationDlg.width           := 380;
        ConfirmationDlg.Button1.caption := '&Yes';
        ConfirmationDlg.caption         := 'Confirmation';
      end;
    end;

    ConfirmationDlg.showmodal();
    b := ConfirmationDlg.checkbox1.Checked;

    case messageType of
      mtInformation  : result := b;
      mtConfirmation : result := ConfirmationDlg.modalResult = mrOk;
    end;
    case confirmationType of
      ctAddsToUserMap                  : confirmations.addsToUserMap                  := b;
      ctCombineStrings                 : confirmations.combineStrings                 := b;
      ctInputSameAsOutputWithPrefix    : confirmations.inputSameAsOutputWithPrefix    := b;
      ctInputSameAsOutputWithoutPrefix : confirmations.inputSameAsOutputWithoutPrefix := b;
      ctInputFolderMissing             : confirmations.inputFolderMissing             := b;
    end;
  finally
    ConfirmationDlg.free();
    SaveFormSettings();
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

end.
