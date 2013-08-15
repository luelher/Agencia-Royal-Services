class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :month 
      t.integer :year 
      t.float :sales
      t.float :billing

      t.timestamps
    end
  end
end
