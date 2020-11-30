unit CrearEntidad;

interface

uses
  Proyecto,
  Entidad,
  Campo,
  AdaptadorArchivoDeProyecto,
  generics.collections,
  sysutils;

type
  TCrearEntidad = class
    public
      function Ejecutar(
        const aNombre: string;
        const aCampos: TList<TCampo>;
        const aModulo: string;
        const aGenerarRepo: Boolean): string;
  end;

implementation

{ TCrearEntidad }

function TCrearEntidad.Ejecutar(
  const aNombre: string;
  const aCampos: TList<TCampo>;
  const aModulo: string;
  const aGenerarRepo: Boolean): string;
var
  entidad: TEntidad;
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
begin
  if aModulo = '' then
    raise Exception.Create('El modulo no puede estar vacio');

  adaptador := TAdaptadorArchivoDeProyecto.Create;

  try
    //Crear entidad
    entidad := TEntidad.Create(aCampos);
    entidad.Modulo := aModulo;
    entidad.Nombre := aNombre;
    entidad.GenerarRepo := aGenerarRepo;

    proyecto := adaptador.CargarProyecto();

    //Agregarla al proyecto
    proyecto.AgregarEntidad(entidad);
    proyecto.TiposAdicionales.Add('T' + entidad.Nombre);

    //Guardar el proyecto
    adaptador.GuardarProyecto(proyecto);
  finally
    adaptador.Free;
    entidad.Free;
    proyecto.Free;
  end;

  Result := 'La entidad fue creada.';
end;

end.
