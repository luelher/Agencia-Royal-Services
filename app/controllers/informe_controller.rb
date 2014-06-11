class InformeController < ApplicationController
    layout 'intranet'
    before_filter :authenticate_user!


    def index
    end

    def show
      @month = params['date']['month']
      @year = params['date']['year']
      meta = Goal.find_by_month_and_year(@month, @year)

      Feriado.all.map{|holiday| BusinessTime::Config.holidays << holiday.fecha}

      if meta
        @meta_ventas = meta.sales
        @meta_cobranza = meta.billing
      else
        @meta_ventas = 0
        @meta_cobranza = 0
      end
    end

end
