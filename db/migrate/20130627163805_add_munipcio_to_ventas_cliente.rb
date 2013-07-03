class AddMunipcioToVentasCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :parroquia_id, :integer

    add_column :clientes, :referencia_uno_nombre, :string
    add_column :clientes, :referencia_uno_parentesco, :string
    add_column :clientes, :referencia_uno_direccion, :string
    add_column :clientes, :referencia_uno_telefono, :string
    add_column :clientes, :referencia_uno_observaciones, :string

    add_column :clientes, :referencia_dos_nombre, :string
    add_column :clientes, :referencia_dos_parentesco, :string
    add_column :clientes, :referencia_dos_direccion, :string
    add_column :clientes, :referencia_dos_telefono, :string
    add_column :clientes, :referencia_dos_observaciones, :string

    add_column :clientes, :referencia_tres_nombre, :string
    add_column :clientes, :referencia_tres_parentesco, :string
    add_column :clientes, :referencia_tres_direccion, :string
    add_column :clientes, :referencia_tres_telefono, :string
    add_column :clientes, :referencia_tres_observaciones, :string


    add_column :presupuestos, :comercial_uno_nombre,  :string
    add_column :presupuestos, :comercial_uno_estado,  :boolean
    add_column :presupuestos, :comercial_uno_ano, :string
  
    add_column :presupuestos, :comercial_dos_nombre,  :string
    add_column :presupuestos, :comercial_dos_estado,  :boolean
    add_column :presupuestos, :comercial_dos_ano, :string
  
    add_column :presupuestos, :fiador_nombre,  :string
    add_column :presupuestos, :fiador_ci,  :string
    add_column :presupuestos, :fiador_nacionalidad,  :string
    add_column :presupuestos, :fiador_estado_civil,  :string
    add_column :presupuestos, :fiador_direccion,  :string
    add_column :presupuestos, :fiador_telefono,  :string
    add_column :presupuestos, :fiador_empleado_en,  :string
    add_column :presupuestos, :fiador_direccion_trabajo,  :string
    add_column :presupuestos, :fiador_tiempo_servicio,  :string
    add_column :presupuestos, :fiador_cargo,  :string
    add_column :presupuestos, :fiador_telefono_trabajo,  :string
    add_column :presupuestos, :fiador_sueldo,  :string
    add_column :presupuestos, :fiador_email, :string
    
    add_column :presupuestos, :fiador_comercial_uno_nombre,  :string
    add_column :presupuestos, :fiador_comercial_uno_estado,  :boolean
    add_column :presupuestos, :fiador_comercial_uno_ano, :string
    
    add_column :presupuestos, :fiador_comercial_dos_nombre,  :string
    add_column :presupuestos, :fiador_comercial_dos_estado,  :boolean
    add_column :presupuestos, :fiador_comercial_dos_ano, :string

  end
end
