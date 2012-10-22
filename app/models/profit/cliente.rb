class Profit::Cliente < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'clientes'
  # attr_accessible :title, :body

  has_many :docum_cc, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :zona, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}

  belongs_to :factura, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

end
