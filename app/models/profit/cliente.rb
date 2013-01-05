class Profit::Cliente < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'clientes'
  attr_accessible :co_cli, :cli_des

  has_many :docum_cc, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :zona, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}

  has_many :factura, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :condicio, {:through => :factura}

  has_one :carta, {:foreign_key => 'co_cli', :primary_key => 'co_cli', :class_name => "Cobranza::Carta"}

  def to_string
    self.co_cli.strip + ' - ' + self.cli_des.strip unless self.co_cli.nil?
  end

end
