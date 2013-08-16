class ParroquiaController < ApplicationController
  layout 'intranet'
  before_filter :authenticate_user!

  # GET /parroquia
  # GET /parroquia.json
  def index
    @parroquia = Parroquia.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parroquia }
    end
  end

  # GET /parroquia/1
  # GET /parroquia/1.json
  def show
    @parroquia = Parroquia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parroquia }
    end
  end

  # GET /parroquia/new
  # GET /parroquia/new.json
  def new
    @parroquia = Parroquia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parroquia }
    end
  end

  # GET /parroquia/1/edit
  def edit
    @parroquia = Parroquia.find(params[:id])
  end

  # POST /parroquia
  # POST /parroquia.json
  def create
    @parroquia = Parroquia.new(params[:parroquia])

    respond_to do |format|
      if @parroquia.save
        format.html { redirect_to @parroquia, notice: 'Parroquia was successfully created.' }
        format.json { render json: @parroquia, status: :created, location: @parroquia }
      else
        format.html { render action: "new" }
        format.json { render json: @parroquia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parroquia/1
  # PUT /parroquia/1.json
  def update
    @parroquia = Parroquia.find(params[:id])

    respond_to do |format|
      if @parroquia.update_attributes(params[:parroquia])
        format.html { redirect_to @parroquia, notice: 'Parroquia was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @parroquia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parroquia/1
  # DELETE /parroquia/1.json
  def destroy
    @parroquia = Parroquia.find(params[:id])
    @parroquia.destroy

    respond_to do |format|
      format.html { redirect_to parroquia_url }
      format.json { head :no_content }
    end
  end
end
