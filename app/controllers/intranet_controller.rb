class IntranetController < ApplicationController
  layout 'intranet'
  before_filter :authenticate_user!

  def index
  end
end
