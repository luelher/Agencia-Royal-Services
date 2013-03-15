class Profit::ParEmp < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'par_emp'  
  # attr_accessible :title, :body
end
