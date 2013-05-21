class AddVendedorToPresupuesto < ActiveRecord::Migration
  def change
    add_column :presupuestos, :vendedor_id, :string
  end
end
