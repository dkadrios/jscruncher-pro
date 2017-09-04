program JSCrunch;

uses
  Forms,
  windows,
  dialogs,
  sysutils,
  DNA_INT,
  darin_file,
  Unit1 in 'Unit1.pas' {Form1},
  RegExpr in 'RegExpr.pas',
  About in 'About.pas' {AboutDlg},
  ShellCtrls in 'ShellCtrls.pas',
  environmentSettings in 'environmentSettings.pas' {environmentSettingsDlg},
  objects in 'objects.pas',
  mouseoverpanel in '..\..\..\Support_Units\darin\MouseOverPanel\mouseoverpanel.pas',
  settings in 'settings.pas',
  Dirscan in 'dirscan.pas',
  help in 'help.pas',
  confirmation in 'confirmation.pas' {ConfirmationDlg},
  editProject in 'editProject.pas' {editProjectDlg},
  backgroundTask in 'backgroundTask.pas' {backgroundTaskDlg},
  images in 'images.pas',
  AMHelper in '..\..\..\Support_Units\components\AMHelper.pas',
  TransformStartPage in 'TransformStartPage.pas',
  mapChooser in 'mapChooser.pas' {mapChooserDlg},
  editFileset in 'editFileset.pas' {editFilesetDlg},
  Protection in 'Protection.pas',
  Reactivate in 'Reactivate.pas' {FReactivate},
  Activate in 'Activate.pas' {FActivate},
  Activation_code in 'Activation_code.pas' {FActivation_code},
  requestEvalCode in 'requestEvalCode.pas' {requestEvalCodeDlg},
  splash in 'splash.pas' {splashDlg},
  orphanedTokens in 'orphanedTokens.pas' {orphanedTokensDlg},
  dlgSearchText in 'editor\dlgSearchText.pas' {TextSearchDialog},
  WebBrowserWithUI in '..\..\Support_Units\components\WebBrowserWithUI\WebBrowserWithUI.pas';

{$R *.res}

var
	err     : integer;
  Mutex	  : THandle;
  EndTick : cardinal;
  msg     : string;
begin
  Mutex := CreateMutex(nil, true, 'jscruncherpro');
  if (Mutex <> 0) and (GetLastError() = ERROR_ALREADY_EXISTS) then
    CloseHandle(Mutex)
  else begin
    Application.Initialize;
    Application.Title := 'JSCruncher Pro';
    Application.HelpFile := '';
    EndTick  := GetTickCount + 4000;
    splashDlg := TSplashDlg.Create(Application);
    splashDlg.show();
    splashDlg.update();
    application.ProcessMessages();
    {$I Include\DelphiCrcBegin.inc}
    //if(computerName = 'DARIN') then err := 0 else
      err := DNA_ProtectionOK_API;
    if (err <= 0) then begin
      Application.CreateForm(TForm1, Form1);
  while (GetTickCount < EndTick) do;
      splashDlg.hide();
      splashDlg.free();
      Application.Run;
    end;
    if(err > 0)then begin
      msg := '';
      case err of
        ERR_INVALID_PASSWORD       : msg := 'The password you provided is either blank, or has already been used.';
        ERR_EVAL_CODE_ALREADY_SENT : msg := 'You''ve already reqeusted an evaluation code.';
        ERR_CDM_HAS_EXPIRED        : msg := 'Activation has expired.';
        ERR_CODE_HAS_EXPIRED       : msg := 'Evaluation period has expired.'#13'You will need to purchase an activation key to continue using the product.';
        ERR_LOCKOUT                : msg := 'Activation code disabled due to abuse.';
        ERR_INVALID_CDM            : msg := ''; // DLL was altered, give NO clues to the damn hacker
      else
        if(err <> ERR_CANCELLED_BY_USER)then
          msg := 'Activation failed.'+#13+'Support code: '+inttostr(err);     
      end;
      if(msg <> '')then begin
        messageBeep(MB_ICONERROR);
        messageDlg(msg, mtError, [mbok], 0);
      end;
    end;
    {$I Include\DelphiCrcEnd.inc}
    CloseHandle(Mutex);
  end;
end.
