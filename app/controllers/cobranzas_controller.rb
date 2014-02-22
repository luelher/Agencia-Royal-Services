class CobranzasController < ApplicationController
  layout 'intranet'
  before_filter :authenticate_user!


  caches_action :index, :expires_in => 1.day

  def index
    @factura = Profit::Factura.new
    @factura.co_cli = ''
    @facturas = nil
    combos
  end

  def show
    @factura = Profit::Factura.new
    @factura.co_cli = ''

    co_cli = params[:profit_factura][:co_cli]
    dias_desde = params[:dias_vencidos_desde]
    dias_hasta = params[:dias_vencidos_hasta]
    giros_vencidos_desde = params[:giros_vencidos_desde]
    giros_vencidos_hasta = params[:giros_vencidos_hasta]
    co_lin = params[:co_lin]
    co_ven = params[:co_ven]
    co_zon = params[:co_zon]
    @ven_desde = params[:vencidos_desde].first
    @ven_hasta = params[:vencidos_hasta].first  
    plazo_pago = params[:plazo_pago].first
    telefono = params[:telefono].first
    @sin_seguimientos_recientes = params[:recientes].nil? ? false : true
    @sin_pagos_recientes = params[:sin_pagos_recientes].nil? ? false : true



    if !co_cli.empty?
      logger.debug "co_cli"
      @facturas = Profit::Factura.by_cliente co_cli
    elsif dias_desde.to_i >= 0 and dias_hasta.to_i > 0 and dias_desde.to_i <= dias_hasta.to_i
      logger.debug "dias_desde"
      @facturas = Profit::Factura.by_dias_vencidos dias_desde, dias_hasta, co_lin, co_ven, co_zon
    elsif giros_vencidos_desde.to_i > 0 and giros_vencidos_hasta.to_i > 0
      logger.debug "plazo_pago"
      @facturas = Profit::Factura.by_giros_vencidos giros_vencidos_desde, giros_vencidos_hasta, co_lin, co_ven, co_zon
    elsif !@ven_desde.empty? and !@ven_hasta.empty?
      logger.debug "ven_desde"
      @facturas = Profit::Factura.by_fecha_vencidos @ven_desde, @ven_hasta, co_lin, co_ven, co_zon
    elsif !plazo_pago.empty?
      logger.debug "plazo_pago"
      @facturas = Profit::Factura.by_plazo_pago plazo_pago
    elsif !telefono.empty?
      logger.debug "telefonos"
      clientes = Ventas::Cliente.by_telefono telefono
      co_clis = clientes.map{|c| c.ci.to_s }
      logger.debug co_clis.to_s
      @facturas = Profit::Factura.by_clientes co_clis
    else
      @facturas = nil
    end
    
    combos

    respond_to do |format|
      format.html { 
        if params[:commit] == "Buscar"
          render :index 
        else
          render :sms
        end
      }
      format.xls { render :index }
    end    
    
  end

  def update
    if !params[:update][:ci].empty?
      ventas_cliente = Ventas::Cliente.find_by_ci params[:update][:ci]
    else 
      ventas_cliente = Ventas::Cliente.new
    end

    if !params[:update][:co_cli].empty?
      profit_cliente = Profit::Cliente.find_by_co_cli params[:update][:co_cli]
    else 
      profit_cliente = Profit::Cliente.new
    end

    profit_cliente.direc1 = params[:update][:dir1] + " / " + params[:update][:dir2] unless params[:update][:dir1].empty?
    profit_cliente.telefonos = params[:update][:tel1] + " / " + params[:update][:tel2] + " / " + params[:update][:tel3] unless params[:update][:dir1].empty?

    profit_cliente.save

    if ventas_cliente.new_record?
      ventas_cliente = profit_cliente.crear_ventas_cliente
    end

    ventas_cliente.direccion = params[:update][:dir1] unless params[:update][:dir1].empty?
    ventas_cliente.direccion2 = params[:update][:dir2] unless params[:update][:dir2].empty?
    ventas_cliente.telefono = params[:update][:tel1] unless params[:update][:tel1].empty?
    ventas_cliente.telefono2 = params[:update][:tel2] unless params[:update][:tel2].empty?
    ventas_cliente.telefono3 = params[:update][:tel3] unless params[:update][:tel3].empty?

    ventas_cliente.save

    render :text => "alert('Cliente Actualizado')",
         :content_type => "text/javascript"
  end

  def historico
    @cobros = []
    @cobros = Profit::Cobro.historial_by_f params[:fac_num] if params[:fac_num]
    @cobros = Profit::Cobro.historial_by_c params[:co_cli] if params[:co_cli]
    
    @cliente = nil
    @cliente = @cobros[0].cliente unless @cobros.empty?
  end

  def experiencias

    @facturas = Profit::Factura.all_facturas.includes(:cliente) if request.format == "text/plain"

    respond_to do |format|
      format.html { render :experiencias }
      format.txt { render :experiencias }
    end   
  end

  def cuenta
    @cliente = Profit::Cliente.find_by_co_cli params[:co_cli]

    render "cuenta/show"
  end

  def send_sms
    if !params[:profit_factura][:fact_num].empty?
      msj = params[:profit_factura][:fact_num]
      facturas = params[:profit_factura][:factu]
      @msj_enviados_count = 0
      @msj_no_enviados_count = 0
      @msj_error_count = 0
      facturas.each do |f|
        if es_celular_valido?(f[1]["telefono1"])      
          if agendar_sms(msj,f[1]["telefono1"])
            @msj_enviados_count += 1
          else
            @msj_error_count += 1
          end
        elsif es_celular_valido?(f[1]["telefono2"])
          if agendar_sms(msj,f[1]["telefono2"])
            @msj_enviados_count += 1
          else
            @msj_error_count += 1
          end
        else
          @msj_no_enviados_count += 1
        end
      end
    else
      redirect_to :index
    end
  end


  private
  
  def combos
    @lineas = Profit::LinArt.all
    @vendedores = Profit::Vendedor.all
    @zonas = Profit::Zona.all
  end

  def es_celular_valido?(tlf)
    tlf.start_with?("0424", "0414", "0416", "0426", "0412") && tlf.length == 11
  end

  def agendar_sms(msj, tlf)
    begin
      Sms::Outbox.create(:number => tlf, :text => msj, :insertdate => DateTime.now, :fec_venc => DateTime.new)
      true
    rescue
      false
    end
  end

end
