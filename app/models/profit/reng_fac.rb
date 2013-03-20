class Profit::RengFac < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'reng_fac'  
  # attr_accessible :title, :body

  has_one :factura, {:foreign_key => 'fact_num', :primary_key => 'fact_num'}
  has_one :art, {:foreign_key => 'co_art', :primary_key => 'co_art'}

end
