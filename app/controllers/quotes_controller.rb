class QuotesController < ApplicationController
  def new
    @quote = Quote.new(code:params[:code], client_is_business: params[:business])
  end

  def show
  end

  def create
  end

  def update
  end
end
