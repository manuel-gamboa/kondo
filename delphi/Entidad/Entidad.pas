unit Entidad;

interface

uses
  Campo,
  generics.collections,
  sysutils;

type

  TEntidad = class
    private
      fModulo: string;
      fCampos: TList<TCampo>;
      fNombre: string;
      fGenerarRepo: Boolean;
      procedure Crear(const aCampos: TList<TCampo>);
    public
      constructor Create(const aCampos: TList<TCampo> = nil);
      procedure CrearEntidad(const aCampos: TList<TCampo>);

      property Nombre: string read fNombre write fNombre;
      property Modulo: string read fModulo write fModulo;
      property Campos: TList<TCampo> read fCampos write fCampos;
      property GenerarRepo: Boolean read fGenerarRepo write fGenerarRepo;
  end;

implementation

{ TEntidad }

constructor TEntidad.Create(const aCampos: TList<TCampo>);
begin
  fCampos := aCampos;

end;

procedure TEntidad.Crear(const aCampos: TList<TCampo>);
begin

end;

procedure TEntidad.CrearEntidad(const aCampos: TList<TCampo>);
begin

end;

end.
