unit Unit1;

interface

uses
  SysUtils, classes, objects;

function  parseInputParams : boolean;
function  version:string;
function  formatedVersion:string;
procedure copyLicenseFromGUIApp();

implementation

uses
  windows, darin_file, jclstrings;

//------------------------------------------------------------------------------

procedure copyLicenseFromGUIApp();
var
  root : string;
begin
  root := ExtractFilePath(paramstr(0)) + 'JSCrunch';
  if(fileexists(root + '32.BAK')) then deletefile(pchar(root + '32.BAK'));
  if(fileexists(root + '32.CDM')) then deletefile(pchar(root + '32.CDM'));

  if(fileexists(root + '.BAK')) then copyfile(pchar(root + '.BAK'), pchar(root + '32.BAK'), false);
  if(fileexists(root + '.CDM')) then copyfile(pchar(root + '.CDM'), pchar(root + '32.CDM'), false);
end;

//------------------------------------------------------------------------------

function version:string;
begin
  {$I Include\UserPolyBuffer.inc}
  result := GetVersionNumber(ExtractFilePath(paramstr(0)) + 'jscrunch.exe');
end;

//------------------------------------------------------------------------------

function formatedVersion:string;
var
  list : tstrings;
begin                         
  list := TStringList.create();
  try
    StrToStrings(version, '.', list, false);
    result := 'v' + list[0] + '.' + list[1] + ' build ' + list[3];
  finally
    list.free();
  end;
end;

//------------------------------------------------------------------------------

procedure dumpHelp;
begin
  {$I ..\Include\UserPolyBuffer.inc}
  writeln('');
  writeln('Usage: jscrunch32.exe [project]');
  writeln('');
  writeln(' Example:');
  writeln(' jscrunch32 c:\jscruncher pro\projects\myProject.jscp');
  writeln('');
  writeln('-------------------------------------------------------------');
  writeln('');
end;

//------------------------------------------------------------------------------

function parseInputParams : boolean;
var
  project   : TJSCPProject;
  aFilename : string;
  i         : integer;
begin
  result := false;
  if(ParamCount = 0)then begin
    dumpHelp();
    exit;
  end;

  aFilename := '';
  for i:= 1 to ParamCount do aFilename := aFilename + ParamStr(i);
  aFilename := trim(aFilename);

  if(aFilename = '') or (aFilename = '/h') or (aFilename = '/?') or (aFilename = '/help')then begin
    writeln('No project file specified!');
    writeln('');
    dumpHelp();
    exit;
  end;

  if(not fileexists(aFilename))then begin
    writeln('File not found!');
    writeln('');
    dumpHelp();
    exit;
  end;

  {$I ..\Include\DelphiCrcBegin.inc}
  try
    project := TJSCPProject.create(version(), ExtractFilePath(paramstr(0)));
    try
      project.loadFromXML(aFilename);
      result := project.run();
      writeln('');
      writeln('Done.');
    finally
       project.Free();
    end;
  except
    on e:exception do writeln('Error: ' + e.message);
  end;
  {$I ..\Include\DelphiCrcEnd.inc}
end;

//------------------------------------------------------------------------------

end.
