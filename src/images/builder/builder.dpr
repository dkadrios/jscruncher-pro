program builder;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Unit1 in 'Unit1.pas';

{-----------------------------------------------------------------------------
  the idea here is to build string files containing all the image names, then
  invoke the resource compiler on it
  -----------------------------------------------------------------------------}

var s : string;

begin

writeln('Building 16x16...');
writeln('');writeln('');
compileRC( '16x16\', '*.bmp', extractFilePath(ParamStr(0)), '16x16.res');

writeln('');writeln('');
writeln('Hit any key to close');
readln(s);


end.
