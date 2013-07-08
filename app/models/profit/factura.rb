class Profit::Factura < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'factura'

  after_initialize :init



  has_many :docum_cc, {:foreign_key => 'nro_doc', :primary_key => 'fact_num'}

  has_many :reng_fac, {:foreign_key => 'fact_num', :primary_key => 'fact_num'}

  has_one :vendedor, {:foreign_key => 'co_ven', :primary_key => 'co_ven'}

  has_one :condicio, {:foreign_key => 'co_cond', :primary_key => 'forma_pag'}

  has_one :cliente, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  has_one :cliente_venta, {:foreign_key => 'ci', :primary_key => 'co_cli', :class_name => 'Ventas::Cliente'}

  scope :all_facturas, joins(:cliente, :docum_cc, :condicio).where("docum_cc.tipo_doc = ? AND condicio.dias_cred > ? AND factura.fec_venc >= DATEADD(YEAR, -3, GETDATE())", 'FACT', 0).order("docum_cc.nro_doc ASC")

  scope :all_facturas_of_client, lambda { |client| joins(:cliente, :docum_cc, :condicio).where("docum_cc.tipo_doc = 'FACT' AND condicio.dias_cred > 0 and clientes.co_cli = ? and factura.fec_emis > '2011-01-01'",client).order("docum_cc.nro_doc ASC") }

  scope :solo_facturas_creditos, joins(:cliente, :docum_cc, :condicio).where("docum_cc.tipo_doc = ? AND condicio.dias_cred > ? ", 'FACT', 0).order("docum_cc.nro_doc ASC")  

  scope :solo_facturas_creditos_by_dias_vencidos, lambda { |dias_desde, dias_hasta| joins(:cliente, :docum_cc, :condicio).where("factura.fec_emis > '2012-01-01' and docum_cc.tipo_doc = ? AND condicio.dias_cred > ? AND (SELECT TOP (1) DATEDIFF(DAY, dcc.fec_venc, GETDATE()) FROM [docum_cc] dcc WHERE (dcc.observa like ('%FACT ' + Cast(factura.fact_num as nvarchar(4000)) + '%')  AND dcc.tipo_doc='GIRO' and dcc.saldo > 0.0 and dcc.fec_venc <= GETDATE()) ORDER BY dcc.fec_venc ASC) BETWEEN ? and ? ", 'FACT', 0, dias_desde, dias_hasta).order("docum_cc.nro_doc ASC")  }

# SELECT TOP (1) DATEDIFF(DAY, dcc.fec_venc, GETDATE()) FROM [docum_cc] dcc WHERE (dcc.observa like '%FACT 24919%' AND dcc.tipo_doc='GIRO' and dcc.saldo > 0.0 and dcc.fec_venc <= GETDATE()) ORDER BY dcc.fec_venc ASC

  def init
    @giros=nil
    @pago_mensual=nil
    @monto_total=nil
    @saldo=nil
    @giros_sin_cancelar=0
    @saldo_restante=0.0
    @giros_vencidos_sin_cancelar=0
    @saldo_vencido_sin_cancelar=0.0    
    @experiencia=0
    @fecha_cancelacion=nil
    @fecha_ultimo_pago=nil
    @dias_sin_cancelar=0
    @nro_doc_cfxg=nil
    @count_giros=nil
    @dias_desde_ultimo_pago=0
    @factura_cfxg=nil
  end


  def nro_doc_cfxg
    if @nro_doc_cfxg.nil?
      # docum_cc.tipo_doc = 'CFXG' AND docum_cc.fec_emis = '" + Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString()).ToString("yyMMdd") + "' AND docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "'
      factura_cfxg = Profit::DocumCc.where(:tipo_doc => 'CFXG', :fec_emis => fec_emis, :co_cli => co_cli).first
      @factura_cfxg = factura_cfxg
      if factura_cfxg
        @nro_doc_cfxg = factura_cfxg.nro_doc
      else
        nil
      end
    else
      @nro_doc_cfxg
    end
  end

  def pago_mensual
    @pago_mensual ||= @giros.sort_by{|item| item.monto_net}.first.monto_net unless count_giros.zero? unless count_giros.nil?
  end

  def monto_total
    @monto_total ||= @giros.inject(0){|sum,item| sum + item.monto_net} unless count_giros.zero? unless count_giros.nil?
  end

  def saldo
    @saldo ||= @giros.inject(0){|sum,item| sum + item.saldo} unless count_giros.zero? unless count_giros.nil?
  end

  def detalle_giros
    fac = nro_doc_cfxg
    @giros ||= Profit::DocumCc.giros(fac) unless fac.nil?
    @count_giros ||= @giros.length.to_i unless fac.nil?
  end

  def count_giros
    @count_giros
  end

  def cancelado?
    if saldo.nil?
      true
    else
      saldo.zero?
    end
  end

  def experiencia
    @experiencia
  end

  def giros_vencidos_sin_cancelar
    @giros_vencidos_sin_cancelar
  end

  def saldo_vencido_sin_cancelar
    @saldo_vencido_sin_cancelar
  end

  def fecha_cancelacion
    @fecha_cancelacion
  end

  def saldo_restante
    @saldo_restante
  end

  def los_giros
    @giros
  end

  def generar_resumen(la_fecha)
    experiencia=false
    cuota=0
    detalle_giros if @giros.nil?
    unless @giros.nil?
      @giros.each do |g|
        if g.saldo > 0.0
          @giros_sin_cancelar+=1
          @saldo_restante = g.saldo
          if g.fec_venc < la_fecha
            @giros_vencidos_sin_cancelar += 1
            @saldo_vencido_sin_cancelar += g.saldo
          end
        end

        cuota += 1

        if (g.dias < 0 || g.saldo != 0.0) && !experiencia
          if g.dias < 0
            @experiencia = 0
          end
          if g.dias >= 0 && g.dias < 30
            @experiencia = 2
          end
          if g.dias >= 30 && g.dias < 60
            @experiencia = 3
          end
          if g.dias >= 60 && g.dias < 90
            @experiencia = 4
          end
          if g.dias >= 90 && g.dias < 120
            @experiencia = 5
          end
          if g.dias >= 120 && g.dias < 365
            @experiencia = 20
          end
          if g.dias >= 365
            @experiencia = 21
          end
          if g.dias < 0 && g.fec_emis.month != la_fecha.month && g.fec_emis.year != la_fecha.year
            @experiencia = 1
          end
          experiencia = true
        else
          if !experiencia
            @experiencia = 1
            if cuota === count_giros && g.saldo == 0.0
              @fecha_cancelacion = g.fecha_ultimo_cobro
            end
          end
        end
      end

    end
    pagados = nil
    pagados = @giros.find_all{|d| d.saldo < d.monto_net} unless @giros.nil?
    ultimo_giro_pagado = pagados.max_by{|f| f.fec_venc} unless pagados.nil?
    @fecha_ultimo_pago = ultimo_giro_pagado.fecha_ultimo_cobro unless ultimo_giro_pagado.nil?
    @dias_desde_ultimo_pago = (((Time.now - @fecha_ultimo_pago) / 3600 ) / 24).to_i unless @fecha_ultimo_pago.nil?
    true
  end

  def factura?
    if nro_doc_cfxg
      true
    else
      false
    end
  end

  def fecha_ultimo_pago
    @fecha_ultimo_pago
  end

  def dias_desde_ultimo_pago
    @dias_desde_ultimo_pago
  end

  def factura_cfxg
    @factura_cfxg
  end

  def atendido_recientemente?(dias)
    !Ventas::Seguimiento.where("created_at >= ? AND cliente_id = ?",dias.days.ago, self.cliente.co_cli).empty?
  end

  def self.by_cliente(cliente)
    Profit::Factura.solo_facturas_creditos.where('factura.co_cli like ?',"%#{cliente}%") 
  end

  def self.by_plazo_pago(plazo_pago)
    seguimientos = Ventas::Seguimiento.where(:plazo_pago => plazo_pago.to_date)
    clientes = seguimientos.map{|s| s.cliente_id.strip}.uniq
    Profit::Factura.solo_facturas_creditos.where(:co_cli => clientes)
  end

  def self.by_dias_vencidos(desde, hasta, co_lin, co_ven, co_zon)
    sql = "
      SELECT 
        distinct
        dcc.nro_orig,
        max(DATEDIFF(DAY, dcc.fec_venc, GETDATE())) dias_vencidos,
        dcc.observa
      FROM 
        [docum_cc] dcc 
      WHERE 
        dcc.observa like ('%FACT %')  
        AND dcc.tipo_doc='GIRO' 
        and dcc.saldo > 0.0 
        and dcc.fec_venc <= GETDATE() 
        and DATEDIFF(DAY, dcc.fec_venc, GETDATE()) BETWEEN #{desde} and #{hasta}
      group by 
        dcc.nro_orig, dcc.observa
      order by 
        dcc.nro_orig    
    "
    Profit::Factura.search_facturas(sql, co_lin, co_ven, co_zon)
  end

  def self.by_giros_vencidos(giros_desde, giros_hasta, co_lin, co_ven, co_zon)
    sql = "
      select giros_vencidos, observa from 
      (SELECT 
        distinct
        dcc.nro_orig,
        count(dcc.nro_orig) giros_vencidos,
        max(dcc.observa) as observa
      FROM 
        [docum_cc] dcc 
      WHERE 
        dcc.observa like ('%FACT %')  
        AND dcc.tipo_doc='GIRO' 
        and dcc.saldo > 0.0 
        and dcc.fec_venc <= GETDATE() 
      group by 
        dcc.nro_orig) xx
      where xx.giros_vencidos >= #{giros_desde} and xx.giros_vencidos <= #{giros_hasta} "

    Profit::Factura.search_facturas(sql, co_lin, co_ven, co_zon)

  end

  def self.by_fecha_vencidos(vencido_desde, vencido_hasta, co_lin, co_ven, co_zon)
    sql = "
      SELECT 
        distinct
        dcc.nro_orig,
        max(DATEDIFF(DAY, dcc.fec_venc, GETDATE())) dias_vencidos,
        dcc.observa
      FROM 
        [docum_cc] dcc 
      WHERE 
        dcc.observa like ('%FACT %')  
        AND dcc.tipo_doc='GIRO' 
        and dcc.saldo > 0.0 
        and dcc.fec_venc >= '#{vencido_desde}'
        and dcc.fec_venc <= '#{vencido_hasta}'
      group by 
        dcc.nro_orig, dcc.observa
      order by 
        dcc.nro_orig    
    "
    Profit::Factura.search_facturas(sql, co_lin, co_ven, co_zon)

  end

  def cobranza
    Profit::Cobro.historial_by_f self.fact_num
  end

  def historial_cobros
    @h_cobros ||= Profit::Cobro.historial_by_factura self.fact_num
  end
  
  def historial_cobros_giro(giro)
    self.historial_cobros
    cobros = []
    @h_cobros.each do |c|
      c.reng_cob.each do |r|
        r.docum_cc.each do |d|
          if d.observa.include?(" "+ giro.to_s + "/") and d.observa.include?("FACT #{self.fact_num.to_s}") 
            cobros << c
            break
          end
        end
      end
    end
    cobros.uniq
  end

  private
  def self.search_facturas(sql_facturas, co_lin, co_ven, co_zon)
    facts = Profit::DocumCc.connection().select_all(sql_facturas)
    f = facts.map{|f| f["observa"].split("FACT ")[1]}.uniq
    where = Hash.new
    where[:fact_num] = f
    where['art.co_lin'] = co_lin unless co_lin.empty?
    where[:co_ven] = co_ven unless co_ven.empty?
    where['clientes.co_zon'] = co_zon unless co_zon.empty?
    
    Profit::Factura.includes(:cliente => :zona, :docum_cc => {:reng_cob => :cobro }).joins({:reng_fac => :art}, :cliente).where(where).uniq_by{|f| f.id}
  end

end
