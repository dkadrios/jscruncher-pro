unit help;

interface

procedure showHelp(const s : string);

const
  htConsole             = 'Topics/Using_the_Command_Line_Tool.htm';
  htCompressionSettings = 'Dialogs/Compression_Settings.htm';
  htEditProject         = 'Dialogs/Project_Edit.htm';
  ftEnvironmentSettings = 'Topics/The_User_Interface/settings.htm';
  ftEditFileset         = 'Dialogs/Add_Edit_File_Selection.htm';
var
  CompiledHelpFile : string;

implementation

uses
   htmlhlp;

//------------------------------------------------------------------------------

procedure showHelp(const s : string);
var
  topic : string;
begin
  HtmlHelp(0, nil, HH_CLOSE_ALL, 0);
  topic := CompiledHelpFile + '::/' + s;
  HtmlHelp(0, PChar(topic), HH_DISPLAY_TOC, 0);
end;

//------------------------------------------------------------------------------

end.
