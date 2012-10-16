class Profit::RengCob < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'reng_cob'
  # attr_accessible :title, :body

  has_one :cobro, {:foreign_key => 'cob_num', :primary_key => 'cob_num'}

  #has_one :zona, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}
  # attr_accessible :title, :body
end
