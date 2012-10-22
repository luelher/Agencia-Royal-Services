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

  def calcular_experiencias
    archivo = "experiencia" + self.desde.to_s + ".csv"
    dir_file = "public/uploads/" + archivo
    file = File.open(dir_file, 'w')

    facturas = Profit::Factura.all_facturas.includes(:cliente)
    facturas.each_with_index do |f, i|
      f.generar_resumen self.desde
      line = [f.cliente.co_cli, f.cliente.cli_des, f.cliente.telefonos, "", f.nro_doc_cfxg, f.fec_emis.strftime("%d/%m/%Y"), f.monto_total, f.pago_mensual, f.count_giros, f.fecha_cancelacion.nil? ? '' : f.fecha_cancelacion.strftime("%d/%m/%Y"), f.experiencia].join("\t") unless f.detalle_giros.nil?
      file.puts line
      GC.start if (i % 1000) == 0
    end
    self.resultado = archivo 
  end

end
