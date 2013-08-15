class InformeController < ApplicationController
    layout 'intranet'

    def index
    end

    def show
      @month = params['date']['month']
      meta = Goal.find_by_month_and_year(@month, Date.today.year)

      if meta
        @meta_ventas = meta.sales
        @meta_cobranza = meta.billing
      else
        @meta_ventas = 0
        @meta_cobranza = 0
      end
    end

end
