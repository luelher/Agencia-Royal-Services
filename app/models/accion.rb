class Accion < ActiveRecord::Base
  set_table_name 'acciones'
  # attr_accessible :title, :body
  def name
    'Acciones'
  end


end
