unit DatosEntidad;

interface

uses
  Campo,
  generics.collections,
  sysutils;

type
  TDatosEntidad = class
    private
      fCampos: TList<TCampo>;
      fNombre: string;
      fModulo: string;
    public
      property Nombre: string read fNombre write fNombre;
      property Modulo: string read fModulo write fModulo;
      property Campos: TList<TCampo> read fCampos write fCampos;
  end;

implementation

end.
