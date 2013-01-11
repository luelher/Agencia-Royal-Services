class Ventas::Seguimiento < ActiveRecord::Base
  self.table_name = 'seguimientos'
  attr_accessible :cliente_id, :motivo, :observacion, :usuario

  belongs_to :cliente, :class_name => "Ventas::Cliente"

  validates :cliente_id, :presence => true
  validates :motivo, :presence => true

  before_validation :agregar_usuario

  def agregar_usuario
    self.usuario = "Generico"
  end


end
