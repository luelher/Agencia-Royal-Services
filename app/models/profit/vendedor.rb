class Profit::Vendedor < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'vendedor'

end
