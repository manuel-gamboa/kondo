unit AdaptadorArchivoDeProyecto;

interface

uses
  Entidad,
  REST.JSON,
  sysUtils,
  IOUtils,
  generics.collections,
  Proyecto;

type
  TAdaptadorArchivoDeProyecto = class
    public
      procedure GuardarProyecto(const aProyecto: TProyecto);
      function CargarProyecto(): TProyecto;
  end;

implementation

{ TAdaptadorArchivoDeProyecto }

function TAdaptadorArchivoDeProyecto.CargarProyecto(): TProyecto;
var
  file_: TextFile;
  json: string;
  entidad: TEntidad;
begin
  Assign(file_, 'kondo.json');
  Reset(file_);
  Read(file_, json);
  CloseFile(file_);


  Result := TJson.JsonToObject<TProyecto>(json);

//  for entidad in Result.Entidades do
//    if Trim(entidad.Modulo) = '' then
//      entidad.Modulo := 'Credito';

end;

procedure TAdaptadorArchivoDeProyecto.GuardarProyecto(
  const aProyecto: TProyecto);
var
  file_: TextFile;
  json: string;
begin
  Assign(file_, 'kondo.json');
  Rewrite(file_);

  json := TJson.ObjectToJsonString(aProyecto);
  Write(file_, json);
  CloseFile(file_);
end;

end.
