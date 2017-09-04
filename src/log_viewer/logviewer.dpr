program logviewer;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  logObjects in 'logObjects.pas',
  mapChooser in '..\mapChooser.pas' {mapChooserDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'JSCP LogViewer';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
