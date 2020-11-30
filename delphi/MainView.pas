unit MainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  InicializarProyecto,
  CrearModulo,
  CrearCasoDeUso,
  CargarProyecto,
  CrearEntidad,
  AgregarCampo,
  AgregarParametro,
  ActualizarEntidad,
  GenerarArchivos,
  UseCase,
  Proyecto,
  Entidad,
  Campo,
  DatosEntidad,
  generics.collections;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    chkEntidades_Lista: TCheckBox;
    chkEntidades_dbIgnore: TCheckBox;
    mainContainer: TPageControl;
    tabProyectos: TTabSheet;
    btnInicializar: TButton;
    tabModulos: TTabSheet;
    lstModulos: TListBox;
    edtModulos_Nombre: TEdit;
    btnModulos_Agregar: TButton;
    btnModulos_Eliminar: TButton;
    tabEntidades: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lstEntidades: TListBox;
    lstEntidades_Campos: TListBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    edtEntidades_Nombre: TEdit;
    btnEntidades_AgregarEntidad: TButton;
    cbxEntidades_Tipo: TComboBox;
    cbxEntidades_Modulos: TComboBox;
    tabUsecases: TTabSheet;
    chkEntidades_dbfk: TCheckBox;
    edtEntidades_NombreCampo: TEdit;
    Label5: TLabel;
    btnEntidades_AgregarCampo: TButton;
    btnGenerar: TButton;
    cbxEntidades_Reference: TComboBox;
    chkEntidades_Repositorio: TCheckBox;
    lstUsecases: TListBox;
    btnUseCases_Eliminar: TButton;
    btnUsecases_Agregar: TButton;
    edtUsecases_Nombre: TEdit;
    chkUsecases_comando: TCheckBox;
    chkUsecases_Query: TCheckBox;
    cbxUsecases_Modulo: TComboBox;
    lstUsecases_Params: TListBox;
    Label6: TLabel;
    edtUsecases_NombreCampo: TEdit;
    Label7: TLabel;
    cbxUsecases_TipoCampo: TComboBox;
    btnUsecases_AgregarCampo: TButton;
    chkUsecases_Lista: TCheckBox;
    procedure btnEntidades_AgregarCampoClick(Sender: TObject);
    procedure btnEntidades_AgregarEntidadClick(Sender: TObject);
    procedure btnGenerarClick(Sender: TObject);
    procedure btnInicializarClick(Sender: TObject);
    procedure btnModulos_AgregarClick(Sender: TObject);
    procedure btnModulos_EliminarClick(Sender: TObject);
    procedure btnUsecases_AgregarCampoClick(Sender: TObject);
    procedure btnUsecases_AgregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstEntidadesClick(Sender: TObject);
    procedure tabModulosShow(Sender: TObject);
    procedure tabUsecasesShow(Sender: TObject);
  private
    { Private declarations }
    fInicializarProyecto: TInicializarProyecto;
    fCrearModulo: TCrearModulo;
    fCrearCasoDeUso: TCrearCasoDeUso;
    fCargarProyecto: TCargarProyecto;
    fCrearEntidad: TCrearEntidad;
    fAgregarCampo: TAgregarCampo;
    fAgregarParametro: TAgregarParametro;
    fActualizarEntidad: TActualizarEntidad;
    fProyecto: TProyecto;

    procedure CargarModulos;
    procedure CargarEntidades;
    procedure CargarCasosDeUso;
    procedure CargarCampos;
    procedure CargarParametros;
    procedure CargarTipos;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnEntidades_AgregarCampoClick(Sender: TObject);
var
  campo: TCampo;
  i: Integer;
begin
  campo := TCampo.Create;
  campo.Entidad := lstEntidades.Items[lstEntidades.ItemIndex];
  campo.Modulo := cbxEntidades_Modulos.Items[cbxEntidades_Modulos.ItemIndex];
  campo.Nombre := edtEntidades_NombreCampo.Text;
  campo.Tipo := cbxEntidades_Tipo.Items[cbxEntidades_Tipo.ItemIndex];
  campo.EsLista := chkEntidades_Lista.Checked;

  if chkEntidades_dbIgnore.Checked then
    campo.DbCommand := 'db_ig';
  if chkEntidades_dbfk.Checked then
  begin
    campo.DbCommand := 'db_fk';
    campo.DbReference := cbxEntidades_Reference.Items[cbxEntidades_Reference.ItemIndex];
  end;

  fAgregarCampo.Campo := campo;

  try
    Memo1.Lines.Add(fAgregarCampo.Ejecutar());

    CargarCampos();
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;
end;

procedure TForm2.btnEntidades_AgregarEntidadClick(Sender: TObject);
begin
  try
    Memo1.Lines.Add(
      fCrearEntidad.Ejecutar(
        edtEntidades_Nombre.Text,
        nil,
        cbxEntidades_Modulos.Items[cbxEntidades_Modulos.ItemIndex],
        chkEntidades_Repositorio.Checked
      )
    );

    CargarEntidades();
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;
end;

procedure TForm2.btnGenerarClick(Sender: TObject);
var
  command: TGenerarArchivos;
begin
  command := TGenerarArchivos.Create;

  command.Ejecutar();
end;

procedure TForm2.btnInicializarClick(Sender: TObject);
begin
  try
    fProyecto := fInicializarProyecto.Ejecutar();
    Memo1.Lines.Add('Proyecto inicializado');
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;

end;

procedure TForm2.btnModulos_AgregarClick(Sender: TObject);
begin
  try
    Memo1.Lines.Add(fCrearModulo.Ejecutar(edtModulos_Nombre.Text));

    CargarModulos();
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;
end;

procedure TForm2.btnModulos_EliminarClick(Sender: TObject);
begin
//  if lstModulos.ItemIndex >= 0 then
//  begin
//    if not Assigned(proyecto) then
//      proyecto := fCargarProyecto.Ejecutar();
//
//    proyecto.EliminarModulo(lstModulos.Items[lstModulos.ItemIndex]);
//    ad
//
//  end;

end;

procedure TForm2.btnUsecases_AgregarCampoClick(Sender: TObject);
var
  campo: TCampo;
  i: Integer;
begin
  campo := TCampo.Create;
  campo.Entidad := lstUsecases.Items[lstUsecases.ItemIndex];
  campo.Modulo := cbxUsecases_Modulo.Items[cbxUsecases_Modulo.ItemIndex];
  campo.Nombre := edtUsecases_NombreCampo.Text;
  campo.Tipo := cbxUsecases_TipoCampo.Items[cbxUsecases_TipoCampo.ItemIndex];
  campo.EsLista := chkUsecases_Lista.Checked;

  try
    Memo1.Lines.Add(fAgregarParametro.Ejecutar(campo));

    CargarParametros();
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;

end;

procedure TForm2.btnUsecases_AgregarClick(Sender: TObject);
var
  tipo: TTipoCasoDeUso;
begin
  if chkUsecases_comando.Checked then
    tipo := csCommand
  else
    tipo := csQuery;

  try
    Memo1.Lines.Add(
      fCrearCasoDeUso.Ejecutar(
        edtUsecases_Nombre.Text,
        tipo,
        cbxUsecases_Modulo.Items[cbxUsecases_Modulo.ItemIndex]
      )
    );

    CargarCasosDeUso();
  except on E: Exception do
    Memo1.Lines.Add('Ocurrio un error inesperado.\n' + E.Message);
  end;
end;

procedure TForm2.CargarCampos;
var
  entidad: TEntidad;
  campo: TCampo;
begin
  fProyecto := fCargarProyecto.Ejecutar();

  lstEntidades_Campos.Items.Clear();

  for entidad in fProyecto.Entidades do
  begin
    if (entidad.Nombre = lstEntidades.Items[lstEntidades.ItemIndex]) and
       (entidad.Modulo =  cbxEntidades_Modulos.Items[cbxEntidades_Modulos.ItemIndex]) then
    begin
      if Assigned(entidad.Campos) then
        for campo in entidad.Campos do
        begin
          lstEntidades_Campos.Items.Add(campo.Nombre);
        end;
    end;

  end;
end;

procedure TForm2.CargarCasosDeUso;
var
  usecase: TUseCase;
begin
  fProyecto := fCargarProyecto.Ejecutar();

  lstUsecases.Items.Clear();

  for usecase in fProyecto.CasosDeUsos do
    lstUsecases.Items.Add(usecase.Nombre);
end;

procedure TForm2.CargarEntidades;
var
  entidad: TEntidad;
begin
  fProyecto := fCargarProyecto.Ejecutar();

  lstEntidades.Items.Clear();

  for entidad in fProyecto.Entidades do
  begin
    lstEntidades.Items.Add(entidad.Nombre);
  end;

  CargarTipos();
end;

procedure TForm2.CargarModulos;
var
  modulo: string;
begin
  fProyecto := fCargarProyecto.Ejecutar();

  lstModulos.Items.Clear();
  cbxEntidades_Modulos.Items.Clear;
  cbxUsecases_Modulo.Items.Clear;

  for modulo in fProyecto.Modulos do
  begin
    lstModulos.Items.Add(modulo);
    cbxEntidades_Modulos.Items.Add(modulo);
    cbxUsecases_Modulo.Items.Add(modulo);
  end;
end;

procedure TForm2.CargarParametros;
var
  usecase: TUseCase;
  campo: TCampo;
begin
  fProyecto := fCargarProyecto.Ejecutar();

  lstUsecases_Params.Items.Clear();

  for usecase in fProyecto.CasosDeUsos do
  begin
    if (usecase.Nombre = lstUsecases.Items[lstUsecases.ItemIndex]) and
       (usecase.Modulo =  cbxUsecases_Modulo.Items[cbxUsecases_Modulo.ItemIndex]) then
    begin
      if Assigned(usecase.Parametros) then
        for campo in usecase.Parametros do
        begin
          lstUsecases_Params.Items.Add(campo.Nombre);
        end;
    end;

  end;

end;

procedure TForm2.CargarTipos;
var
  tipo: string;
begin
  cbxEntidades_Tipo.Items.Clear;
  cbxUsecases_TipoCampo.Items.Clear;

  cbxEntidades_Tipo.Items.Add('Currency');
  cbxEntidades_Tipo.Items.Add('Integer');
  cbxEntidades_Tipo.Items.Add('DateTime');
  cbxEntidades_Tipo.Items.Add('String');
  cbxEntidades_Tipo.Items.Add('Boolean');

  cbxUsecases_TipoCampo.Items.Add('Currency');
  cbxUsecases_TipoCampo.Items.Add('Integer');
  cbxUsecases_TipoCampo.Items.Add('DateTime');
  cbxUsecases_TipoCampo.Items.Add('String');
  cbxUsecases_TipoCampo.Items.Add('Boolean');

  cbxEntidades_Reference.Items.Clear;

  for tipo in fProyecto.TiposAdicionales do
  begin
    cbxEntidades_Tipo.Items.Add(tipo);
    cbxUsecases_TipoCampo.Items.Add(tipo);
    cbxEntidades_Reference.Items.Add(tipo);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  fInicializarProyecto := TInicializarProyecto.Create;
  fCrearModulo := TCrearModulo.Create;
  fCargarProyecto := TCargarProyecto.Create;
  fCrearEntidad := TCrearEntidad.Create;
  fAgregarCampo := TAgregarCampo.Create;
  fAgregarParametro := TAgregarParametro.Create;
  fCrearCasoDeUso := TCrearCasoDeUso.Create;
end;

procedure TForm2.lstEntidadesClick(Sender: TObject);
begin
  if lstEntidades.ItemIndex >= 0 then
    CargarCampos();

end;

procedure TForm2.tabModulosShow(Sender: TObject);
begin
  CargarModulos();
  CargarEntidades();
end;

procedure TForm2.tabUsecasesShow(Sender: TObject);
begin
  CargarModulos();
  CargarTipos();
  CargarCasosDeUso();
end;

end.
