program ProjectRTTIDataAnnotations;

uses
  Vcl.Forms,
  RTTICustomDataAnnotaions in 'RTTICustomDataAnnotaions.pas' {Form2},
  TDataAnnotations in 'DataAnnotations\TDataAnnotations.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
