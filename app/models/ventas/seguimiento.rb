class Ventas::Seguimiento < ActiveRecord::Base
  self.table_name = 'seguimientos'
  MOTIVOS = [
	['Llamada Telefonica'],
	['Llamada Telefonica de Cliente'],
	['SMS Enviado'],
	['Paso por Oficina'],
	['Correo Electronico'],
	['Carta Enviada'],
	['Carta Ultimo Aviso'],
	['Carta Legal'],
	['Correo Electronico'],
	['Correo Electronico']
        ]
  attr_accessible :cliente_id, :motivo, :observacion, :usuario, :plazo_pago, :factura, :user_id

  belongs_to :cliente, :class_name => "Ventas::Cliente"

  has_one :user

  validates :cliente_id, :presence => true
  validates :motivo, :presence => true

  before_validation :agregar_usuario

  def agregar_usuario # Agregar el nombre del usuario

  end

end
