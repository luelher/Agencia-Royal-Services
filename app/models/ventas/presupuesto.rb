class Ventas::Presupuesto < ActiveRecord::Base
  self.table_name = 'presupuestos'

  attr_accessible :cliente_id, :instalacion, :inicial, :giros, :cuota, :giros_especiales, :cuota_especial, :vendedor, :aprobado_por
  attr_accessible :detalle_presupuesto, :allow_destroy => true
  # attr_accessible :producto, :cantidad, :total
  
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

  def producto
    @producto
  end

  def producto(producto)
    @producto |= producto
  end

  def cantidad
    @cantidad
  end

  def cantidad(cantidad)
    @cantidad |= cantidad
  end

  def total(total)
    @total |= total
  end

end