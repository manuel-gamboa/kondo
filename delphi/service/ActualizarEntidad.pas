unit ActualizarEntidad;

interface

uses
  Entidad,
  Proyecto,
  AdaptadorArchivoDeProyecto,
  DatosEntidad,
  generics.collections,
  sysutils;

type
  TActualizarEntidad = class
    private
      fDatosEntidad: TDatosEntidad;
    public
      function Ejecutar(): string;
      property DatosEntidad: TDatosEntidad read fDatosEntidad write fDatosEntidad;
  end;

implementation

{ TActualizarEntidad }

function TActualizarEntidad.Ejecutar: string;
var
  entidad: TEntidad;
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
begin
  Assert(fDatosEntidad <> nil, 'Debe proporcionar los datos de la entidad.');

  try
    proyecto := adaptador.CargarProyecto();

    for entidad in proyecto.Entidades do
    begin
      if (entidad.Nombre = DatosEntidad.Nombre) and
         (entidad.Modulo = DatosEntidad.Modulo) then
      begin
        entidad.Campos := DatosEntidad.Campos;
        adaptador.GuardarProyecto(proyecto);
      end;
    end;
  finally
    if Assigned(proyecto) then
      proyecto.Free;
    if Assigned(adaptador) then
      adaptador.Free;
  end;
end;

end.
