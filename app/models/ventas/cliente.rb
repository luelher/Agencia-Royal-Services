class Ventas::Cliente < ActiveRecord::Base
  
  attr_accessible :nombre, :ci, :nacionalidad, :estado_civil, :direccion, :telefono, :empleado_en, :direccion_trabajo, :telefono_trabajo, :tiempo, :sueldo, :cargo, :subordinados, :otros_ingresos, :conyugue_nombre, :conyugue_ci, :conyugue_empleado_en, :conyugue_telefono, :conyugue_tiempo, :conyugue_sueldo, :conyugue_cargo

  validates :nombre, :presence => true
  validates :ci, :presence => true
  validates :nacionalidad, :presence => true
  validates :estado_civil, :presence => true
  validates :direccion, :presence => true
  validates :telefono, :presence => true

end
