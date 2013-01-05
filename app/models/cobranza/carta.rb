class Cobranza::Carta < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name = 'cartas'
  attr_accessible :co_zon, :co_cli, :entregado

  after_initialize :init

  validates :co_zon, :presence => true
  validates :co_cli, :presence => true

  belongs_to :zona, {:foreign_key => 'co_zon', :primary_key => 'co_zon', :class_name => "Profit::Zona"}
  belongs_to :cliente, {:foreign_key => 'co_cli', :primary_key => 'co_cli', :class_name => "Profit::Cliente"}

  validate :exist_cliente
 
  def exist_cliente
    errors.add(:co_cli) unless Profit::Cliente.find_by_co_cli(self.co_cli)
  end

  def init
    self.entregado = Time.now
  end

  def to_string
    self.co_zon
  end

end
