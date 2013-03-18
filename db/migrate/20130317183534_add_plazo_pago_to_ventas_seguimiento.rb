class AddPlazoPagoToVentasSeguimiento < ActiveRecord::Migration
  def change
    add_column :seguimientos, :plazo_pago, :date
  end
end
