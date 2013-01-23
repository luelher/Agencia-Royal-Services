class CreateVentasPresupuestos < ActiveRecord::Migration
  def change
    create_table :presupuestos do |t|
      t.integer "cliente_id", :null => false
      t.string "instalacion", :limit => 50, :null => false
      t.float "inicial", :null => false
      t.integer "giros", :null => false
      t.float "cuota", :null => false
      t.integer "giros_especiales", :null => false
      t.float "cuota_especial", :null => false
      t.integer "vendedor", :null => false
      t.integer "aprobado_por", :null => true
      t.timestamps
    end
  end
end
