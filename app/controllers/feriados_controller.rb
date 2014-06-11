class FeriadosController < ApplicationController
  layout 'intranet'
  before_filter :authenticate_user!

  # GET /feriados
  # GET /feriados.json
  def index
    @feriados = Feriado.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feriados }
    end
  end

  # GET /feriados/1
  # GET /feriados/1.json
  def show
    @feriado = Feriado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feriado }
    end
  end

  # GET /feriados/new
  # GET /feriados/new.json
  def new
    @feriado = Feriado.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feriado }
    end
  end

  # GET /feriados/1/edit
  def edit
    @feriado = Feriado.find(params[:id])
  end

  # POST /feriados
  # POST /feriados.json
  def create
    @feriado = Feriado.new
    @feriado.fecha = Date.new(params[:feriado]["fecha(1i)"].to_i, params[:feriado]["fecha(2i)"].to_i, params[:feriado]["fecha(3i)"].to_i)
    @feriado.descripcion = params[:feriado][:descripcion]

    respond_to do |format|
      if @feriado.save
        format.html { redirect_to @feriado, notice: 'Feriado was successfully created.' }
        format.json { render json: @feriado, status: :created, location: @feriado }
      else
        format.html { render action: "new" }
        format.json { render json: @feriado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feriados/1
  # PUT /feriados/1.json
  def update
    @feriado = Feriado.find(params[:id])

    respond_to do |format|
      @feriado.fecha = Date.new(params[:feriado]["fecha(1i)"].to_i, params[:feriado]["fecha(2i)"].to_i, params[:feriado]["fecha(3i)"].to_i)
      @feriado.descripcion = params[:feriado][:descripcion]
      if @feriado.save
        format.html { redirect_to @feriado, notice: 'Feriado was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feriado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feriados/1
  # DELETE /feriados/1.json
  def destroy
    @feriado = Feriado.find(params[:id])
    @feriado.destroy

    respond_to do |format|
      format.html { redirect_to feriados_url }
      format.json { head :no_content }
    end
  end
end
