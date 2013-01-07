class CreateVentasPresupuestos < ActiveRecord::Migration
  def change
    create_table :ventas_presupuestos do |t|

      t.timestamps
    end
  end
end
