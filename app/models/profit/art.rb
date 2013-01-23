class Profit::Art < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'art'
  attr_accessible :co_art, :art_des, :prec_vta5, :stock_act
  has_one :detalle_presupuesto, {:foreign_key => 'co_art', :primary_key => 'codigo', :class_name => "Ventas::DetallePresupuesto"}

  def to_string
    self.co_art.strip + " - " + self.art_des.strip
  end

  def url_photo
    '/img/300x300.gif'
  end
  def url_small_photo
    '/img/60x60.gif'
  end

end
