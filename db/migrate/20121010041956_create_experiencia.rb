class CreateExperiencia < ActiveRecord::Migration
  def change
    create_table :experiencia do |t|
      t.date :desde
      t.string :resultado

      t.timestamps
    end
  end
end
