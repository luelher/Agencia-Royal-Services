class CreateProfitVendedors < ActiveRecord::Migration
  def change
    create_table :profit_vendedors do |t|

      t.timestamps
    end
  end
end
