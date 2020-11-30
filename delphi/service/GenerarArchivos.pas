unit GenerarArchivos;

interface

uses
  Proyecto,
  AdaptadorArchivoDeProyecto,
  Entidad,
  UseCase,
  Campo,
  GeneradorDTO,
  GeneradorEntidad,
  GeneradorDbScript,
  GeneradorRepositorio,
  GeneradorInterfaces,
  GeneradorCasoDeUso,
  GeneradorArchivosDeProyecto,
  generics.collections,
  sysutils,
  Response;

type
  TGenerarArchivos = class
    private
      fProyecto: TProyecto;

      procedure AgregrId(const aEntidad: TEntidad);
    public
      destructor Destroy;
      function Ejecutar: string;
  end;

implementation

{ TGenerarArchivos }

procedure TGenerarArchivos.AgregrId(const aEntidad: TEntidad);
var
  campo: TCampo;
begin
  if aEntidad.Campos[0].Nombre <> 'Id' then
  begin
    campo := TCampo.Create;
    campo.Entidad := aEntidad.Nombre;
    campo.Modulo := aEntidad.Modulo;
    campo.Nombre := 'Id';
    campo.Tipo := 'Integer';
    campo.EsLista := False;

    aEntidad.Campos.Insert(0, campo);
  end;
end;

destructor TGenerarArchivos.Destroy;
begin
  if Assigned(fProyecto) then
    fProyecto.Free;

  inherited;
end;

function TGenerarArchivos.Ejecutar: string;
var
  entidad: TEntidad;
  usecase: TUseCase;
  adaptador: TAdaptadorArchivoDeProyecto;
  generador: TGeneradorArchivosDeProyecto;
  generadorCasosDeUso: TGeneradorCasoDeUso;
  generadorDTO: TGeneradorDTO;
  generadorEntidad: TGeneradorEntidad;
  generadorRepositorio: TGeneradorRepositorio;
  generadorInterfaces: TGeneradorInterfaces;
  generadorDB: TGeneradorDbScript;
  response: TResponse;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;

  generador := TGeneradorArchivosDeProyecto.Create;
  generadorCasosDeUso := TGeneradorCasoDeUso.Create;
  generadorDTO := TGeneradorDTO.Create;
  generadorEntidad := TGeneradorEntidad.Create;
  generadorRepositorio := TGeneradorRepositorio.Create;
  generadorInterfaces := TGeneradorInterfaces.Create;
  generadorDB := TGeneradorDbScript.Create;

  try
    fProyecto := adaptador.CargarProyecto();

    fProyecto.Archivos := TDictionary<string,string>.Create();

    for entidad in fProyecto.Entidades do
    begin
      AgregrId(entidad);

      response := generadorDTO.Generar(entidad);
      fProyecto.AgregarArchivo(response.namespace, response.path);

      response := generadorEntidad.Generar(entidad);
      fProyecto.AgregarArchivo(response.namespace, response.path);

      generadorDB.Generar(entidad);

      if entidad.GenerarRepo then
      begin
        response := generadorRepositorio.Generar(entidad);
        fProyecto.AgregarArchivo(response.namespace, response.path);
      end;

    end;

    for response in generadorInterfaces.Generar(fProyecto) do
      fProyecto.AgregarArchivo(response.namespace, response.path);

    for usecase in fProyecto.CasosDeUsos do
    begin
      response := generadorCasosDeUso.Generar(usecase);
      fProyecto.AgregarArchivo(response.namespace, response.path);
    end;

    generador.Generar(fProyecto);
  finally
    if Assigned(adaptador) then
      adaptador.Free;
  end;

end;

end.
