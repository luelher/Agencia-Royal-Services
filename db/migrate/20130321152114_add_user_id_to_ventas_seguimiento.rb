class AddUserIdToVentasSeguimiento < ActiveRecord::Migration
  def change
    add_column :seguimientos, :user_id, :integer
  end
end
