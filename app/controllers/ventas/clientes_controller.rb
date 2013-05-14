class Ventas::ClientesController < ApplicationController
  layout 'intranet'
  before_filter :authenticate_user!
  
  # GET /ventas/clientes
  # GET /ventas/clientes.json
  def index
    if params[:ventas_cliente]
      @ventas_clientes = Ventas::Cliente.where(:ci => params[:ventas_cliente][:ci]).paginate(:page => params[:page], :per_page => 5)
    else
      @ventas_clientes = Ventas::Cliente.paginate(:page => params[:page], :per_page => 5)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ventas_clientes }
    end
  end

  # GET /ventas/clientes/1
  # GET /ventas/clientes/1.json
  def show
    @ventas_cliente = Ventas::Cliente.find(params[:id])
    @gmap_json = @ventas_cliente.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ventas_cliente }
    end
  end

  # GET /ventas/clientes/new
  # GET /ventas/clientes/new.json
  def new
    @ventas_cliente = Ventas::Cliente.new
    @gmap_json = '[{"lng": "-69.324225", "lat": "10.066336", "draggable": true}]'
    # @ventas_cliente.to_gmaps4rails

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ventas_cliente }
    end
  end

  # GET /ventas/clientes/1/edit
  def edit
    @ventas_cliente = Ventas::Cliente.find(params[:id])
    @gmap_json = '[{"lng": "' + @ventas_cliente.longitude.to_s + '", "lat": "' + @ventas_cliente.latitude.to_s + '", "draggable": true}]'
    # @gmap_json = @ventas_cliente.to_gmaps4rails
  end

  # POST /ventas/clientes
  # POST /ventas/clientes.json
  def create
    @ventas_cliente = Ventas::Cliente.new(params[:ventas_cliente])

    respond_to do |format|
      if @ventas_cliente.save
        format.html { redirect_to @ventas_cliente, notice: 'Cliente was successfully created.' }
        format.json { render json: @ventas_cliente, status: :created, location: @ventas_cliente }
      else
        format.html { render action: "new" }
        format.json { render json: @ventas_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ventas/clientes/1
  # PUT /ventas/clientes/1.json
  def update
    @ventas_cliente = Ventas::Cliente.find(params[:id])

    respond_to do |format|
      if @ventas_cliente.update_attributes(params[:ventas_cliente])
        format.html { redirect_to @ventas_cliente, notice: 'Cliente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ventas_cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/clientes/1
  # DELETE /ventas/clientes/1.json
  def destroy
    @ventas_cliente = Ventas::Cliente.find(params[:id])
    @ventas_cliente.destroy

    respond_to do |format|
      format.html { redirect_to ventas_clientes_url }
      format.json { head :no_content }
    end
  end

  def migrate
    @migrados = 0
    all_profit = Profit::Cliente.all

    all_profit.each do |cli|
      @migrados += 1 if cli.crear_ventas_cliente
    end

  end
end
