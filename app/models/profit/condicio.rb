class Profit::Condicio < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'condicio'
  # attr_accessible :title, :body

  has_many :factura, {:foreign_key => 'forma_pag', :primary_key => 'co_cond'}

end
