class Ventas::Presupuesto < ActiveRecord::Base
  self.table_name = 'presupuestos'

  attr_accessible :cliente_id, :instalacion, :inicial, :giros, :giros_especiales, :vendedor, :aprobado_por
  attr_accessible :detalle_presupuesto_attributes, :allow_destroy => true
  belongs_to :cliente, :class_name => "Ventas::Cliente"
  has_many :detalle_presupuesto, {:class_name => "Ventas::DetallePresupuesto", :inverse_of => :presupuesto}

  before_save :inicializar_save
  after_save :crear_presupuesto_profit

  accepts_nested_attributes_for :detalle_presupuesto, :allow_destroy => true

  validates :detalle_presupuesto, :instalacion, :inicial, :giros, :giros_especiales,  :presence => true

  def inicializar_save
    self.vendedor = '17637071'
  end

  def crear_presupuesto_profit
  end

  def total
    sum = 0
    self.detalle_presupuesto.map{|p| sum  = p.total }
    sum
  end

  def to_string
    self.id
  end

end
