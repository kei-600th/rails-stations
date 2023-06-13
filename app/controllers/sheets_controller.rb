class SheetsController < ApplicationController

  def index
    redirect_to root_path
    @sheets = Sheet.all
  end

end
