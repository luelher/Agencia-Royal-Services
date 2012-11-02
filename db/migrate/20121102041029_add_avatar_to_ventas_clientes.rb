class AddAvatarToVentasClientes < ActiveRecord::Migration
  def change
    add_attachment :clientes, :avatar
  end
end
