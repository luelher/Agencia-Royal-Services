class CreateParroquia < ActiveRecord::Migration
  def change
    create_table :parroquia do |t|
      t.string :descripcion
      t.integer :municipio_id

      t.timestamps
    end
  end
end
