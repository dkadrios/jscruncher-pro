unit Unit1;

interface

procedure compileRC(const pathin, mask, pathout, fileout:string);

implementation

uses
  sysutils, jclfileutils, classes, windows, forms, messages;

//------------------------------------------------------------------------------

function cleanRSName(const s:string):string;
var i : integer;
begin
  result := stringReplace(uppercase(extractFileName(s)), ' ', '_', [rfReplaceAll]);
  i := pos('.', result);
  if(i > 0)then delete(result, i, length(result));
  result := 'JSCP_' + result;
end;

//------------------------------------------------------------------------------

function buildTempFile(const pathin, mask, pathout:string):string;
var
  list  : tstrings;
  i     : integer;
  fname : string;
begin
  list := tstringlist.create();
  try
    buildFileList(pathin + mask, faAnyFile, list);
    // format rows
    for i := 0 to list.count-1 do begin
      fname := list[i];
      list[i] :=
        cleanRSName(fname) + ' ' +
        'Bitmap '+
        '"' + pathin + fname + '"';
    end;
    result := pathout + inttohex(gettickcount, 8) + '.rc';
    list.saveToFile(result);
  finally
    list.free();
  end;
end;

//------------------------------------------------------------------------------

{-- WinExecAndWait32V2 ------------------------------------------------}
{: Executes a program and waits for it to terminate
@Param FileName contains executable + any parameters
@Param Visibility is one of the ShowWindow options, e.g. SW_SHOWNORMAL
@Returns -1 in case of error, otherwise the programs exit code
@Desc In case of error SysErrorMessage( GetlastError ) will return an
  error message. The routine will process paint messages and messages
  send from other threads while it waits.
}{ Created 27.10.2000 by P. Below
-----------------------------------------------------------------------}
Function WinExecAndWait32V2( FileName: String; Visibility: integer ):
DWORD;
  Procedure WaitFor( processHandle: THandle );
    Var
      msg: TMsg;
      ret: DWORD;
    Begin
      Repeat
        ret := MsgWaitForMultipleObjects(
                 1,             { 1 handle to wait on }
                 processHandle, { the handle }
                 False,         { wake on any event }
                 INFINITE,      { wait without timeout }
                 QS_PAINT or    { wake on paint messages }
                 QS_SENDMESSAGE { or messages from other threads }
                 );
        If ret = WAIT_FAILED Then Exit; { can do little here }
        If ret = (WAIT_OBJECT_0 + 1) Then Begin
          { Woke on a message, process paint messages only. Calling
            PeekMessage gets messages send from other threads processed.
}
          While PeekMessage( msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE ) Do
            DispatchMessage( msg );
        End;
      Until ret = WAIT_OBJECT_0;
    End; { Waitfor }
Var  { V1 by Pat Ritchey, V2 by P.Below }
  zAppName:array[0..512] of char;
  StartupInfo:TStartupInfo;
  ProcessInfo:TProcessInformation;
Begin { WinExecAndWait32V2 }
  StrPCopy(zAppName,FileName);
  FillChar(StartupInfo,Sizeof(StartupInfo),#0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  If not CreateProcess(nil,
    zAppName,             { pointer to command line string }
    nil,                  { pointer to process security attributes }
    nil,                  { pointer to thread security attributes }
    false,                { handle inheritance flag }
   // CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil,                  { pointer to new environment block }
    nil,                  { pointer to current directory name }
    StartupInfo,          { pointer to STARTUPINFO }
    ProcessInfo)          { pointer to PROCESS_INF }
  Then
    Result := DWORD(-1)   { failed, GetLastError has error code }
  Else Begin
     Waitfor(ProcessInfo.hProcess);
     GetExitCodeProcess(ProcessInfo.hProcess, Result);
     CloseHandle( ProcessInfo.hProcess );
     CloseHandle( ProcessInfo.hThread );
  End; { Else }
End; { WinExecAndWait32V2 }

//------------------------------------------------------------------------------

procedure compileRC(const pathin, mask, pathout, fileout:string);
var
  fname,
  params : string;
  i      : integer;
begin
  for i := 1 to ParamCount do
    params := params + ' ' + ParamStr(i);

  fname := buildTempFile(pathin, mask, pathout);
  WinExecAndWait32V2('BRCC32.EXE ' + fname + params, SW_HIDE);
  sleep(1000);

  if(fileexists(fname  )) then deletefile(pchar(fname  ));
  if(fileexists(fileout)) then deleteFile(pchar(fileout));

  fname := ChangeFileExt(fname, '.res');
  if(fileexists(fname))then renamefile(fname, fileout);
end;

//------------------------------------------------------------------------------

end.
 