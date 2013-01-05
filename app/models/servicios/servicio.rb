class Servicios::Servicio < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name = "servicios"
  attr_accessible :cliente, :situacion, :observacion, :fecha, :factura
end
