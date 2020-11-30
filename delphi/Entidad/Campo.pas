unit Campo;

interface

type

  TCampo = class
    private
      fDbCommand: string;
      fDbReference: string;
      fNombre: string;
      fTipo: string;
      fEsLista: Boolean;
      fEntidad: string;
      fModulo: string;
    public
      property Entidad: string read fEntidad write fEntidad;
      property Modulo: string read fModulo write fModulo;
      property Nombre: string read fNombre write fNombre;
      property Tipo: string read fTipo write fTipo;
      property DbCommand: string read fDbCommand write fDbCommand;
      property DbReference: string read fDbReference write fDbReference;
      property EsLista: Boolean read fEsLista write fEsLista;
  end;

implementation

end.
