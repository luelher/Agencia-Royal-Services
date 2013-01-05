class Profit::Art < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'art'
  attr_accessible :co_art, :art_des
  has_one :detalle_presupuesto, {:foreign_key => 'co_art', :primary_key => 'codigo', :class_name => "Ventas::DetallePresupuesto"}

  def to_string
    self.co_art.strip + " - " + self.art_des.strip
  end

end
