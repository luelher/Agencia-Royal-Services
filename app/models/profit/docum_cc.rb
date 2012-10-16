class Profit::DocumCc < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'docum_cc'
  #attr_accessible :cliente, :fecha, :factura, :articulo, :estado  

  has_one :cliente, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :factura, {:foreign_key => 'fact_num', :primary_key => 'nro_doc'}

  has_one :condicio, {:through => :factura}

  has_one :reng_cob, {:foreign_key => 'doc_num', :primary_key => 'nro_doc'}

  # " FROM " +
  # " ((docum_cc INNER JOIN (clientes INNER JOIN zona ON clientes.co_zon=zona.co_zon ) ON docum_cc.co_cli = clientes.co_cli) " +
  # " INNER JOIN (factura INNER JOIN condicio ON factura.forma_pag = condicio.co_cond) ON docum_cc.nro_doc = factura.fact_num) " +
  # " WHERE " +
  # " docum_cc.tipo_doc = 'FACT' AND condicio.dias_cred > 0 " +
  scope :all_facturas, joins(:cliente, :factura, :condicio).where("docum_cc.tipo_doc = 'FACT' AND condicio.dias_cred > 0").order("docum_cc.nro_doc ASC")

  scope :giros, lambda { |fact| joins(:cliente).where("Docum_cc.nro_orig = ? AND docum_cc.tipo_doc = 'GIRO' ", fact) unless fact.nil? }

  def nro_doc_cfxg
    # docum_cc.tipo_doc = 'CFXG' AND docum_cc.fec_emis = '" + Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString()).ToString("yyMMdd") + "' AND docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "'
    factura_cfxg = Profit::DocumCc.where(:tipo_doc => 'CFXG', :fec_emis => fec_emis, :co_cli => co_cli).first
    if factura_cfxg
      factura_cfxg.nro_doc
    else
      nil
    end
  end

  def detalles_giros
    @giros = giros(nro_doc_cfxg)
  end

  def dias
    @dias ||= (((Time.now - fec_venc) / 3600 ) / 24).to_i
  end

  def fecha_ultimo_cobro
    reng_cob.cobro.fec_cob if not reng_cob.nil?
  end


end
