class ChangeTypesVentasCliente < ActiveRecord::Migration
  def up
    change_column :clientes, :latitude, :decimal, :precision => 15, :scale => 10
    change_column :clientes, :longitude, :decimal, :precision => 15, :scale => 10
  end

  def down
  end
end
