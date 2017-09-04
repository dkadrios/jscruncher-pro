unit TransformStartPage;

interface

uses
  Classes;

type
  TTransformStartPage = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    url,
    result : string;
  end;

implementation

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

{ TTransformStartPage }

//------------------------------------------------------------------------------

procedure TTransformStartPage.Execute;
var
  H : TIdHTTP;
begin
  h := TIdHTTP.create(nil);
  try
    try
      result := H.Get(URL);
    except end;
  finally
    H.free();
  end;
end;

//------------------------------------------------------------------------------

end.
