class Profit::Zona < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'zona'
  # attr_accessible :title, :body

  has_many :cliente, {:foreign_key => 'co_zon', :primary_key => 'co_zon'}
  has_one :carta, {:foreign_key => 'co_zon', :primary_key => 'co_zon', :class_name => "Cobranza::Carta"}

  def to_string
    self.co_zon + " - " + zon_des unless self.co_zon.nil?
  end
    
end
