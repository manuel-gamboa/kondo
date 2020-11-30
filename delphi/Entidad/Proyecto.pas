unit Proyecto;

interface

uses
  Entidad,
  UseCase,
  InfraInterface,
  REST.JSON,
  sysUtils,
  IOUtils,
  generics.collections;

type
  TProyecto = class
    private
      fModulos: TList<string>;
      fEntidades: TList<TEntidad>;
      fTipos: TList<string>;
      fCasosDeUso: TList<TUseCase>;
      fInterfaces: TList<TInterface>;
      fArchivos: TDictionary<string,string>;

    public
      property Modulos: TList<string> read fModulos;
      property Entidades: TList<TEntidad> read fEntidades;
      property TiposAdicionales: TList<string> read fTipos write fTipos;
      property CasosDeUsos: TList<TUseCase> read fCasosDeUso write fCasosDeUso;
      property Interfaces: TList<TInterface> read fInterfaces;
      property Archivos: TDictionary<string,string> read fArchivos write fArchivos;

      constructor Create;
      procedure CrearModulo(const aNombre: string);
      procedure AgregarEntidad(const aEntidad: TEntidad);
      procedure EliminarModulo(const aNombre: string);
      procedure EliminarEntidad(const aEntidad: TEntidad);
      procedure AgregarArchivo(const aKey:string; const aValue:string);
  end;

implementation

{ TProyecto }

constructor TProyecto.Create;
begin
  fModulos := TList<string>.Create;
  fEntidades := TList<TEntidad>.Create;
  fCasosDeUso := TList<TUseCase>.Create;
  fInterfaces := TList<TInterface>.Create;
  fTipos := TList<string>.Create;
  fArchivos := TDictionary<string, string>.Create();
end;

procedure TProyecto.EliminarEntidad(const aEntidad: TEntidad);
begin
  Entidades.Remove(aEntidad);
end;

procedure TProyecto.EliminarModulo(const aNombre: string);
begin
  Modulos.Remove(aNombre);
end;

procedure TProyecto.AgregarArchivo(const aKey, aValue: string);
begin
  fArchivos.Add(aKey, aValue);
end;

procedure TProyecto.AgregarEntidad(const aEntidad: TEntidad);
begin
  Entidades.Add(aEntidad);
end;

procedure TProyecto.CrearModulo(const aNombre: string);
begin
  Modulos.Add(aNombre);
end;

end.
