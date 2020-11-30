unit GeneradorInterfaces;

interface

uses
  AdaptadorArchivoDeProyecto,
  Entidad,
  Proyecto,
  InfraInterface,
  Campo,
  Rutas,
  generics.collections,
  sysutils,
  utils,
  IOUtils,
  Response;

type
  TGeneradorInterfaces = class
    private
      fProyecto: TProyecto;
      function GenerarModulo(
        const aModulo: string;
        const aEntidades: TList<TEntidad>
      ): TResponse;
    public
      function Generar(const aProyecto: TProyecto): TList<TResponse>;

      property Proyecto: TProyecto read fProyecto write fProyecto;
  end;

implementation

{ TGeneradorInterfaces }

const
  NewLine: string = #13#10;

function TGeneradorInterfaces.Generar(
  const aProyecto: TProyecto): TList<TResponse>;
var
  modulo:string;
  entidades: TList<TEntidad>;
  entidad: TEntidad;
begin
  Proyecto := aProyecto;
  Result := TList<TResponse>.Create;

  for modulo in Proyecto.Modulos do
  begin
    entidades := TList<TEntidad>.Create;

    for entidad in Proyecto.Entidades do
      if (entidad.Modulo = modulo) and (entidad.GenerarRepo) then
        entidades.Add(entidad);

    Result.Add(GenerarModulo(modulo, entidades));
  end;
end;

function TGeneradorInterfaces.GenerarModulo(const aModulo: string;
  const aEntidades: TList<TEntidad>): TResponse;
var
  template, file_: TextFile;
  path:string;
  baseDirectory: string;
  body, bodyRepository:string;
  line:string;
  modulo:string;
  rutas: TRutas;
  namespace, domainNamespace: string;

  repository_block:string;
  entities_block:string;
  entidad: TEntidad;
  interf: TInterface;

  adaptador : TAdaptadorArchivoDeProyecto;
begin
  Result := TResponse.Create;
  rutas := TRutas.Create;
  namespace := rutas.PathsNivel2['app_infra'];
  domainNamespace := rutas.PathsNivel2['dominio_entidad'];
  baseDirectory := GetCurrentDir();
  adaptador := TAdaptadorArchivoDeProyecto.Create;

  //Open main template
  path := TPath.Combine(baseDirectory + '\\', 'templates\\app_infra.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  //Open repository block template
  path := TPath.Combine(baseDirectory + '\\', 'templates\\app_infra_repository.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    bodyRepository := bodyRepository + line + NewLine;
  end;

  CloseFile(template);

  Proyecto.Interfaces.Clear();

  for entidad in aEntidades do
  begin
    repository_block :=
      repository_block +
      Format(
        bodyRepository,
        [
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre,
          entidad.Nombre
        ]
      );

    entities_block :=
      entities_block +
      PathToNamespace(domainNamespace) +
      aModulo + '.' + entidad.Nombre + ',' + NewLine + '  ';

    interf := TInterface.Create;
    interf.Nombre := 'IRepositorio' + entidad.Nombre;
    interf.Modulo := aModulo;

    Proyecto.Interfaces.Add(interf);
  end;

  adaptador.GuardarProyecto(Proyecto);

  body :=
    Format(
      body,
      [
        PathToNamespace(namespace),
        aModulo,
        TrimRight(entities_block),
        TrimRight(repository_block)
      ]
    );

  Result.namespace :=
    PathToNamespace(namespace) +
    aModulo;

  Result.path :=
    namespace + '\\' +
    PathToNamespace(namespace) +
    aModulo + '.pas';

  Result.path :=
    StringReplace(Result.path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\',
      namespace + '\\' +
      PathToNamespace(namespace) +
      aModulo + '.pas'
    )
  );

  Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);

end;

end.
