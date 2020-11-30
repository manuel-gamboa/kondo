unit InicializarProyecto;

interface

uses
  Rutas,
  CargarProyecto,
  AdaptadorArchivoDeProyecto,
  Proyecto,
  SysUtils,
  IOUtils;

type
  TInicializarProyecto = class
    private
      procedure CargarInformacion;
      procedure CrearEstructura;
    public
      function Ejecutar(): TProyecto;
  end;

implementation

{ TInicializarProyecto }

var
  baseDirectory: string;
  rutas: TRutas;

procedure TInicializarProyecto.CargarInformacion;
begin

end;

procedure TInicializarProyecto.CrearEstructura;
var
  path:string;
  error:string;
  key, value: string;
begin
  baseDirectory := GetCurrentDir();

  rutas := TRutas.Create;

  for key in rutas.TopLevelPaths.Keys do
  begin
    path := TPath.Combine(baseDirectory + '\\', rutas.TopLevelPaths[key]);
    if not DirectoryExists(path) then
      CreateDir(path);
  end;

  for key in rutas.PathsNivel1.Keys do
  begin
    path := TPath.Combine(baseDirectory + '\\', rutas.PathsNivel1[key]);
    if not DirectoryExists(path) then
      CreateDir(path);
  end;

  for key in rutas.PathsNivel2.Keys do
  begin
    path := TPath.Combine(baseDirectory + '\\', rutas.PathsNivel2[key]);
    if not DirectoryExists(path) then
      CreateDir(path);
  end;

end;

function TInicializarProyecto.Ejecutar():TProyecto;
var
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
  cargarProyecto: TCargarProyecto;
begin
  if FileExists('kondo.json') then
  begin
    cargarProyecto := TCargarProyecto.Create;
    Result := cargarProyecto.Ejecutar();
  end
  else
  begin
    CrearEstructura();
    adaptador := TAdaptadorArchivoDeProyecto.Create;
    proyecto := TProyecto.Create();
    adaptador.GuardarProyecto(proyecto);
    Result := proyecto;
  end;

end;

end.
