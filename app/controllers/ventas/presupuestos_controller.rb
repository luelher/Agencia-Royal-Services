class Ventas::PresupuestosController < ApplicationController
  layout 'intranet'

  # GET /ventas/presupuestos
  # GET /ventas/presupuestos.json
  def index
    @ventas_presupuestos = Ventas::Presupuesto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ventas_presupuestos }
    end
  end

  # GET /ventas/presupuestos/1
  # GET /ventas/presupuestos/1.json
  def show
    @ventas_presupuesto = Ventas::Presupuesto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ventas_presupuesto }
    end
  end

  # GET /ventas/presupuestos/new
  # GET /ventas/presupuestos/new.json
  def new
    @ventas_presupuesto = Ventas::Presupuesto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ventas_presupuesto }
    end
  end

  # GET /ventas/presupuestos/1/edit
  def edit
    @ventas_presupuesto = Ventas::Presupuesto.find(params[:id])
  end

  # POST /ventas/presupuestos
  # POST /ventas/presupuestos.json
  def create
    @ventas_presupuesto = Ventas::Presupuesto.new(params[:ventas_presupuesto])

    respond_to do |format|
      if @ventas_presupuesto.save
        format.html { redirect_to @ventas_presupuesto, notice: 'Presupuesto was successfully created.' }
        format.json { render json: @ventas_presupuesto, status: :created, location: @ventas_presupuesto }
      else
        format.html { render action: "new" }
        format.json { render json: @ventas_presupuesto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ventas/presupuestos/1
  # PUT /ventas/presupuestos/1.json
  def update
    @ventas_presupuesto = Ventas::Presupuesto.find(params[:id])

    respond_to do |format|
      if @ventas_presupuesto.update_attributes(params[:ventas_presupuesto])
        format.html { redirect_to @ventas_presupuesto, notice: 'Presupuesto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ventas_presupuesto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/presupuestos/1
  # DELETE /ventas/presupuestos/1.json
  def destroy
    @ventas_presupuesto = Ventas::Presupuesto.find(params[:id])
    @ventas_presupuesto.destroy

    respond_to do |format|
      format.html { redirect_to ventas_presupuestos_url }
      format.json { head :no_content }
    end
  end

  def clientes
    @clientes = Profit::Cliente.where("co_cli like ?", "#{params[:q]}%").limit(10)
    respond_to do |format|
      format.json { render :json => @clientes.to_json(:only => [ :co_cli, :cli_des ]) }
    end
  end  
  def productos
    @productos = Profit::Art.where("art_des like ?", "%#{params[:q]}%").limit(10)
    respond_to do |format|
      format.json { render :json => @productos.to_json(:only => [ :co_art, :art_des, :prec_vta5, :stock_act ]) }
    end
  end  

end
