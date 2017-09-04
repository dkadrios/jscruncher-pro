program editor;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  images in '..\images.pas',
  dlgSearchText in 'dlgSearchText.pas' {TextSearchDialog},
  dlgReplaceText in 'dlgReplaceText.pas' {TextReplaceDialog},
  dlgConfirmReplace in 'dlgConfirmReplace.pas' {ConfirmReplaceDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'JSCruncher Pro Editor';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
