object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 755
  ClientWidth = 898
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 540
    Width = 898
    Height = 215
    Align = alBottom
    TabOrder = 0
  end
  object mainContainer: TPageControl
    Left = 0
    Top = 0
    Width = 898
    Height = 412
    ActivePage = tabEntidades
    Align = alTop
    TabOrder = 1
    object tabProyectos: TTabSheet
      Caption = 'Proyecto'
      object btnInicializar: TButton
        Left = 3
        Top = 32
        Width = 110
        Height = 25
        Caption = 'Inicializar'
        TabOrder = 0
        OnClick = btnInicializarClick
      end
    end
    object tabModulos: TTabSheet
      Caption = 'Modulos'
      ImageIndex = 1
      OnShow = tabModulosShow
      object lstModulos: TListBox
        Left = 0
        Top = 0
        Width = 161
        Height = 297
        ItemHeight = 13
        TabOrder = 0
      end
      object edtModulos_Nombre: TEdit
        Left = 224
        Top = 18
        Width = 218
        Height = 21
        TabOrder = 1
      end
      object btnModulos_Agregar: TButton
        Left = 448
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Agregar'
        TabOrder = 2
        OnClick = btnModulos_AgregarClick
      end
      object btnModulos_Eliminar: TButton
        Left = 0
        Top = 303
        Width = 75
        Height = 25
        Caption = 'Eliminar'
        TabOrder = 3
        OnClick = btnModulos_EliminarClick
      end
    end
    object tabEntidades: TTabSheet
      Caption = 'Entidades'
      ImageIndex = 2
      object Label1: TLabel
        Left = 336
        Top = 85
        Width = 37
        Height = 13
        Caption = 'Nombre'
      end
      object Label2: TLabel
        Left = 504
        Top = 130
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object Label3: TLabel
        Left = 3
        Top = 85
        Width = 51
        Height = 13
        Caption = 'Entidades:'
      end
      object Label4: TLabel
        Left = 151
        Top = 85
        Width = 42
        Height = 13
        Caption = 'Campos:'
      end
      object Label5: TLabel
        Left = 504
        Top = 85
        Width = 37
        Height = 13
        Caption = 'Nombre'
      end
      object lstEntidades: TListBox
        Left = 0
        Top = 104
        Width = 145
        Height = 241
        ItemHeight = 13
        TabOrder = 0
        OnClick = lstEntidadesClick
      end
      object lstEntidades_Campos: TListBox
        Left = 151
        Top = 104
        Width = 156
        Height = 241
        ItemHeight = 13
        TabOrder = 1
      end
      object Button3: TButton
        Left = 0
        Top = 351
        Width = 75
        Height = 25
        Caption = 'Eliminar'
        TabOrder = 2
      end
      object Button4: TButton
        Left = 151
        Top = 351
        Width = 75
        Height = 25
        Caption = 'Eliminar'
        TabOrder = 3
      end
      object Button5: TButton
        Left = 232
        Top = 351
        Width = 75
        Height = 25
        Caption = 'Nuevo'
        TabOrder = 4
      end
      object edtEntidades_Nombre: TEdit
        Left = 336
        Top = 104
        Width = 121
        Height = 21
        TabOrder = 5
      end
      object btnEntidades_AgregarEntidad: TButton
        Left = 336
        Top = 214
        Width = 75
        Height = 25
        Caption = 'Agregar'
        TabOrder = 6
        OnClick = btnEntidades_AgregarEntidadClick
      end
      object cbxEntidades_Tipo: TComboBox
        Left = 504
        Top = 149
        Width = 145
        Height = 21
        TabOrder = 7
      end
      object cbxEntidades_Modulos: TComboBox
        Left = 0
        Top = 10
        Width = 185
        Height = 21
        ItemIndex = 0
        TabOrder = 8
        Text = 'Selecciona un modulo'
        Items.Strings = (
          'Selecciona un modulo')
      end
      object chkEntidades_Lista: TCheckBox
        Left = 504
        Top = 176
        Width = 57
        Height = 17
        Caption = 'Lista'
        TabOrder = 9
      end
      object chkEntidades_dbIgnore: TCheckBox
        Left = 576
        Top = 176
        Width = 73
        Height = 17
        Caption = 'db_ignore'
        TabOrder = 10
      end
      object chkEntidades_dbfk: TCheckBox
        Left = 664
        Top = 176
        Width = 65
        Height = 17
        Caption = 'db_fk'
        TabOrder = 11
      end
      object edtEntidades_NombreCampo: TEdit
        Left = 504
        Top = 104
        Width = 121
        Height = 21
        TabOrder = 12
      end
      object btnEntidades_AgregarCampo: TButton
        Left = 504
        Top = 214
        Width = 75
        Height = 25
        Caption = 'Agregar'
        TabOrder = 13
        OnClick = btnEntidades_AgregarCampoClick
      end
      object btnGenerar: TButton
        Left = 508
        Top = 344
        Width = 75
        Height = 25
        Caption = 'Generar'
        TabOrder = 14
        OnClick = btnGenerarClick
      end
      object cbxEntidades_Reference: TComboBox
        Left = 712
        Top = 174
        Width = 113
        Height = 21
        TabOrder = 15
      end
      object chkEntidades_Repositorio: TCheckBox
        Left = 336
        Top = 131
        Width = 97
        Height = 17
        Caption = 'Generar Repositorio'
        TabOrder = 16
      end
    end
    object tabUsecases: TTabSheet
      Caption = 'Casos de uso'
      ImageIndex = 3
      OnShow = tabUsecasesShow
      object Label6: TLabel
        Left = 616
        Top = 53
        Width = 37
        Height = 13
        Caption = 'Nombre'
      end
      object Label7: TLabel
        Left = 616
        Top = 98
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object lstUsecases: TListBox
        Left = 0
        Top = 72
        Width = 201
        Height = 278
        ItemHeight = 13
        TabOrder = 0
      end
      object btnUseCases_Eliminar: TButton
        Left = 3
        Top = 356
        Width = 75
        Height = 25
        Caption = 'Eliminar'
        TabOrder = 1
      end
      object btnUsecases_Agregar: TButton
        Left = 392
        Top = 135
        Width = 75
        Height = 25
        Caption = 'Agregar'
        TabOrder = 2
        OnClick = btnUsecases_AgregarClick
      end
      object edtUsecases_Nombre: TEdit
        Left = 392
        Top = 72
        Width = 193
        Height = 21
        TabOrder = 3
      end
      object chkUsecases_comando: TCheckBox
        Left = 392
        Top = 99
        Width = 97
        Height = 17
        Caption = 'Comando'
        TabOrder = 4
      end
      object chkUsecases_Query: TCheckBox
        Left = 520
        Top = 99
        Width = 97
        Height = 17
        Caption = 'Query'
        TabOrder = 5
      end
      object cbxUsecases_Modulo: TComboBox
        Left = 0
        Top = 3
        Width = 185
        Height = 21
        ItemIndex = 0
        TabOrder = 6
        Text = 'Selecciona un modulo'
        Items.Strings = (
          'Selecciona un modulo')
      end
      object lstUsecases_Params: TListBox
        Left = 207
        Top = 72
        Width = 170
        Height = 278
        ItemHeight = 13
        TabOrder = 7
      end
      object edtUsecases_NombreCampo: TEdit
        Left = 616
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 8
      end
      object cbxUsecases_TipoCampo: TComboBox
        Left = 616
        Top = 117
        Width = 145
        Height = 21
        TabOrder = 9
      end
      object btnUsecases_AgregarCampo: TButton
        Left = 616
        Top = 182
        Width = 75
        Height = 25
        Caption = 'Agregar'
        TabOrder = 10
        OnClick = btnUsecases_AgregarCampoClick
      end
      object chkUsecases_Lista: TCheckBox
        Left = 616
        Top = 144
        Width = 97
        Height = 17
        Caption = 'Lista'
        TabOrder = 11
      end
    end
  end
end
