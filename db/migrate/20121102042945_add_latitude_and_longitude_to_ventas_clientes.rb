class AddLatitudeAndLongitudeToVentasClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :latitude, :decimal
    add_column :clientes, :longitude, :decimal
  end
end
