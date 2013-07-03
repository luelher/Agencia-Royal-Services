class CreateMunicipios < ActiveRecord::Migration
  def change
    create_table :municipios do |t|
      t.string :descripcion
      t.integer :estado_id

      t.timestamps
    end
  end
end
