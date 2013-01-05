class CuentaController < ApplicationController

  def index
    @cliente = Profit::Cliente.new
  end

  def show
    @cliente = Profit::Cliente.find_by_co_cli params[:profit_cliente][:co_cli]
  end


end
