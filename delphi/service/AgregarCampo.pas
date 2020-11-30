unit AgregarCampo;

interface

uses
  Entidad,
  Proyecto,
  Campo,
  AdaptadorArchivoDeProyecto,
  DatosEntidad,
  generics.collections,
  sysutils;

type
  TAgregarCampo = class
    private
      fCampo: TCampo;
    public
      function Ejecutar(): string;
      property Campo: TCampo read fCampo write fCampo;
  end;

implementation

{ TAgregarCampo }

function TAgregarCampo.Ejecutar: string;
var
  entidad: TEntidad;
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
begin
  Assert(Campo <> nil, 'Debe proporcionar el campo.');
  adaptador := TAdaptadorArchivoDeProyecto.Create;

  try
    proyecto := adaptador.CargarProyecto();

    for entidad in proyecto.Entidades do
    begin
      if (entidad.Nombre = Campo.Entidad) and
         (entidad.Modulo = Campo.Modulo) then
      begin
        if not Assigned(entidad.Campos) then
          entidad.Campos := TList<TCampo>.Create;

        entidad.Campos.Add(Campo);
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
