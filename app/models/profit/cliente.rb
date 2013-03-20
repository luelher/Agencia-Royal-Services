class Profit::Cliente < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'clientes'
  attr_accessible :co_cli, :cli_des, :direc1, :telefonos

  has_many :docum_cc, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :zona, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}

  has_one :pais, {:foreign_key => 'co_pais', :primary_key => 'co_pais', :class_name => 'Profit::Paises'}

  has_many :factura, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :condicio, {:through => :factura}

  has_one :cliente_venta, {:foreign_key => 'ci', :primary_key => 'co_cli', :class_name => 'Ventas::Cliente'}

  has_one :carta, {:foreign_key => 'co_cli', :primary_key => 'co_cli', :class_name => "Cobranza::Carta"}

  def to_string
    self.co_cli.strip + ' - ' + self.cli_des.strip unless self.co_cli.nil?
  end

  def parsing_telefonos
    telfs = self.telefonos.split "/"
    telfs.map{|t| t.strip}
  end

  def crear_ventas_cliente
    unless self.cliente_venta

      cliente = Ventas::Cliente.new

      telfs = self.parsing_telefonos

      cliente.latitude = 10.066336
      cliente.longitude = -69.324225
      cliente.nombre = self.cli_des
      cliente.ci = self.co_cli
      cliente.nacionalidad = self.pais.nil? ? "Otros" : self.pais.pais_des.strip
      cliente.estado_civil = "OTROS"
      cliente.direccion = self.direc1
      cliente.direccion2 = self.direc1
      cliente.telefono = telfs[0] unless telfs[0].nil?
      cliente.telefono2 = telfs[1] unless telfs[1].nil?
      cliente.telefono3 = telfs[2] unless telfs[2].nil?
      cliente.email     =  self.email.strip 
      # cliente.empleado_en = 
      # cliente.direccion_trabajo = 
      # cliente.telefono_trabajo = 
      # cliente.tiempo = 
      # cliente.sueldo = 
      # cliente.cargo = 
      # cliente.subordinados = 
      # cliente.otros_ingresos = 
      # cliente.conyugue_nombre = 
      # cliente.conyugue_ci = 
      # cliente.conyugue_empleado_en = 
      # cliente.conyugue_telefono = 
      # cliente.conyugue_tiempo = 
      # cliente.conyugue_sueldo = 
      # cliente.conyugue_cargo = 
      cliente.save
      cliente
    end

end

end
