class ClienteProfit < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  set_table_name 'clientes'
  #attr_accessible :cliente, :fecha, :factura, :articulo, :estado
end
