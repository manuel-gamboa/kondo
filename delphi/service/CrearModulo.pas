unit CrearModulo;

interface

uses
  Rutas,
  SysUtils,
  IOUtils,
  AdaptadorArchivoDeProyecto,
  Proyecto;

type
  TCrearModulo = class
    private
      procedure CrearCarpetas(const aModulo: string);
    public
      constructor Create;
      function Ejecutar(const aNombre: string): string;
  end;

implementation

{ TCrearModulo }

procedure TCrearModulo.CrearCarpetas(const aModulo: string);
var
  baseDirectory: string;
  path:string;
  error:string;
  key, value: string;
  rutas: TRutas;
begin
  baseDirectory := GetCurrentDir();

  rutas := TRutas.Create;

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['app_usecase'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['app_usecase'] + '\\',
      aModulo + '\\Command'
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['app_usecase'] + '\\',
      aModulo + '\\Query'
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['app_dto'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);


  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['dominio_entidad'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['infra_db'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['app_usecase_test'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);

  path :=
    TPath.Combine(
      baseDirectory + '\\' + rutas.PathsNivel2['dominio_entidad_test'] + '\\',
      aModulo
    );

  if not DirectoryExists(path) then CreateDir(path);

end;

constructor TCrearModulo.Create;
begin

end;

function TCrearModulo.Ejecutar(const aNombre: string): string;
var
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
begin

  adaptador := TAdaptadorArchivoDeProyecto.Create;

  try
    CrearCarpetas(aNombre);

    proyecto := adaptador.CargarProyecto();
    proyecto.CrearModulo(aNombre);

    adaptador.GuardarProyecto(proyecto);
  finally
    if Assigned(adaptador) then
      FreeAndNil(adaptador);
  end;

  result := 'El modulo fue agregado.';
end;

end.
