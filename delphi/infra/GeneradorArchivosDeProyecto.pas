unit GeneradorArchivosDeProyecto;

interface

uses
  AdaptadorArchivoDeProyecto,
  Proyecto,
  sysutils,
  ioutils;

type
  TGeneradorArchivosDeProyecto = class
    private
    public
      function Generar(const aProyecto: TProyecto): string;
  end;

implementation

{ TGeneradorArchivosDeProyecto }

const
  NewLine: string = #13#10;

function TGeneradorArchivosDeProyecto.Generar(const aProyecto: TProyecto): string;
var
  namespace, ruta: string;
  bodyDPR, bodyDPROJ: string;

  file_: TextFile;
  path:string;
  baseDirectory: string;

  adaptador: TAdaptadorArchivoDeProyecto;
  generador: TGeneradorArchivosDeProyecto;
begin
  adaptador := TAdaptadorArchivoDeProyecto.Create;
  generador := TGeneradorArchivosDeProyecto.Create;

  for namespace in aProyecto.Archivos.Keys do
  begin
    bodyDPR := bodyDPR +
      Format(
        '%s in ''%s'',' + NewLine,
        [
          namespace,
          aProyecto.Archivos[namespace]
        ]
      );

    bodyDPROJ := bodyDPROJ +
      Format(
        '<DCCReference Include="%s"/>' + NewLine,
        [aProyecto.Archivos[namespace]]
      );
  end;

  baseDirectory := GetCurrentDir();

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\','dpr.temp'
    )
  );
  Rewrite(file_);

  Write(file_, bodyDPR);
  CloseFile(file_);

  Assign(
    file_,
    TPath.Combine(
      baseDirectory + '\\','dproj.temp'
    )
  );
  Rewrite(file_);

  Write(file_, bodyDPROJ);
  CloseFile(file_);
end;

end.
