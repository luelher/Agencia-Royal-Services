class CreateFeriados < ActiveRecord::Migration
  def change
    create_table :feriados do |t|
      t.date :fecha
      t.string :descripcion 
      t.timestamps
    end
  end
end
