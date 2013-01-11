class Ventas::SeguimientosController < ApplicationController
  layout 'intranet'
  
  # GET /ventas/seguimientos
  # GET /ventas/seguimientos.json
  def index
    @ventas_seguimientos = Ventas::Seguimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ventas_seguimientos }
    end
  end

  # GET /ventas/seguimientos/1
  # GET /ventas/seguimientos/1.json
  def show
    @ventas_seguimiento = Ventas::Seguimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ventas_seguimiento }
    end
  end

  # GET /ventas/seguimientos/new
  # GET /ventas/seguimientos/new.json
  def new
    @ventas_seguimiento = Ventas::Seguimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ventas_seguimiento }
    end
  end

  # GET /ventas/seguimientos/1/edit
  def edit
    @ventas_seguimiento = Ventas::Seguimiento.find(params[:id])
  end

  # POST /ventas/seguimientos
  # POST /ventas/seguimientos.json
  def create
    @ventas_seguimiento = Ventas::Seguimiento.new(params[:ventas_seguimiento])

    respond_to do |format|
      if @ventas_seguimiento.save
        format.html { redirect_to @ventas_seguimiento, notice: 'Seguimiento was successfully created.' }
        format.json { render json: @ventas_seguimiento, status: :created, location: @ventas_seguimiento }
      else
        format.html { render action: "new" }
        format.json { render json: @ventas_seguimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ventas/seguimientos/1
  # PUT /ventas/seguimientos/1.json
  def update
    @ventas_seguimiento = Ventas::Seguimiento.find(params[:id])

    respond_to do |format|
      if @ventas_seguimiento.update_attributes(params[:ventas_seguimiento])
        format.html { redirect_to @ventas_seguimiento, notice: 'Seguimiento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ventas_seguimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ventas/seguimientos/1
  # DELETE /ventas/seguimientos/1.json
  def destroy
    @ventas_seguimiento = Ventas::Seguimiento.find(params[:id])
    @ventas_seguimiento.destroy

    respond_to do |format|
      format.html { redirect_to ventas_seguimientos_url }
      format.json { head :no_content }
    end
  end
end
