class Sms::Outbox < ActiveRecord::Base
  # establish_connection Rails.env  
  self.table_name = 'outbox'
  attr_accessible :number, :text, :insertdate, :co_cli, :fec_venc
end
