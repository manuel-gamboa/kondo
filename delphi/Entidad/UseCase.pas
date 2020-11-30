unit UseCase;

interface

uses
  Campo,
  generics.collections;

type
  TTipoCasoDeUso = (csCommand, csQuery);

  TUseCase = class
    private
      fNombre: string;
      fTipo: TTipoCasoDeUso;
      fParams: TList<TCampo>;
      fModulo: string;
    public
      constructor Create;
      property Nombre: string read fNombre write fNombre;
      property Modulo: string read fModulo write fModulo;
      property Tipo: TTipoCasoDeUso read fTipo write fTipo;
      property Parametros: TList<TCampo> read fParams write fParams;
  end;

implementation

{ TUseCase }

constructor TUseCase.Create;
begin
  Parametros := TList<TCampo>.Create;
end;

end.
