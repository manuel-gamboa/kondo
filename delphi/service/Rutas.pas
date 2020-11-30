unit Rutas;

interface

uses
  generics.collections;

type
  TRutas = class
    private
      fTopLevelPaths: TDictionary<string, string>;
      fPathsNivel2: TDictionary<string, string>;
      fPathsNivel1: TDictionary<string, string>;
    public
      constructor Create;
      property TopLevelPaths: TDictionary<string,string> read fTopLevelPaths;
      property PathsNivel1: TDictionary<string,string> read fPathsNivel1;
      property PathsNivel2: TDictionary<string,string> read fPathsNivel2;
  end;


implementation

{ TRutas }

constructor TRutas.Create;
begin
  fTopLevelPaths := TDictionary<string,string>.Create();
  fPathsNivel1 := TDictionary<string,string>.Create();
  fPathsNivel2 := TDictionary<string,string>.Create();

  TopLevelPaths.Add('src', 'src');
  TopLevelPaths.Add('test', 'test');
  TopLevelPaths.Add('config', 'config');
  TopLevelPaths.Add('db_script', 'db_script');

  PathsNivel1.Add('app', 'src\\app');
  PathsNivel1.Add('dominio', 'src\\dominio');
  PathsNivel1.Add('infra', 'src\\infra');
  PathsNivel1.Add('common', 'src\\common');
  PathsNivel1.Add('app_test', 'test\\app');
  PathsNivel1.Add('dominio_test', 'test\\dominio');
  PathsNivel1.Add('infra_test', 'test\\infra');
  PathsNivel1.Add('common_test', 'test\\common');

  PathsNivel2.Add('app_usecase', 'src\\app\\usecase');
  PathsNivel2.Add('app_dto', 'src\\app\\dto');
  PathsNivel2.Add('app_servicio', 'src\\app\\servicio');
  PathsNivel2.Add('app_infra', 'src\\app\\infra');
  PathsNivel2.Add('app_map', 'src\\app\\map');
  PathsNivel2.Add('app_usecase_test', 'test\\app\\usecase');
  PathsNivel2.Add('app_servicio_test', 'test\\app\\servicio');
  PathsNivel2.Add('app_map_test', 'test\\app\\map');

  PathsNivel2.Add('dominio_entidad', 'src\\dominio\\entidad');
  PathsNivel2.Add('dominio_servicio', 'src\\dominio\\servicio');
  PathsNivel2.Add('dominio_entidad_test', 'test\\dominio\\entidad');
  PathsNivel2.Add('dominio_servicio_test', 'test\\dominio\\servicio');

  PathsNivel2.Add('common_error', 'src\\common\\error');
  PathsNivel2.Add('common_tipo', 'src\\common\\tipo');

  PathsNivel2.Add('infra_db', 'src\\infra\\db');
  PathsNivel2.Add('infra_os', 'src\\infra\\os');
  PathsNivel2.Add('infra_hardware', 'src\\infra\\hardware');
  PathsNivel2.Add('infra_broker', 'src\\infra\\broker');
  PathsNivel2.Add('infra_db_test', 'test\\infra\\db');
  PathsNivel2.Add('infra_os_test', 'test\\infra\\os');
  PathsNivel2.Add('infra_hardware_test', 'test\\infra\\hardware');
  PathsNivel2.Add('infra_broker_test', 'test\\infra\\broker');
end;

end.
