class Profit::Cobro < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'cobros'
  # attr_accessible :title, :body

  #has_many :docum_cc, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :reng_cob, {:foreign_key => 'cob_num', :primary_key => 'cob_num'}
end
