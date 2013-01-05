class Sms::Outbox < ActiveRecord::Base
  # establish_connection Rails.env  
  self.table_name = 'outbox'
  # attr_accessible :title, :body
end
