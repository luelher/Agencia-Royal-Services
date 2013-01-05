class Cobranza::Opcion < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name =  'opciones'
  # attr_accessible :title, :body
end
