class Sms::Multipartinbox < ActiveRecord::Base
  # establish_connection Rails.env  
  self.table_name = 'multipartinbox'
  # attr_accessible :title, :body
end
