class Cobranza::Experiencia < ActiveRecord::Base
  # establish_connection Rails.env
  self.table_name = 'experiencia'
  attr_accessible :desde, :resultado

  before_save :calcular_experiencias

  validates :desde, :presence => true

  def self.calcular_experiencias(el_limit, el_offset)
    archivo = "experiencia" + Time.now.strftime("%Y-%m-%d") + ".csv"
    dir_file = "public/uploads/" + archivo
    file = File.open(dir_file, 'a')

    facturas = Profit::Factura.all_facturas.includes(:cliente).limit(el_limit).offset(el_offset)
    facturas.each_with_index do |f, i|
      f.generar_resumen Time.now
      line = [f.cliente.co_cli, f.cliente.cli_des, "", f.cliente.telefonos, "", "", f.nro_doc_cfxg, f.fec_emis.strftime("%d/%m/%Y"), f.monto_total, f.pago_mensual, f.count_giros, f.fecha_cancelacion.nil? ? '' : f.fecha_cancelacion.strftime("%d/%m/%Y"), f.experiencia].join("\t") unless f.detalle_giros.nil?
      file.puts line
      GC.start if (i % 1000) == 0
    end

    # exp = Cobranza::Experiencia.new
    # exp.desde = Date.today
    # exp.resultado = archivo 
    # exp.save
    # exp
    file.close
    true
  end

  def to_string
    self.desde
  end

end
