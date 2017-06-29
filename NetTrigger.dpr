program NetTrigger;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  WinAPIICMPDeclare in 'WinAPIICMPDeclare.pas',
  WinAPIPingHandle in 'WinAPIPingHandle.pas',
  Indy10ThreadedPing in 'Indy10ThreadedPing.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
