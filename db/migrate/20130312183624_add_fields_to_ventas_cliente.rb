class AddFieldsToVentasCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :telefono2, :string
    add_column :clientes, :telefono3, :string
    add_column :clientes, :email, :string
    add_column :clientes, :direccion2, :string
  end
end
