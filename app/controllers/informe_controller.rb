class InformeController < ApplicationController
    layout 'intranet'

    def index
    end

    def show
      @month = params['date']['month']
    end

end
