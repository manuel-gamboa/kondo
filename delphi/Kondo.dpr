program Kondo;

uses
  Vcl.Forms,
  MainView in 'MainView.pas' {Form2},
  InicializarProyecto in 'service\InicializarProyecto.pas',
  Rutas in 'service\Rutas.pas',
  Proyecto in 'Entidad\Proyecto.pas',
  CrearModulo in 'service\CrearModulo.pas',
  AdaptadorArchivoDeProyecto in 'infra\AdaptadorArchivoDeProyecto.pas',
  CargarProyecto in 'service\CargarProyecto.pas',
  EliminarModulo in 'service\EliminarModulo.pas',
  CrearEntidad in 'service\CrearEntidad.pas',
  Entidad in 'Entidad\Entidad.pas',
  Campo in 'Entidad\Campo.pas',
  GeneradorDTO in 'infra\GeneradorDTO.pas',
  Template in 'infra\Template.pas',
  ActualizarEntidad in 'service\ActualizarEntidad.pas',
  DatosEntidad in 'service\DatosEntidad.pas',
  AgregarCampo in 'service\AgregarCampo.pas',
  GenerarArchivos in 'service\GenerarArchivos.pas',
  GeneradorEntidad in 'infra\GeneradorEntidad.pas',
  utils in 'infra\utils.pas',
  GeneradorDbScript in 'infra\GeneradorDbScript.pas',
  GeneradorRepositorio in 'infra\GeneradorRepositorio.pas',
  GeneradorInterfaces in 'infra\GeneradorInterfaces.pas',
  UseCase in 'Entidad\UseCase.pas',
  GeneradorCasoDeUso in 'infra\GeneradorCasoDeUso.pas',
  CrearCasoDeUso in 'service\CrearCasoDeUso.pas',
  AgregarParametro in 'service\AgregarParametro.pas',
  InfraInterface in 'InfraInterface.pas',
  GeneradorArchivosDeProyecto in 'infra\GeneradorArchivosDeProyecto.pas',
  Response in 'infra\Response.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
