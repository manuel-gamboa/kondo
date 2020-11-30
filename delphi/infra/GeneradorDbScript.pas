unit GeneradorDbScript;

interface

uses
  Entidad,
  Campo,
  Rutas,
  generics.collections,
  sysutils,
  utils,
  IOUtils;

type
  TGeneradorDbScript = class
    private
      fEntidad: TEntidad;
      function GenerateFields: string;
    public
      procedure Generar(const aEntidad: TEntidad);

      property Entidad: TEntidad read fEntidad write fEntidad;
  end;

implementation

{ TGeneradorDbScript }

const
  NewLine: string = #13#10;

procedure TGeneradorDbScript.Generar(const aEntidad: TEntidad);
var
  template, file_: TextFile;
  path:string;
  baseDirectory: string;
  body:string;
  line:string;
  rutas: TRutas;

  fieldsBlock: string;
begin
  Entidad := aEntidad;

  rutas := TRutas.Create;

  baseDirectory := GetCurrentDir();
  path := TPath.Combine(baseDirectory + '\\', 'templates\\db_script.template');

  Assign(template, path);
  Reset(template);

  while not Eof(template) do
  begin
    Readln(template, line);
    body := body + line + NewLine;
  end;

  CloseFile(template);

  fieldsBlock := GenerateFields();

  body :=
    Format(
      body,
      [
        aEntidad.Nombre,
        fieldsBlock,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre,
        aEntidad.Nombre
      ]
    );

  body := body + NewLine;

  path := TPath.Combine(baseDirectory + '\\db_script\\','migracion.sql');

  Assign(file_, path);

  if FileExists(path) then
    Append(file_)
  else
    Rewrite(file_);

  Write(file_, body);
  CloseFile(file_);

end;

function TGeneradorDbScript.GenerateFields: string;
var
  campo: TCampo;
  constraints: string;
begin
  for campo in Entidad.Campos do
  begin
    if (campo.EsLista) or (campo.DbCommand = 'db_ig') then
      continue
    else
    begin
      Result := Result + campo.Nombre + ' ' + GetDbType(campo.Tipo) + ',' +
        NewLine + '  ';

      if campo.Nombre = 'Id' then
        constraints := constraints +
          Format(
            'constraint pk_%s primary key (Id),' + NewLine + '  ',
            [Entidad.Nombre]
          );


      if campo.DbCommand = 'db_fk' then
        constraints := constraints +
          Format(
            'constraint fk_%s_%s foreign key (%s) references %s(Id),' +
            NewLine + '  ',
            [
              Entidad.Nombre,
              Copy(campo.DbReference, 2, MaxInt),
              campo.Nombre,
              Copy(campo.DbReference, 2, MaxInt)
            ]
          );
    end;

  end;

  constraints := Trim(constraints);
  Result := Result + Copy(constraints, 1, constraints.Length - 1);

end;

end.
