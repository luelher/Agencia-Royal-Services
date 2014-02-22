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

  actual_user = nil

  attr_accessible :cliente_id, :motivo, :observacion, :usuario, :plazo_pago, :factura, :user_id

  belongs_to :cliente, :class_name => "Ventas::Cliente"

  belongs_to :user

  validates :cliente_id, :presence => true
  validates :motivo, :presence => true
  validate :verificar_usuario,  on: :destroy
  validate :verificar_usuario,  on: :update

  def actual_user(u)
    @actual_user = u
  end

  def verificar_usuario
    if @actual_user
      unless usuario == @actual_user.name
        errors.add(:user, "El registro no puede ser modificado ni eliminado por otro usuario al original")
      end
    end
  end

private


end
