class Ventas::Cliente < ActiveRecord::Base
  acts_as_gmappable :callback => :save_geocode, :process_geocoding => false

  has_many :presupuesto, {:class_name => "Ventas::Presupuesto"}
  attr_accessible :latitude, :longitude, :avatar, :nombre, :ci, :nacionalidad, :estado_civil, :direccion, :telefono, :empleado_en, :direccion_trabajo, :telefono_trabajo, :tiempo, :sueldo, :cargo, :subordinados, :otros_ingresos, :conyugue_nombre, :conyugue_ci, :conyugue_empleado_en, :conyugue_telefono, :conyugue_tiempo, :conyugue_sueldo, :conyugue_cargo, :telefono2, :telefono3, :direccion2, :email
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :nombre, :presence => true
  # validates :latitude, :presence => true
  validates :ci, :presence => true
  validates :nacionalidad, :presence => true
  validates :estado_civil, :presence => true
  validates :direccion, :presence => true
  validates :telefono, :presence => true

  before_validation :validate_geocode

  after_save :crear_cliente_profit

  def validate_geocode
  end

  def crear_cliente_profit

    cliente_profit = Profit::Cliente.find_by_co_cli(self.ci.to_s)
                                             
# INSERT INTO clientes 
# (
    # tipo_adi,
    # tipo_per,
    # co_pais,
    # ciudad,
    # zip) 
# VALUES ('15303610  ','A     ','HELLER 
# RODRIGUEZ                                                                                    ','FINAL CALLE 8 
# DE LOS PINOS','04245558074                                                 ','20130128 
# 00:00:00.000',.00,0,.00,'02    ','04    ','09    ',.00,'FINAL CALLE 8 DE LOS PINOS','V-15306610        
# ',1,'HELLERRODRIGUEZ@GMAIL.COM               ','03    ','002 ','20130128 10:09:25.000','    ','20130128 
# 10:09:25.000','    ','20130128 10:09:25.000',' ',' ','01    ',1,'1','VE    
# ','CABUDARE                                          ','3001      ')

    unless cliente_profit
      cliente_profit = Profit::Cliente.new
      cliente_profit.co_cli = self.ci.to_s.ljust(10)
      cliente_profit.tipo = "A     "
      cliente_profit.cli_des = self.nombre
      cliente_profit.direc1 = self.direccion
      cliente_profit.direc2 = ""
      cliente_profit.fax = ""
      cliente_profit.comentario = ""
      cliente_profit.respons = ""
      cliente_profit.horar_caja = ""
      cliente_profit.frecu_vist = ""
      cliente_profit.dis_cen = ""
      cliente_profit.nit = ""
      cliente_profit.email = ""
      cliente_profit.campo1 = ""
      cliente_profit.campo2 = ""
      cliente_profit.campo3 = ""
      cliente_profit.campo4 = ""
      cliente_profit.campo5 = ""
      cliente_profit.campo6 = ""
      cliente_profit.campo7 = ""
      cliente_profit.campo8 = ""
      cliente_profit.matriz = ""
      cliente_profit.serialp = ""
      cliente_profit.login = ""
      cliente_profit.password = ""
      cliente_profit.website = ""
      cliente_profit.salestax = ""
      cliente_profit.telefonos = self.telefono

      cliente_profit.fecha_reg = Time.now

      cliente_profit.mont_cre = 0.0
      cliente_profit.plaz_pag = 0
      cliente_profit.desc_ppago = 0.0
      cliente_profit.co_zon = "03    "
      cliente_profit.co_seg = "04    "
      cliente_profit.co_ven = "07    "  # Cambiar por el usuario actual
      cliente_profit.desc_glob = 0.0

      cliente_profit.dir_ent2 = ""

      cliente_profit.rif = "V-" + self.ci.to_s.ljust(16)
      cliente_profit.contribu = 1

      #cliente_profit.email = " "
      cliente_profit.co_ingr = "03    "

      cliente_profit.co_us_in = "002 "
      cliente_profit.fe_us_in = Time.now
      cliente_profit.co_us_mo = "008 "
      cliente_profit.fe_us_mo = Time.now
      cliente_profit.co_us_el = "    "
      cliente_profit.fe_us_el = Time.now
      cliente_profit.fec_ult_ve = Time.now
      cliente_profit.revisado = " "
      cliente_profit.trasnfe = " "
      cliente_profit.co_sucu = "01    "

      cliente_profit.tipo_adi = 1

      cliente_profit.tipo_per = "1"

      cliente_profit.co_pais = "VE    "
      cliente_profit.ciudad = " "
      cliente_profit.zip = " "

      cliente_profit.rowguid = Profit::Cliente.find_by_sql('Select NEWID() as rowid').collect(&:rowid)[0]

      cliente_profit.save

    end


  end

  def to_string
    self.ci.to_s + ' - ' + self.nombre
  end

end
