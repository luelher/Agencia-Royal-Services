class Sms::Inbox < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name = 'inbox'
  # attr_accessible :title, :body
end
