unit images;

interface

uses
  windows, sysutils, graphics, strutils, controls, classes, ImgList,
  TSImageList;

type
  TImages = class(TObject)
    private
      imageHash16 :tstrings;
    public
      il16   : TImageList;
      tsIl16 : TtsImageList;
      constructor create;
      destructor  destroy; override;
      function    GetImageIndex(imageName: string): integer;
      procedure   assignImage(const imageName:string;var aBitmap:TBitmap);
    end;

var
  allImages : TImages;

implementation


//------------------------------------------------------------------------------

function TImages.GetImageIndex(imageName: string): integer;
begin
  imageName := upperCase(imageName);
  result := imageHash16.indexOf(imageName);
  //if(result = -1) then
  //  result := imageHash32.indexOf(imageName);
end;

//------------------------------------------------------------------------------

procedure TImages.assignImage(const imageName:string;var aBitmap:TBitmap);
begin
  il16.GetBitmap(GetImageIndex(imageName), aBitmap);
end;

//------------------------------------------------------------------------------

function enumResNamesProc( module: HMODULE; restype, resname: PChar; aI:TImages): Integer; stdcall;
var
  r : string;
  b : tbitmap;
  i : TtsImage;
begin
  if HiWord( Cardinal(resname) ) <> 0 then r := resname
  else r := format('#%d',[loword(cardinal(resname))]);

  if(length(r) > 5) and (leftstr(r,5) = 'JSCP_') then begin
    // both il.ResourceLoad and il.GetResource seem to not support 256 color palletes
    // the work around is to add it to a bitmap first
    b := tbitmap.Create();
    try
      b.Width := 16;
      b.Height := 16;
      b.LoadFromResourceName(HInstance, r);
      aI.il16.AddMasked(b, clFuchsia);
      i := aI.tsIl16.Images.Add();
      i.Bitmap.Assign(b);
      i.Name             := rightstr(r, length(r)-5);
      i.Transparent      := true;
      i.TransparentColor := clFuchsia;
    finally
      b.free();
    end;
    aI.imageHash16.add(rightstr(r, length(r)-5));
  end;

  result := 1;
end;

//------------------------------------------------------------------------------

constructor TImages.create;
begin
  inherited;
  imageHash16 := tstringlist.create();
  il16        := TImageList.create(nil);
  tsIl16      := TtsImageList.Create(nil);
  EnumResourceNames( hinstance, RT_BITMAP, @enumResNamesProc, integer(self));
end;

//------------------------------------------------------------------------------

destructor TImages.destroy;
begin
  imageHash16.Free();
  il16       .free();
  tsIl16     .free();
  inherited;
end;

//------------------------------------------------------------------------------

initialization
  allImages := TImages.create();

finalization
  allImages.free();


end.
