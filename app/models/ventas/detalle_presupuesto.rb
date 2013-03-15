class Ventas::DetallePresupuesto < ActiveRecord::Base
  self.table_name = 'detalles_presupuestos'

  belongs_to :art, {:foreign_key => 'codigo', :primary_key => 'co_art', :class_name => "Profit::Art"}

  belongs_to :presupuesto, {:class_name => "Ventas::Presupuesto", :inverse_of => :detalle_presupuesto}
  attr_accessible :codigo, :cantidad, :precio

  accepts_nested_attributes_for :presupuesto

  validates :codigo, :cantidad, :precio, :presence => true

  before_save :inicializar_save

  def inicializar_save
    self.total = self.cantidad * self.precio unless self.cantidad.nil? or self.precio.nil?
  end

  def to_string
    self.codigo
  end

  def total
    self.cantidad * self.precio unless self.cantidad.nil? or self.precio.nil?
  end
  
end
