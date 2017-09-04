program jscrunch32;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  types,
  darin_file,
  darin_md5,
  Unit1 in 'Unit1.pas',
  Protection_inc in '..\Protection_inc.pas',
  Protection in '..\Protection.pas',
  DNA_INT in '..\..\..\Support_Units\dna\DNA_INT.pas'
  ;

function EnvelopeCheck: Boolean;
{$I ..\Include\DelphiEnvelopeCheckFunc.inc}

var
  daysLeft,
  err     : integer;
  s       : string;
  msg     : array[0..127] of char;
  expires : tdatetime;
begin
  if(not EnvelopeCheck()) and (getfilesize(paramstr(0)) < 700) then halt;

  copyLicenseFromGUIApp();

  {$I ..\Include\DelphiCrcBegin.inc}
  if( getFileMD5(EXEPATH + 'DNA.dll') <> unShuffledMD5() )
  	then err := ERR_INVALID_CDM
  else
    err := DNA_Validate(pchar(ProductKey));
  {$I ..\Include\DelphiCrcEnd.inc}
  
  if (err <> 0) and (err <> -1) then begin
    writeln('');
    writeln('-------------------------------------------------------------');
    writeln('JSCruncher Pro ' + formatedVersion());
    writeln('Copyright (c) 2001, 2007 Nebiru Software. All rights reserved.');
    writeln('-------------------------------------------------------------');
    writeln('Evaluation period has expired or product not activated.');
    writeln('Please register at http://nebiru.com/jscruncherpro to continue');
    writeln('using this product.');
    writeln('-------------------------------------------------------------');
    halt;
  end;

  DNA_Param('EVAL_CODE', msg, sizeof(msg));
  if(msg = '1')then begin // evaluation
    DNA_Param('EXPIRY_DATE', msg, sizeof(msg));
    expires := StrToDate(msg);
    daysLeft := trunc(expires - now) + 1;
    s := ' day';
    if(daysLeft > 1)then s := s + 's';
    writeln('');
    writeln('-------------------------------------------------------------');
    writeln('JSCruncher Pro ' + formatedVersion());
    writeln('Copyright (c) 2001, 2007 Nebiru Software. All rights reserved.');
    writeln('-------------------------------------------------------------');
    writeln(' - EVALUATION - ' +  inttostr(daysLeft) + s + ' left');
    writeln('-------------------------------------------------------------');
  end else begin
    writeln('');
    writeln('-------------------------------------------------------------');
    writeln('JSCruncher Pro ' + formatedVersion());
    writeln('Copyright (c) 2001, 2007 Nebiru Software. All rights reserved.');
    writeln('-------------------------------------------------------------');
  end;

  s := appPath() + 'jscrunch32.log';
  if(fileexists(s)) then deletefile(s);

  if(not parseInputParams()) then halt;
  writeln('');
  writeln('Done.');
  halt;
end.
