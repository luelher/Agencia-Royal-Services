class AddRowguidToPresupuesto < ActiveRecord::Migration
  def change
    add_column :presupuestos, :rowguid, :string
  end
end
