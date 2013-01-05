class AddLatitudeAndLongitudeToVentasClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :latitude, :decimal, :precision => 10, :scale => 6
    add_column :clientes, :longitude, :decimal, :precision => 10, :scale => 6
  end
end
