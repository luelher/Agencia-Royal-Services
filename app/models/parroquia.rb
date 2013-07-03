class Parroquia < ActiveRecord::Base

  belongs_to :municipio
  belongs_to :cliente, {:class_name => "Ventas::Cliente"}
  attr_accessible :descripcion, :municipio_id
end
