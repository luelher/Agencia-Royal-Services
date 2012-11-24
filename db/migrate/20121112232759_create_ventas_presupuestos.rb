class CreateVentasPresupuestos < ActiveRecord::Migration
  def change
    create_table :presupuestos do |t|
      t.integer "cliente_id", :null => false
      t.string "instalacion",    :limit => 100, :null => false
      t.float  "inicial",    :null => false
      t.integer "giros" ,    :null => false 
      t.integer "giros_especiales" ,    :null => false
      t.string "vendedor"  ,    :limit => 100, :null => false
      t.string "aprobado_por",    :limit => 100, :null => true
      t.timestamps
    end
  end
end
