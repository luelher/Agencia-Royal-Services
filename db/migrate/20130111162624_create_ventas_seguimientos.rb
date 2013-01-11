class CreateVentasSeguimientos < ActiveRecord::Migration
  def change
    create_table :seguimientos do |t|
      t.string   "cliente_id",    :limit => 50, :null => false
      t.string   "motivo",    :limit => 50, :null => false
      t.string   "observacion",    :limit => 500, :null => true
      t.string   "usuario",    :limit => 50, :null => true
      t.timestamps
    end
  end
end
