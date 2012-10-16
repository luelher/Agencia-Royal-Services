class CreateProfitCobros < ActiveRecord::Migration
  def change
    create_table :profit_cobros do |t|

      t.timestamps
    end
  end
end
