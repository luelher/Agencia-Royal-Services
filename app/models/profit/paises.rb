class Profit::Paises < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'paises'  
  # attr_accessible :title, :body
end
