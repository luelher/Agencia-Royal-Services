class CreateAccions < ActiveRecord::Migration
  def change
    create_table :accions do |t|

      t.timestamps
    end
  end
end
