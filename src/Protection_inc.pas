unit Protection_inc;

interface

function productKey:string;
function GetErrorMsg(err:integer):string;
function unShuffledMD5:string;

var
	ExePath:string;

implementation

uses
  DNA_INT, string_compression, sysutils;

//------------------------------------------------------------------------------

function GetErrorMsg(err:integer):string;
var
	msg:array[0..127] of char;
begin
	DNA_Error(err,msg,sizeof(msg));
  result:=string(msg);
end;

//------------------------------------------------------------------------------

function productKey:string;
begin
  result :=
    DecodeAndUnCompress(
      'eJwLMDAwMDQyttANdHSycvbV9kzO1w5KDEn1MotMKvGOzAr3cS71snTxD/EKy3fzScuvdHSLzEvy' +
      'DA0LyygtKK+oKk+tcDGNLErJTtT2MzeOKimtTMoID8vLM/dxNI4sNXaqzDcFAAMbIIk='
    );
end;

//------------------------------------------------------------------------------

function unShuffledMD5:string;
begin
  result := DecodeAndUnCompress('eJxL9SovitKPyiiKMjEySTTKC8suSjIo9Q0KNjFLDi3JMzdMTU7OMvPQt8h2ybIM0XZ19Ne2cCk3sAUADUoRjg==');
end;

//------------------------------------------------------------------------------

initialization
	ExePath := ExtractFilePath(ParamStr(0));

end.
