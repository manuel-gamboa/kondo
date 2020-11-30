unit GeneradorRepositorio;

interface

uses
  Entidad,
  Campo,
  Rutas,
  generics.collections,
  sysutils,
  utils,
  IOUtils,
  Response;

type
  TGeneradorRepositorio = class
    private
      fEntidad: TEntidad;
    public
      function Generar(const aEntidad: TEntidad): TResponse;

      property Entidad: TEntidad read fEntidad write fEntidad;
  end;

implementation

{ TGeneradorRepositorio }

const
  NewLine: string = #13#10;

function TGeneradorRepositorio.Generar(const aEntidad: TEntidad): TResponse;
var
  template, file_: TextFile;
  path:string;
  baseDirectory: string;
  body:string;
  line:string;
  rutas: TRutas;

  namespace, domainNamespace: string;
begin
  Result := TResponse.Create;
  Entidad := aEntidad;

  rutas := TRutas.Create;

  baseDirectory := GetCurrentDir();
  path := TPath.Combine(baseDirectory + '\\', 'templates\\repository.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  namespace := rutas.PathsNivel2['infra_db'];
  domainNamespace := rutas.PathsNivel2['dominio_entidad'];

  body :=
    Format(
      body,
      [
        PathToNamespace(namespace),
        aEntidad.Modulo,
        aEntidad.Nombre,
        PathToNamespace(domainNamespace),
        aEntidad.Modulo,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre.ToLower(),
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre.ToLower(),
        aEntidad.Nombre,
        aEntidad.Nombre.ToLower(),
        aEntidad.Nombre.ToLower(),
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre
      ]
    );

  Result.namespace :=
    PathToNamespace(namespace) +
    aEntidad.Modulo + '.Repositorio' +
    aEntidad.Nombre;

  Result.path :=
    namespace + '\\' +
    aEntidad.Modulo + '\\' +
    PathToNamespace(namespace) +
    aEntidad.Modulo + '.Repositorio' +
    aEntidad.Nombre + '.pas';

  Result.path :=
    StringReplace(Result.path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\',
      namespace + '\\' +
      aEntidad.Modulo + '\\' +
      PathToNamespace(namespace) +
      aEntidad.Modulo + '.Repositorio' +
      aEntidad.Nombre + '.pas'
    )
  );
  Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);

end;

end.
