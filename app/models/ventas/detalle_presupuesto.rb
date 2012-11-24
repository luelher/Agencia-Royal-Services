class Ventas::DetallePresupuesto < ActiveRecord::Base
  self.table_name = 'detalles_presupuestos'

  belongs_to :art, {:foreign_key => 'codigo', :primary_key => 'co_art', :class_name => "Profit::Art"}

  belongs_to :presupuesto, :inverse_of => :detalle_presupuesto
  attr_accessible :codigo, :cantidad, :precio

  validates :codigo, :cantidad, :precio, :presence => true

  before_save :inicializar_save

  rails_admin do
    edit do
      field :art do
      end
      field :codigo do
        partial :articulo
      end
      field :cantidad
      field :precio
      field :presupuesto_id do
        hide
      end
      field :total do
        hide
      end
    end
  end  

  def inicializar_save
    self.total = self.cantidad * self.precio unless self.cantidad.nil? or self.precio.nil?
  end
  
end
