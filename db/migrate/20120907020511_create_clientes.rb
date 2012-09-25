class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string   "nombre",    :limit => 50, :null => false
      t.integer  "ci", :null => false
      t.string   "nacionalidad",    :limit => 50, :null => false
      t.string   "estado_civil",    :limit => 20, :null => false
      t.string   "direccion",    :limit => 500, :null => false
      t.string   "telefono",    :limit => 15, :null => false
      t.string   "empleado_en",    :limit => 50, :null => true
      t.string   "direccion_trabajo",    :limit => 500, :null => true
      t.string   "telefono_trabajo",    :limit => 15, :null => true
      t.integer  "tiempo",    :null => true
      t.integer  "sueldo",    :null => true
      t.string   "cargo",    :limit => 50, :null => true
      t.integer  "subordinados",    :null => true
      t.string   "otros_ingresos",    :limit => 50, :null => true
      t.string   "conyugue_nombre",    :limit => 50, :null => true
      t.integer  "conyugue_ci", :null => true
      t.string   "conyugue_empleado_en",    :limit => 50, :null => true
      t.string   "conyugue_telefono",    :limit => 15, :null => true
      t.integer  "conyugue_tiempo",    :null => true
      t.integer  "conyugue_sueldo",    :null => true
      t.string   "conyugue_cargo",    :limit => 50, :null => true
      t.timestamps
    end
    add_index(:clientes, [:ci, :nombre], :name => 'index_clientes' )
  end

  def self.down
    drop_table :clientes
  end
end
