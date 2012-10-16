class Sms::Outbox < ActiveRecord::Base
  set_table_name 'outbox'
  # attr_accessible :title, :body
end
