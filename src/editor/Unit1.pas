unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SynEdit, SynMemo, ToolWin, ActnMan, ActnCtrls,
  SynEditHighlighter, SynHighlighterJScript, ActnList, XPStyleActnCtrls,
  ImgList, ActnColorMaps, XPMan, StdCtrls, mxCustomControl, mxOutlookPanel,
  AMHelper;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    saveAction: TAction;
    exitAction: TAction;
    SynJScriptSyn1: TSynJScriptSyn;
    ActionToolBar1: TActionToolBar;
    Timer1: TTimer;
    XPManifest1: TXPManifest;
    XPColorMap1: TXPColorMap;
    mxOutlookPanel3: TmxOutlookPanel;
    lblStatus1: TLabel;
    Bevel8: TBevel;
    lblStatus2: TLabel;
    AMHelper: TActionManagerHelper;
    findFirstAction: TAction;
    findNextAction: TAction;
    ActionToolBar2: TActionToolBar;
    replaceAction: TAction;
    Panel1: TPanel;
    SynMemo1: TSynMemo;
    Shape19: TShape;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure Timer1Timer(Sender: TObject);
    procedure saveActionExecute(Sender: TObject);
    procedure exitActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SynMemo1StatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure findFirstActionExecute(Sender: TObject);
    procedure findNextActionExecute(Sender: TObject);
    procedure replaceActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure ShowSearchReplaceDialog(AReplace: boolean);
    procedure DoSearchReplaceText(AReplace, ABackwards: boolean);
    procedure loadSettings;
    procedure saveSettings;
  public
    { Public declarations }
    lineToGoto : integer;
    filename   : string;
    procedure GotoLineNumberInMemo(const i: integer);
    procedure OpenFile(const s:string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R ..\images\16x16.res}

uses
  images, dlgSearchText, dlgReplaceText, dlgConfirmReplace, registry, jclsysutils;

const
  RegKey = 'Software\Nebiru Software\JSCruncher Pro\Editor';

var
  gbSearchBackwards,
  gbSearchCaseSensitive,
  gbSearchFromCaret,
  gbSearchSelectionOnly,
  gbSearchTextAtCaret,
  gbSearchWholeWords,
  fSearchFromCaret     : boolean;

  gsSearchText,
  gsSearchTextHistory,
  gsReplaceText,
  gsReplaceTextHistory : string;

  StateForShow         : integer;

//------------------------------------------------------------------------------

procedure TForm1.loadSettings;
begin
  with TReginifile.create(RegKey) do try
    width        := readinteger('FORM', 'Width',       668);
    height       := readinteger('FORM', 'Height',      528);
    top          := readinteger('FORM', 'Top',         screen.height div 2-height div 2);
    left         := readinteger('FORM', 'Left',        screen.width  div 2-width  div 2);
    StateForShow := readinteger('FORM', 'WindowState', ord(wsNormal));
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
    writeinteger( 'FORM', 'WindowState', ord(WindowState));
  finally
    free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  saveAction.Enabled    := (SynMemo1.Modified) and (not SynMemo1.ReadOnly);
  replaceAction.Enabled := not SynMemo1.ReadOnly;
end;

//------------------------------------------------------------------------------

procedure TForm1.saveActionExecute(Sender: TObject);
begin
  SynMemo1.Lines.SaveToFile(filename);
  close();
end;

//------------------------------------------------------------------------------

procedure TForm1.exitActionExecute(Sender: TObject);
begin
  close();
end;

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

procedure TForm1.FormCreate(Sender: TObject);
  procedure I(A:TCustomAction; const N:string);
  begin
    A.ImageIndex := allImages.GetImageIndex(N);
    AMHelper.syncImageIndexes(A);
  end;

var
  aFilename  : string;
  j          : integer;
begin
  lblStatus2.Caption           := '';
  lineToGoto                   := -1;
  XPColorMap1.Color            := form1.Color;
  XPColorMap1.BtnSelectedColor := form1.Color;
  XPColorMap1.FontColor        := clblack;
  SynMemo1StatusChange(SynMemo1, [scAll]);
  if(ParamCount > 0)then begin
    aFilename := '';
    for j := 1 to paramcount do
      if(j = paramcount) and (isInt(paramStr(j))) then
        lineToGoto := strtoint(paramStr(j))
      else aFilename := aFilename + iff(j=1, '', ' ') + paramStr(j);

    if(fileexists(aFilename))then openFile(aFilename);
    if(lineToGoto > -1)      then GotoLineNumberInMemo(lineToGoto);
  end;
  ActionManager1.Images := allImages.il16;
  I(saveAction,      'SAVEAS');
  I(exitAction,      'EXIT');
  I(findFirstAction, 'FIND');
  I(findNextAction,  'FINDAGAIN');
  I(replaceAction,   'REPLACE');
end;

//------------------------------------------------------------------------------

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if(ConfirmReplaceDialog <> nil) then ConfirmReplaceDialog.Free();
  SaveSettings();
end;

//------------------------------------------------------------------------------

procedure TForm1.FormShow(Sender: TObject);
begin
  LoadSettings();
  WindowState := TWindowState(StateForShow);
  if(lineToGoto <> -1) then GotoLineNumberInMemo(lineToGoto);
end;

//------------------------------------------------------------------------------

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(key = VK_ESCAPE)then exitAction.Execute();
end;

//------------------------------------------------------------------------------

procedure TForm1.GotoLineNumberInMemo(const i: integer);
var
  P    : TPoint;
  ii   : integer;
  memo : TSynmemo;
begin
  memo := synmemo1;
  memo.Repaint();
  ii := i;
  while(trim(memo.lines[ii]) = '') and (ii>0) do inc(ii,-1);
  // synedit does not support scroll messages
  // hack line 5832 in synedit.pas to have ForceToMiddle be true
  // should probably subclass this at somepoint

  p.X := 1;
  p.Y := ii;
  memo.SelStart := memo.RowColToCharIndex(p);
  memo.TopLine := i-10;
end;

//------------------------------------------------------------------------------

procedure TForm1.OpenFile(const s: string);
begin
  caption           := Application.Title + ' - ' + s;
  SynMemo1.Lines.LoadFromFile(s);
  SynMemo1.Modified := false;

  if(FileIsReadonly(s))then begin
    SynMemo1.ReadOnly := true;
    caption := caption + ' (readonly)';
  end;
  lblStatus2.Caption := s;
  filename           := s;
  timer1.Enabled     := true;
end;

//------------------------------------------------------------------------------

procedure TForm1.SynMemo1StatusChange(Sender: TObject; Changes: TSynStatusChanges);
begin
  lblStatus1.Caption :=
    'Row: ' + inttostr(synMemo1.CaretY) + ' ' +
    'Col: ' + inttostr(synMemo1.CaretX);
end;

//------------------------------------------------------------------------------

procedure TForm1.findFirstActionExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

//------------------------------------------------------------------------------

procedure TForm1.findNextActionExecute(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, FALSE);
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowSearchReplaceDialog(AReplace: boolean);
var
   dlg    : TTextSearchDialog;
   editor : TSynMemo;
begin
  editor := SynMemo1;
  if(AReplace) and (editor.ReadOnly) then exit;
  //---------
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
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
      if(editor.SelAvail) and (editor.BlockBegin.Y = editor.BlockEnd.Y)
      then
        SearchText := editor.SelText
      else
        SearchText := editor.GetWordAtRowCol(editor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if(AReplace) then with dlg as TTextReplaceDialog do begin
      ReplaceText        := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if(ShowModal = mrOK) then begin
      gbSearchBackwards      := SearchBackwards;
      gbSearchCaseSensitive  := SearchCaseSensitive;
      gbSearchFromCaret      := SearchFromCursor;
      gbSearchSelectionOnly  := SearchInSelectionOnly;
      gbSearchWholeWords     := SearchWholeWords;
      gsSearchText           := SearchText;
      gsSearchTextHistory    := SearchTextHistory;
      if(AReplace) then with dlg as TTextReplaceDialog do begin
        gsReplaceText        := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      fSearchFromCaret := gbSearchFromCaret;
      if(gsSearchText <> '') then begin
        DoSearchReplaceText(AReplace, gbSearchBackwards);
        fSearchFromCaret       := TRUE;
        findNextAction.Enabled := true;
      end;
    end;
  finally
    dlg.Free();
  end;
end;

//------------------------------------------------------------------------------

procedure TForm1.DoSearchReplaceText(AReplace, ABackwards: boolean);
var
  Options : TSynSearchOptions;
  editor  : TSynMemo;
begin
  editor := SynMemo1;
  if(AReplace) then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if(ABackwards)            then Include(Options, ssoBackwards);
  if(gbSearchCaseSensitive) then Include(Options, ssoMatchCase);
  if(not fSearchFromCaret)  then Include(Options, ssoEntireScope);
  if(gbSearchSelectionOnly) then Include(Options, ssoSelectedOnly);
  if(gbSearchWholeWords)    then Include(Options, ssoWholeWord);
  if(editor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0) then begin
    MessageBeep(MB_ICONASTERISK);
    if(ssoBackwards in Options) then
      editor.BlockEnd   := editor.BlockBegin
    else
      editor.BlockBegin := editor.BlockEnd;
    editor.CaretXY := editor.BlockBegin;
  end;

  if(ConfirmReplaceDialog <> nil) then ConfirmReplaceDialog.Free();
end;

//------------------------------------------------------------------------------

procedure TForm1.replaceActionExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(TRUE);
end;

//------------------------------------------------------------------------------

end.
