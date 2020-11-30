unit GeneradorDTO;

interface

uses
  Entidad,
  Campo,
  Rutas,
  generics.collections,
  sysutils,
  IOUtils,
  Response;

type
  TGeneradorDTO = class
    private
      fEntidad: TEntidad;
      function GenerateFields: string;
      function GenerateProperties: string;
      function PathToNamespace(const aPath: string): string;
    public
      function Generar(const aEntidad: TEntidad): TResponse;

      property Entidad: TEntidad read fEntidad write fEntidad;
  end;

implementation

{ TGeneradorDTO }

const
  NewLine: string = #13#10;

function TGeneradorDTO.Generar(const aEntidad: TEntidad): TResponse;
var
  template, file_: TextFile;
  path:string;
  baseDirectory: string;
  body:string;
  line:string;
  rutas: TRutas;

  path_app_dto, usesBlock, fieldsBlock, propertiesBlock: string;
begin
  Result := TResponse.Create;
  Entidad := aEntidad;

  rutas := TRutas.Create;

  baseDirectory := GetCurrentDir();
  path := TPath.Combine(baseDirectory + '\\', 'templates\\dto.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  path_app_dto := rutas.PathsNivel2['app_dto'];

  usesBlock := 'spring.collections;';
  fieldsBlock := GenerateFields();
  propertiesBlock := GenerateProperties();

  Result.namespace :=
    PathToNamespace(path_app_dto) +
    aEntidad.Modulo + '.Datos' +
    aEntidad.Nombre;

  Result.path :=
    path_app_dto + '\\' +
    aEntidad.Modulo + '\\' +
    PathToNamespace(path_app_dto) +
    aEntidad.Modulo + '.Datos' +
    aEntidad.Nombre + '.pas';

  Result.path :=
    StringReplace(Result.path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);

  body :=
    Format(
      body,
      [
        PathToNamespace(path_app_dto),
        aEntidad.Modulo,
        aEntidad.Nombre,
        usesBlock,
        aEntidad.Nombre,
        fieldsBlock,
        propertiesBlock
      ]
    );

  //guardar archivo destino
  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\',
      path_app_dto + '\\' +
      aEntidad.Modulo + '\\' +
      PathToNamespace(path_app_dto) +
      aEntidad.Modulo + '.Datos' +
      aEntidad.Nombre + '.pas'
    )
  );
  Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);
end;

function TGeneradorDTO.GenerateFields: string;
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

function TGeneradorDTO.GenerateProperties: string;
var
  campo: TCampo;
begin
  for campo in Entidad.Campos do
  begin
    if campo.EsLista then
      Result := Result +
        Format(
          'property %s read f%s write f%s;' + NewLine + '      ',
          [
            campo.Nombre + ': IList<' + campo.Tipo + '>',
            campo.Nombre,
            campo.Nombre
          ]
        )
    else
      Result := Result +
        Format(
          'property %s read f%s write f%s;' + NewLine + '      ',
          [
            campo.Nombre + ': ' + campo.Tipo,
            campo.Nombre,
            campo.Nombre
          ]
        );
  end;
end;

function TGeneradorDTO.PathToNamespace(const aPath: string): string;
var
  charArray : Array[0..0] of Char;
  parts: TArray<string>;
begin
  charArray[0] := '\';
  parts := aPath.Split(charArray);
  result := parts[2] + '.' + parts[4] + '.';
end;

end.
