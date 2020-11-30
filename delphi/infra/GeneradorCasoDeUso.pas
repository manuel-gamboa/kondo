unit GeneradorCasoDeUso;

interface

uses
  Proyecto,
  Campo,
  AdaptadorArchivoDeProyecto,
  InfraInterface,
  UseCase,
  Rutas,
  generics.collections,
  utils,
  sysutils,
  IOUtils,
  Response;

type
  TGeneradorCasoDeUso = class
    private
      fProyecto: TProyecto;
      adaptador: TAdaptadorArchivoDeProyecto;
      fUseCase: TUseCase;
      function GenerarBlockRepositorios(): string;
      function GenerarCampos(): string;
      function GenerarProperties(): string;
      function GenerarConstructorArguments(const aSpace: Integer): string;
      function GenerarConstructorBody(): string;
    public
      constructor Create;
      function Generar(const aUseCase: TUseCase): TResponse;

      property CasoDeUso: TUseCase read fUseCase write fUseCase;
  end;

implementation

{ TGeneradorCasoDeUso }

const
  NewLine: string = #13#10;

constructor TGeneradorCasoDeUso.Create;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;
  fProyecto := adaptador.CargarProyecto();
end;

function TGeneradorCasoDeUso.Generar(const aUseCase: TUseCase): TResponse;
var
  template, file_: TextFile;
  path:string;
  pathTipo:string;
  baseDirectory: string;
  body:string;
  line:string;
  rutas: TRutas;

  namespace: string;
  nsCommonTipo:string;
  nsCommonError:string;
  repositorios_block:string;

begin
  Result := TResponse.Create;
  CasoDeUso := aUseCase;

  rutas := TRutas.Create;
  baseDirectory := GetCurrentDir();
  path := TPath.Combine(baseDirectory + '\\', 'templates\\usecase.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  namespace := rutas.PathsNivel2['app_usecase'];
  nsCommonTipo := PathToNamespace(rutas.PathsNivel2['common_tipo']);
  nsCommonError := PathToNamespace(rutas.PathsNivel2['common_error']);

  repositorios_block := GenerarBlockRepositorios();

  body :=
    Format(
      body,
      [
        PathToNamespace(namespace),
        aUseCase.Modulo,
        aUseCase.Nombre,
        PathToNamespace(rutas.PathsNivel2['app_infra']),
        aUseCase.Modulo,
        Copy(nsCommonTipo, 1, nsCommonTipo.Length - 1),
        Copy(nsCommonError, 1, nsCommonError.Length - 1),
        aUseCase.Nombre,
        GenerarBlockRepositorios(),
        GenerarCampos(),
        GenerarConstructorArguments(8),
        GenerarProperties(),
        aUseCase.Nombre,
        GenerarConstructorArguments(2),
        GenerarConstructorBody(),
        aUseCase.Nombre
      ]
    );


  if aUseCase.Tipo = csCommand then
    pathTipo := 'Command'
  else
    pathTipo := 'Query';

  Result.namespace :=
    PathToNamespace(namespace) +
    aUseCase.Modulo + '.' + pathTipo + '.' +
    aUseCase.Nombre;

  Result.path :=
    namespace + '\\' +
    aUseCase.Modulo + '\\' + pathTipo + '\\' +
    PathToNamespace(namespace) +
    aUseCase.Modulo + '.' + pathTipo + '.' +
    aUseCase.Nombre + '.pas';

  Result.path :=
    StringReplace(Result.path, '\\', '\', [rfReplaceAll, rfIgnoreCase]);

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\',
      namespace + '\\' +
      aUseCase.Modulo + '\\' + pathTipo + '\\' +
      PathToNamespace(namespace) +
      aUseCase.Modulo + '.' + pathTipo + '.' +
      aUseCase.Nombre + '.pas'
    )
  );
  Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);

end;

function TGeneradorCasoDeUso.GenerarBlockRepositorios: string;
var
  interf: TInterface;
begin
  for interf in fProyecto.Interfaces do
  begin
    Result := Result +
      Format(
        'f%s: %s;' + NewLine + '      ',
        [
          Copy(interf.Nombre, 2, MaxInt),
          interf.Nombre
        ]
      );
  end;

  Result := TrimRight(Result);
end;

function TGeneradorCasoDeUso.GenerarCampos: string;
var
  campo: TCampo;
begin
  for campo in CasoDeUso.Parametros do
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

function TGeneradorCasoDeUso.GenerarConstructorArguments(
  const aSpace: Integer): string;
var
  interf: TInterface;
  I: Integer;
begin
  for interf in fProyecto.Interfaces do
  begin
    Result := Result +
      Format(
        'const a%s: %s;' + NewLine,
        [
          Copy(interf.Nombre, 2, MaxInt),
          interf.Nombre
        ]
      );

    for I := 1 to aSpace do
      Result := Result + ' ';
  end;

  Result := TrimRight(Result);
  Result := Copy(Result, 1 , Result.Length - 1);
end;

function TGeneradorCasoDeUso.GenerarConstructorBody: string;
var
  interf: TInterface;
  I: Integer;
begin
  for interf in fProyecto.Interfaces do
  begin
    Result := Result +
      Format(
        'f%s := a%s;' + NewLine + '  ',
        [
          Copy(interf.Nombre, 2, MaxInt),
          Copy(interf.Nombre, 2, MaxInt)
        ]
      );
  end;

  Result := TrimRight(Result);
end;

function TGeneradorCasoDeUso.GenerarProperties: string;
var
  campo: TCampo;
begin
  for campo in CasoDeUso.Parametros do
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
