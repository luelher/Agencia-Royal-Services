class Servicios::Accion < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name = 'acciones'
  # attr_accessible :title, :body
  def name
    'Acciones'
  end


end
