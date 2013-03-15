class CobranzasController < ApplicationController
  layout 'intranet'
  def index
    @factura = Profit::Factura.new
    @factura.co_cli = ''
    @facturas = nil
    @lineas = Profit::LinArt.all
  end

  def show
    @factura = Profit::Factura.new
    @factura.co_cli = ''
    @facturas = Profit::Factura.solo_facturas_creditos.where('factura.co_cli like ?',"%#{params[:profit_factura][:co_cli]}%") 
    @lineas = Profit::LinArt.all    
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
end
