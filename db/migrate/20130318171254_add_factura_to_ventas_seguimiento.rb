class AddFacturaToVentasSeguimiento < ActiveRecord::Migration
  def change
    add_column :seguimientos, :factura, :string
  end
end
