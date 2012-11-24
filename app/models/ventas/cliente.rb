class Ventas::Cliente < ActiveRecord::Base

  has_one :presupuesto
  attr_accessible :latitude, :longitude, :avatar, :nombre, :ci, :nacionalidad, :estado_civil, :direccion, :telefono, :empleado_en, :direccion_trabajo, :telefono_trabajo, :tiempo, :sueldo, :cargo, :subordinados, :otros_ingresos, :conyugue_nombre, :conyugue_ci, :conyugue_empleado_en, :conyugue_telefono, :conyugue_tiempo, :conyugue_sueldo, :conyugue_cargo
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :nombre, :presence => true
  validates :latitude, :presence => true
  validates :ci, :presence => true
  validates :nacionalidad, :presence => true
  validates :estado_civil, :presence => true
  validates :direccion, :presence => true
  validates :telefono, :presence => true

  rails_admin do
    edit do
      field :latitude, :map do
        longitude_field :longitude
        default_latitude 10.064044
        default_longitude -69.335471
      end
      field :longitude do
        hide
      end
      field :avatar
      field :nombre
      field :ci
      field :nacionalidad
      field :estado_civil
      field :direccion
      field :telefono
      field :empleado_en
      field :direccion_trabajo
      field :telefono_trabajo
      field :tiempo
      field :sueldo
      field :cargo
      field :subordinados
      field :otros_ingresos
      field :conyugue_nombre
      field :conyugue_ci
      field :conyugue_empleado_en
      field :conyugue_telefono
      field :conyugue_tiempo
      field :conyugue_sueldo
      field :conyugue_cargo      
    end
  end

  after_save :crear_cliente_profit


  def crear_cliente_profit

    cliente_profit = Profit::Cliente.find_by_co_cli(self.ci.to_s)

    unless cliente_profit
      cliente_profit = Profit::Cliente.new
      cliente_profit.co_cli = self.ci
      cliente_profit.tipo = "B5    "
      cliente_profit.cli_des = self.nombre
      cliente_profit.direc1 = self.direccion
      cliente_profit.direc2 = " "
      cliente_profit.telefonos = self.telefono
      cliente_profit.fax = " "
      cliente_profit.inactivo = false
      cliente_profit.comentario = " "
      cliente_profit.respons = " "
      cliente_profit.fecha_reg = Time.now
      cliente_profit.puntaje = 0
      cliente_profit.saldo = 0.0
      cliente_profit.saldo_ini = 0.0
      cliente_profit.fac_ult_ve = 0
      cliente_profit.fec_ult_ve = Time.now
      cliente_profit.net_ult_ve = 0.0
      cliente_profit.mont_cre = 0.0
      cliente_profit.plaz_pag = 0
      cliente_profit.desc_ppago = 0.0
      cliente_profit.co_zon = "03    "
      cliente_profit.co_seg = "04    "
      cliente_profit.co_ven = "07    "
      cliente_profit.desc_glob = 0.0
      cliente_profit.horar_caja = " "
      cliente_profit.frecu_vist = " "
      cliente_profit.lunes = false
      cliente_profit.martes = false
      cliente_profit.miercoles = false
      cliente_profit.jueves = false
      cliente_profit.viernes = false
      cliente_profit.sabado = false
      cliente_profit.domingo = false
      cliente_profit.dir_ent2 = ""
      cliente_profit.tipo_iva = " "
      cliente_profit.iva = 0.0
      cliente_profit.rif = "V-" + self.ci.to_s
      cliente_profit.contribu = false
      cliente_profit.dis_cen = " "
      cliente_profit.nit = "                  "
      cliente_profit.email = " "
      cliente_profit.co_ingr = "03    "
      cliente_profit.campo1 = " "
      cliente_profit.campo2 = " "
      cliente_profit.campo3 = " "
      cliente_profit.campo4 = " "
      cliente_profit.campo5 = " "
      cliente_profit.campo6 = " "
      cliente_profit.campo7 = " "
      cliente_profit.campo8 = " "
      cliente_profit.co_us_in = "005 "
      cliente_profit.fe_us_in = Time.now
      cliente_profit.co_us_mo = "008 "
      cliente_profit.fe_us_mo = Time.now
      cliente_profit.co_us_el = "    "
      cliente_profit.fe_us_el = Time.now
      cliente_profit.revisado = " "
      cliente_profit.trasnfe = " "
      cliente_profit.co_sucu = "      "
      cliente_profit.juridico = false
      cliente_profit.tipo_adi = 1
      cliente_profit.matriz = "          "
      cliente_profit.co_tab = 0
      cliente_profit.tipo_per = "1"
      cliente_profit.serialp = "                              "
      cliente_profit.valido = false
      cliente_profit.estado = "A"
      cliente_profit.Id = -1
      cliente_profit.co_pais = "VE    "
      cliente_profit.ciudad = " "
      cliente_profit.zip = " "
      cliente_profit.login = " "
      cliente_profit.password = " "
      cliente_profit.website = " "
      cliente_profit.salestax = "        "
      cliente_profit.contribu_e = false
      cliente_profit.porc_esp = 0.0
      cliente_profit.sincredito = false
      cliente_profit.rowguid = Profit::Cliente.find_by_sql('Select NEWID() as rowid').collect(&:rowid)[0]

      cliente_profit.save

    end


  end


end
