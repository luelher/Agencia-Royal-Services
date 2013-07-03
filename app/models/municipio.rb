class Municipio < ActiveRecord::Base

  belongs_to :estado
  has_many :parroquias

  attr_accessible :descripcion, :estado_id
end
