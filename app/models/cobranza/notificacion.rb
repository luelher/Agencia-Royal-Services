class Cobranza::Notificacion < ActiveRecord::Base
  set_table_name 'notificaciones'
  attr_accessible :mes_desde, :mes_hasta, :fecha, :resultado




end
