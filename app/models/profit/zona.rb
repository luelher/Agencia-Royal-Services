class Profit::Zona < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'zona'
  # attr_accessible :title, :body

  has_many :cliente, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}
    
end
