class AddUserIdToVentasSeguimiento < ActiveRecord::Migration
  def change
    add_column :seguimiento, :user_id, :integer
  end
end
