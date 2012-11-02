class Cobranza::Carta < ActiveRecord::Base
  set_table_name 'cartas'
  attr_accessible :co_zon, :co_cli, :entregado

  after_initialize :init

  validates :co_zon, :presence => true
  validates :co_cli, :presence => true

  validate :exist_cliente
 
  def exist_cliente
    errors.add(:co_cli) unless Profit::Cliente.find_by_co_cli(self.co_cli)
  end

  def init
    self.entregado = Time.now
  end

  rails_admin do
    list do
      field :co_zon
      field :co_cli      
      field :entregado, :datetime
    end
    edit do
      field :co_zon do
        partial "zona"
      end
      field :co_cli
    end    
  end

end

