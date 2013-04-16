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
    plazo_pago = params[:plazo_pago]
    @recientes = params[:recientes].nil? ? "" : params[:recientes]



    if !co_cli.empty?
      @facturas = Profit::Factura.by_cliente co_cli
    elsif dias_desde.to_i >= 0 and dias_hasta.to_i > 0 and dias_desde.to_i <= dias_hasta.to_i
      @facturas = Profit::Factura.by_dias_vencidos dias_desde, dias_hasta, co_lin, co_ven, co_zon
    elsif giros_vencidos_desde.to_i > 0 and giros_vencidos_hasta.to_i > 0
      @facturas = Profit::Factura.by_giros_vencidos giros_vencidos_desde, giros_vencidos_hasta, co_lin, co_ven, co_zon
    elsif !plazo_pago.empty?
      @facturas = Profit::Factura.by_plazo_pago plazo_pago[0]
    else
      @facturas = nil
    end

    combos

    respond_to do |format|
      format.html { render :index }
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


  private
  
  def combos
    @lineas = Profit::LinArt.all
    @vendedores = Profit::Vendedor.all
    @zonas = Profit::Zona.all
  end

end
