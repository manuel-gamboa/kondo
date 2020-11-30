unit InfraInterface;

interface

type
  TInterface = class
    private
      fInterface: string;
      fModulo: string;
    public
      property Nombre: string read fInterface write fInterface;
      property Modulo: string read fModulo write fModulo;
  end;

implementation

end.
