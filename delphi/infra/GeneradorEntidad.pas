unit GeneradorEntidad;

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
  TGeneradorEntidad = class
    private
      fEntidad: TEntidad;
      function GenerateFields: string;
      function GenerateProperties: string;
    public
      function Generar(const aEntidad: TEntidad): TResponse;

      property Entidad: TEntidad read fEntidad write fEntidad;
  end;

implementation

{ TGeneradorEntidad }

const
  NewLine: string = #13#10;

function TGeneradorEntidad.Generar(const aEntidad: TEntidad): TResponse;
var
  template, file_: TextFile;
  path,namespace:string;
  baseDirectory: string;
  body:string;
  line:string;
  rutas: TRutas;

  usesBlock, fieldsBlock, propertiesBlock: string;
begin
  Result := TResponse.Create;
  Entidad := aEntidad;

  rutas := TRutas.Create;

  baseDirectory := GetCurrentDir();
  path := TPath.Combine(baseDirectory + '\\', 'templates\\entity.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  namespace := rutas.PathsNivel2['dominio_entidad'];

  usesBlock := 'spring.collections;';
  fieldsBlock := GenerateFields();
  propertiesBlock := GenerateProperties();

  Result.namespace :=
    PathToNamespace(namespace) +
    aEntidad.Modulo + '.' +
    aEntidad.Nombre;

  Result.path :=
    namespace + '\\' +
    aEntidad.Modulo + '\\' +
    PathToNamespace(namespace) +
    aEntidad.Modulo + '.' +
    aEntidad.Nombre + '.pas';

  Result.path :=
    StringReplace(Result.path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);

  body :=
    Format(
      body,
      [
        PathToNamespace(namespace),
        aEntidad.Modulo,
        aEntidad.Nombre,
        usesBlock,
        aEntidad.Nombre,
        fieldsBlock,
        propertiesBlock,
        aEntidad.Nombre
      ]
    );

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\',
      namespace + '\\' +
      aEntidad.Modulo + '\\' +
      PathToNamespace(namespace) +
      aEntidad.Modulo + '.' +
      aEntidad.Nombre + '.pas'
    )
  );
  Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);

end;

function TGeneradorEntidad.GenerateFields: string;
var
  campo: TCampo;
begin
  for campo in Entidad.Campos do
  begin
    if campo.EsLista then
      Result :=
        Result + 'f' + campo.Nombre +
        ': IList<' + campo.Tipo + '>;' + NewLine + '      '
    else
      Result :=
        Result + 'f' + campo.Nombre +
        ': ' + campo.Tipo + ';' + NewLine + '      ';
  end;
end;

function TGeneradorEntidad.GenerateProperties: string;
var
  campo: TCampo;
begin
  for campo in Entidad.Campos do
  begin
    if campo.EsLista then
      Result := Result +
        Format(
          'property %s read f%s write Set%s;' + NewLine + '      ',
          [
            campo.Nombre + ': IList<' + campo.Tipo + '>',
            campo.Nombre,
            campo.Nombre
          ]
        )
    else
      Result := Result +
        Format(
          'property %s read f%s write Set%s;' + NewLine + '      ',
          [
            campo.Nombre + ': ' + campo.Tipo,
            campo.Nombre,
            campo.Nombre
          ]
        );
  end;
end;

end.
