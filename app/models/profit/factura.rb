class Profit::Factura < ActiveRecord::Base
  establish_connection "profit_#{Rails.env}"
  self.table_name = 'factura'

  after_initialize :init

  has_many :docum_cc, {:foreign_key => 'nro_doc', :primary_key => 'fact_num'}

  has_one :condicio, {:foreign_key => 'co_cond', :primary_key => 'forma_pag'}

  has_one :cliente, {:foreign_key => 'co_cli', :primary_key => 'co_cli'}

  scope :all_facturas, joins(:cliente, :docum_cc, :condicio).where("docum_cc.tipo_doc = ? AND condicio.dias_cred > ?", 'FACT', 0).order("docum_cc.nro_doc ASC")

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
    @nro_doc_cfxg=nil
    @count_giros=nil
  end


  def nro_doc_cfxg
    if @nro_doc_cfxg.nil?
      # docum_cc.tipo_doc = 'CFXG' AND docum_cc.fec_emis = '" + Convert.ToDateTime(dt.Rows[i]["FechaE"].ToString()).ToString("yyMMdd") + "' AND docum_cc.co_cli = '" + dt.Rows[i]["CodClie"].ToString() + "'
      factura_cfxg = Profit::DocumCc.where(:tipo_doc => 'CFXG', :fec_emis => fec_emis, :co_cli => co_cli).first
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
    @pago_mensual ||= @giros.sort_by{|item| item.monto_net}.first.monto_net unless count_giros.zero?
  end

  def monto_total
    @monto_total ||= @giros.inject(0){|sum,item| sum + item.monto_net} unless count_giros.zero?
  end

  def saldo
    @saldo ||= @giros.inject(0){|sum,item| sum + item.saldo} unless count_giros.zero?
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
    saldo.zero?
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
    true
  end

  def factura?
    if nro_doc_cfxg
      true
    else
      false
    end
  end

end
