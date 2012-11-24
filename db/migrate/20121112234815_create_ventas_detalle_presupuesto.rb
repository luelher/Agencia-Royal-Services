class CreateVentasDetallePresupuesto < ActiveRecord::Migration
  def change
    create_table :detalles_presupuestos do |t|
      t.integer "presupuesto_id", :null => false
      t.string "codigo",    :limit => 50, :null => false
      t.float "cantidad",    :null => false
      t.float  "precio",    :null => false
      t.float "total" ,    :null => false 
      t.timestamps
    end
  end
end
