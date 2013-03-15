class Profit::RengCac < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'reng_cac'  
  # attr_accessible :title, :body

  belongs_to :cotiz_c, {:class_name => "Profit::CotizC", :inverse_of => :reng_cac, :foreign_key => 'fact_num', :primary_key => 'fact_num'}
end
