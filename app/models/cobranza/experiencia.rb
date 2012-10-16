class Cobranza::Experiencia < ActiveRecord::Base
  self.table_name = 'experiencia'
  attr_accessible :desde, :resultado

  before_save :calcular_experiencias

  validates :desde, :presence => true

  rails_admin do
    list do
      field :desde
      field :resultado
      field :created_at do
        hide
      end
    end    
    edit do
      field :desde
      field :resultado do
        partial "download"
      end
      field :created_at do
        hide
      end
    end    
  end

  private

  def calcular_experiencias
    dir_file = "public/uploads/" + archivo
    file = File.open(dir_file, 'w')

    facturas = Profit::Factura.all_facturas
    facturas.each do |f|
      f.generar_resumen self.desde
      line = [f.cliente.co_cli, f.cliente.cli_des, f.cliente.telefonos, "", f.nro_doc_cfxg, f.fec_emis, f.monto_total, f.pago_mensual, f.detalle_giros.count, f.fecha_cancelacion, f.experiencia].join("\t")
      file.puts line
    end
    archivo = "experiencia" + self.desde.to_s + ".csv"
    self.resultado = archivo 
  end

end
