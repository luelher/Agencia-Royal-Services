class Servicios::Servicio < ActiveRecord::Base
  attr_accessible :cliente, :situacion, :observacion, :fecha, :factura
end
