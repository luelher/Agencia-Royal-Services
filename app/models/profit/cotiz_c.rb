class Profit::CotizC < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'cotiz_c'
  # attr_accessible :title, :body

  has_many :reng_cac, {:class_name => "Profit::RengCac", :inverse_of => :cotiz_c, :foreign_key => 'fact_num', :primary_key => 'fact_num'}  

end
