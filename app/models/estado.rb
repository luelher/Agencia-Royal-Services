class Estado < ActiveRecord::Base
  has_many :municipio
  attr_accessible :descripcion
end
