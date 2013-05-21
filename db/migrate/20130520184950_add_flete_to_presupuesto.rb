class AddFleteToPresupuesto < ActiveRecord::Migration
  def change
    add_column :presupuestos, :flete, :float, :default => 0
  end
end
