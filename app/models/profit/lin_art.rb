class Profit::LinArt < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'lin_art'
  # attr_accessible :title, :body
end
