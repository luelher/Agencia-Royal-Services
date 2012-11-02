class CreateCobranzaNotificacions < ActiveRecord::Migration
  def change
    create_table :notificaciones do |t|
      t.integer :mes_desde
      t.integer :mes_hasta
      t.date :fecha
      t.string :resultado
      t.timestamps
    end
  end
end
