unit CargarProyecto;

interface

uses
  AdaptadorArchivoDeProyecto,
  Proyecto,
  sysutils;

type

  TCargarProyecto = class
    public
      function Ejecutar: TProyecto;
  end;

implementation

{ TCargarProyecto }

function TCargarProyecto.Ejecutar: TProyecto;
var
  adaptador: TAdaptadorArchivoDeProyecto;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;

  try
    result := adaptador.CargarProyecto();
  finally
    if Assigned(adaptador) then
      FreeAndNil(adaptador);
  end;

end;

end.
