class ProductosController < ApplicationController
  def index
    @producto = Profit::Art.new
    @producto.art_des = ''
    @productos = nil
  end

  def show
    @producto = Profit::Art.new
    @producto.art_des = ''    
    @productos = Profit::Art.where('art_des like ? or co_art like ? or modelo like ?',"%#{params[:profit_art][:art_des]}%","%#{params[:profit_art][:art_des]}%","%#{params[:profit_art][:art_des]}%") 
    render :index
  end
end
