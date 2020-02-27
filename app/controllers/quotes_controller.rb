class QuotesController < ApplicationController
  before_action :set_quote, only: [:update, :show, :edit]

  def new
    @quote = Quote.new(code:params[:code], client_is_business: params[:business])
  end

  def show
  end

  def edit
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.frequency = JSON.parse(@quote.frequency)
    @quote.day_of_classes = quote_params[:day_of_classes].split(',')
    @quote.programme = check_which_programme[:id]
    @quote.code = check_which_programme[:code]
    @quote.hourly_rate = Fees.const_get("#{@quote.code}_FEES").select{|fee| fee[:title] == quote_params[:hourly_rate]}[0][:id]
    if @quote.save
      render :edit
    end
  end

  def update
    raise
  end

  private


  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(
      :number_of_participants,
      :client_first_name,
      :client_last_name,
      :client_tel,
      :client_email,
      :client_address,
      :client_zipcode,
      :client_city,
      :company_name,
      :company_siret,
      :company_address,
      :company_zipcode,
      :company_city,
      :number_of_participants,
      :programme,
      :hours,
      :frequency,
      :day_of_classes,
      :start_from,
      :end_at,
      :schedule_is_defined,
      :level_target,
      :content,
      :hourly_rate,
      :installment,
      participants: [:first_name, :last_name, :position],
      sessions: [:number_of_sessions, :hours_per_session],
      timeslots: [],
      schedules: []
    )
  end

  def check_which_programme
    Programmes::PROGRAMME.select{|programme| programme[:title] == quote_params[:programme]}.empty? ? Programmes::FBP.select{|programme| programme[:title] == quote_params[:programme]}[0] : Programmes::PROGRAMME.select{|programme| programme[:title] == quote_params[:programme]}[0]
  end
end
