unit AgregarParametro;

interface

uses
  Entidad,
  Proyecto,
  Campo,
  UseCase,
  AdaptadorArchivoDeProyecto,
  DatosEntidad,
  generics.collections,
  sysutils;

type
  TAgregarParametro = class
    private
    public
      function Ejecutar(const aCampo: TCampo): string;
  end;

implementation

{ TAgregarParametro }

function TAgregarParametro.Ejecutar(const aCampo: TCampo): string;
var
  casoDeUso: TUseCase;
  proyecto: TProyecto;
  adaptador: TAdaptadorArchivoDeProyecto;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;

  try
    proyecto := adaptador.CargarProyecto();

    for casoDeUso in proyecto.CasosDeUsos do
    begin
      if (casoDeUso.Nombre = aCampo.Entidad) and
         (casoDeUso.Modulo = aCampo.Modulo) then
      begin
        if not Assigned(casoDeUso.Parametros) then
          casoDeUso.Parametros := TList<TCampo>.Create;

        casoDeUso.Parametros.Add(aCampo);
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
