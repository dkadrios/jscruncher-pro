unit orphanedTokens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PDJ_XPCS, PDJ_XPC, ExtCtrls, objects, Grids_ts, TSGrid,
  PDJ_XPPB, Menus, ActnPopupCtrl;

type
  TorphanedTokensDlg = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Shape37: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    grid: TtsGrid;
    Label2: TLabel;
    Shape4: TShape;
    ProgressBar: TPDJXPProgressBar;
    PopupActionBarEx1: TPopupActionBarEx;
    Deleteselectedtokens1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridCellLoaded(Sender: TObject; DataCol, DataRow: Integer;
      var Value: Variant);
    procedure PopupActionBarEx1Popup(Sender: TObject);
    procedure Deleteselectedtokens1Click(Sender: TObject);
  private
    function getFiles: TJSCPFileSet;
  private
    orphans,
    flatTokensUsed : TJSCPMapTokenList;
    function getProject: TJSCPProject;
    procedure makeFlatList;
    procedure findOrphans();
    property project : TJSCPProject read getProject;
    property files : TJSCPFileSet read getFiles;
  public
    { Public declarations }
  end;

var
  orphanedTokensDlg: TorphanedTokensDlg;

implementation

{$R *.dfm}

uses
  unit1;

{ TorphanedTokensDlg }

function TorphanedTokensDlg.getProject: TJSCPProject;
begin
  result := form1.sessionProject;
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.FormCreate(Sender: TObject);
begin
  orphans        := TJSCPMapTokenList.create();
  flatTokensUsed := TJSCPMapTokenList.create();
  makeFlatList();
  findOrphans();
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.FormDestroy(Sender: TObject);
begin
  orphans.free();
  flatTokensUsed.free();
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.findOrphans;
var
  i, j,
  insertionPoint,
  index : integer;
  key   : string;
  token : TJSCPMapToken;
  map   : TJSCPMap;
begin
  orphans.Clear();
  ProgressBar.position := 0;
  ProgressBar.Max      := project.settings.maps.Count;
  label2.Caption       := 'Searching for orphans...';
  application.ProcessMessages();
  for i:= 0 to project.settings.maps.Count-1 do begin
    map := project.settings.maps[i];
    if(map.enabled) and (not map.compressed) and (map.filename <> '') and (map <> project.settings.UDMap) then begin
      for j := 0 to map.items.Count-1 do begin
        key := map.items[j].key;
        index := flatTokensUsed.indexOf(key, insertionPoint);
        if(index < 0)then begin // token is an orphan
          index := orphans.indexOf(key, insertionPoint);
          if(index < 0)then begin // add the token to the orphan list
            token := TJSCPMapToken.create();
            token.key := key;
            token.map := map.filename;
            orphans.Insert(insertionPoint, token);
          end;
        end;
      end;
    end;
    progressbar.Position := i+1;
    application.ProcessMessages();
  end;
  orphans.Sort(tokenSortMethod);
  grid.rows            := orphans.Count;
  grid.RefreshData(roNone, rpNone);
  Label2.caption       := inttostr(orphans.count) + ' orphans';
  progressbar.Position := 0;
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.makeFlatList;
var
  i, j,
  insertionPoint,
  index : integer;
  token : TJSCPMapToken;
begin
  flatTokensUsed.clear();
  ProgressBar.position := 0;
  ProgressBar.Max      := files.items.Count;
  label2.Caption       := 'Building flat token list...';
  application.ProcessMessages();
  for i := 0 to files.items.Count-1 do begin
    for j := 0 to files.items[i].CleanTokens.Count-1 do begin
      index := flatTokensUsed.indexOf(files.items[i].CleanTokens[j].key, insertionPoint);
      if(index < 0)then begin // add the token to the flatlist
        token := TJSCPMapToken.create();
        token.key := files.items[i].CleanTokens[j].key;
        flatTokensUsed.Insert(insertionPoint, token);
      end;
    end;
    ProgressBar.Position := i+1;
    application.ProcessMessages();
  end;
  flatTokensUsed.Sort(tokenSortMethod);
  ProgressBar.Position := 0;
end;

//------------------------------------------------------------------------------

function TorphanedTokensDlg.getFiles: TJSCPFileSet;
begin
  result := project.filesToCompress[0];
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.gridCellLoaded(Sender: TObject; DataCol, DataRow: Integer; var Value: Variant);
var
  token : TJSCPMapToken;
begin
  token := orphans.Items[datarow - 1];
  case datacol of
    1 : value := token.key;
    2 : value := ExtractFileName(token.map);
  end;
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.PopupActionBarEx1Popup(Sender: TObject);
begin
  Deleteselectedtokens1.enabled := grid.SelectedRows.Count > 0;
end;

//------------------------------------------------------------------------------

procedure TorphanedTokensDlg.Deleteselectedtokens1Click(Sender: TObject);
var
  i, j        : integer;
  key,
  filename,
  mapsMissing : string;
  token       : TJSCPMapToken;
  map         : TJSCPMap;
begin
  playSound(stDrop);
  if (MessageDlg('Delete the selected token(s) from the map files?'#13#10#13#10+
               'Warning, this will alter the original map files on disk.',
               mtConfirmation, [mbYes,mbNo], 0) = mrNo) then begin
    playSound(stCancel);
    exit;
  end;
  mapsMissing := '';
  i := grid.SelectedRows.Last;
  while (i > 0) do begin
    token    := orphans.items[i-1];
    key      := token.key;
    filename := token.map;
    j        := project.settings.maps.findMapByFilename(filename);
    if(j > -1)then begin
      map := project.settings.maps[j];
      map.deleteKey(key);
      map.save();
      orphans.Delete(i-1);
    end else mapsMissing := mapsMissing + filename + #13#10;
    i        := grid.SelectedRows.Previous(i);
  end;

  grid.Rows := orphans.Count;
  grid.RefreshData(roNone, rpNone);
  if(mapsMissing <> '')then begin
    playSound(stError);
    MessageDlg('Error.  '+#13#10#13#10+'One or more map files could not be located on disk:'+
              #13#10 + mapsMissing, mtError, [mbOK], 0);
  end;
end;

//------------------------------------------------------------------------------

end.
