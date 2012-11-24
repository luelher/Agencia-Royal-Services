class Ventas::Presupuesto < ActiveRecord::Base

  attr_accessible :cliente_id, :instalacion, :inicial, :giros, :giros_especiales, :vendedor, :aprobado_por
  attr_accessible :detalle_presupuesto_attributes, :allow_destroy => true
  belongs_to :cliente
  has_many :detalle_presupuesto, :inverse_of => :presupuesto

  before_save :inicializar_save
  after_save :crear_presupuesto_profit

  accepts_nested_attributes_for :detalle_presupuesto, :allow_destroy => true

  validates :detalle_presupuesto, :instalacion, :inicial, :giros, :giros_especiales,  :presence => true

  rails_admin do
    edit do
      field :cliente do
      end
      field :detalle_presupuesto do

      end
      field :instalacion
      field :inicial
      field :giros
      field :giros_especiales
      field :vendedor do
        hide
      end
      field :aprobado_por do
        hide
      end
      field :cliente_id do
        hide
      end
    end
  end

  def inicializar_save
    self.vendedor = '17637071'
  end

  def crear_presupuesto_profit
  end

end
