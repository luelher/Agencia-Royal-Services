class Cobranza::Notificacion < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name =  'notificaciones'
  attr_accessible :mes_desde, :mes_hasta, :fecha, :resultado




end
