class CobranzasController < ApplicationController
  layout 'intranet'

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
    giros_vencidos = params[:giros_vencidos]
    co_lin = params[:co_lin]
    co_ven = params[:co_ven]
    co_zon = params[:co_zon]
    plazo_pago = params[:plazo_pago]


    if !co_cli.empty?
      @facturas = Profit::Factura.by_cliente co_cli
    elsif dias_desde.to_i >= 0 and dias_hasta.to_i > 0 and dias_desde.to_i <= dias_hasta.to_i
      @facturas = Profit::Factura.by_dias_vencidos dias_desde, dias_hasta
    elsif giros_vencidos.to_i > 0
      @facturas = Profit::Factura.by_giros_vencidos giros_vencidos
    else
      @facturas = nil
    end

    combos
    render :index
  end

  def update

    render :text => "alert('Guardado')",
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
