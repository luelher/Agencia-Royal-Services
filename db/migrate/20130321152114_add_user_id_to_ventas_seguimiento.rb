class AddUserIdToVentasSeguimiento < ActiveRecord::Migration
  def change
    add_column :ventas_seguimiento, :user_id, :integer
  end
end
