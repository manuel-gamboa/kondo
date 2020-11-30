unit CrearCasoDeUso;

interface

uses
  Rutas,
  Usecase,
  SysUtils,
  IOUtils,
  AdaptadorArchivoDeProyecto,
  Proyecto;

type
  TCrearCasoDeUso = class
    private
    public
      function Ejecutar(
        const aNombre: string;
        const aTipo: TTipoCasoDeUso;
        const aModulo: string): string;
  end;

implementation

{ TCrearCasoDeUso }

function TCrearCasoDeUso.Ejecutar(
  const aNombre: string;
  const aTipo: TTipoCasoDeUso;
  const aModulo: string): string;
var
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
  casoDeUso: TUseCase;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;
  casoDeUso := TUseCase.Create;

  casoDeUso.Nombre := aNombre;
  casoDeUso.Tipo := aTipo;
  casoDeUso.Modulo := aModulo;

  try
    proyecto := adaptador.CargarProyecto();
    proyecto.CasosDeUsos.Add(casoDeUso);

    adaptador.GuardarProyecto(proyecto);
  finally
    if Assigned(adaptador) then
      FreeAndNil(adaptador);
  end;

  result := 'El caso de uso fue agregado.';
end;

end.
