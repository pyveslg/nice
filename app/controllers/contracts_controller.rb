class ContractsController < ApplicationController
  before_action :set_contract, only: [:update, :show, :edit, :download, :fbp_contract]
  layout "pdf", only: [ :show ]

  def index
    @contracts = Contract.all.order(created_at: :DESC)
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.payment_condition = 3 if inter_params[:payment_3].to_i == 1
    @contract.programme = check_which_programme[:id]
    @contract.code = check_which_programme[:code]
    if @contract.code == "FBP" || @contract.code == "FBPI"
     @contract.hourly_rate = Fees::FBP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
     @contract.code = @contract.access_fbp_hash[:code]
     @contract.start_from = @contract.access_fbp_hash[:start_from]
     @contract.end_at = @contract.access_fbp_hash[:end_at]
    else
      if @contract.code == "FUP"
        @contract.hourly_rate = Fees::FUP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      else
        @contract.hourly_rate = Fees::FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      end
      @contract.client_type = contract_params[:client_type] == "Business" ? 1 : 0
      @contract.sessions = set_sessions
      @contract.frequency = set_frequency
    end
    if @contract.save
      redirect_to contract_path(@contract)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @contract.update(contract_params)
    @contract.payment_condition = 3 if inter_params[:payment_3].to_i == 1
    if @contract.code == "FBP" || @contract.code == "FBPI"
      @contract.programme = Programmes::FBP.select{|programme| programme[:title] == contract_params[:programme]}[0][:id]
      @contract.hourly_rate = Fees::FBP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      @contract.start_from = @contract.access_fbp_hash[:start_from]
      @contract.end_at = @contract.access_fbp_hash[:end_at]
    else
      @contract.client_type = contract_params[:client_type] == "Business" ? 1 : 0
      @contract.programme = Programmes::PROGRAMME.select{|programme| programme[:title] == contract_params[:programme]}[0][:id]
      if @contract.code == "FUP"
        @contract.hourly_rate = Fees::FUP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      else
        @contract.hourly_rate = Fees::FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      end
      @contract.sessions = set_sessions
      @contract.frequency = set_frequency
    end
    if @contract.save
      redirect_to contract_path(@contract)
    else
      render :edit
    end
  end

  def show
      respond_to do |format|
        format.pdf do
          render :pdf => "#{@contract.sign_date.strftime('%y%m%d')}_Contrat de formation_#{@contract.first_name} #{@contract.last_name}",
            :page_size => 'A4',
            :dpi => 75,
            :template => "contracts/#{@contract.code.downcase}_contract.pdf.erb",
            :disposition => "attachment",
            :layout => "pdf.html",
            :margin => {
              top: 0,
              bottom: 0,
              left: 0,
              right: 0
            }
        end

        format.html
      end
  end

  def download
    html = render_to_string(:page_size => 'A4',
          :dpi => 75,
          :template => "contracts/#{@contract.code.downcase}_contract.pdf.erb",
          :disposition => "attachment",
          :layout => "pdf.html",
          :margin => {
            top: 0,
            bottom: 0,
            left: 0,
            right: 0
          })
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf,
      :filename => "#{@contract.sign_date.strftime('%-d%H%M')}_Contrat de formation_#{@contract.first_name} #{@contract.last_name}",
      :disposition => 'attachment')
  end

  private

  def set_sessions
    sessions = []
    session_sub = [inter_params[:number_of_sessions], inter_params[:hours_by_sessions]]
    sessions.push(session_sub)
    session_sub = [inter_params[:number_of_sessions_2], inter_params[:hours_by_sessions_2]]
    sessions.push(session_sub)
    return sessions
  end

  def set_frequency
    frequency = [inter_params[:number_of_classes], inter_params[:number_of_weeks]]
  end

  def set_contract
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:programme, :cpi_on_top, :client_type, :hourly_rate, :start_from, :end_at, :target, :teacher, :sign_date, :first_name, :last_name, :tel, :email, :address, :zipcode, :city, :installment)
  end


  def inter_params
    params.require(:contract).permit(:payment_3, :number_of_weeks, :hours_by_sessions, :number_of_sessions, :number_of_classes, :hours_by_sessions_2, :number_of_sessions_2)
  end

  def check_which_programme
    Programmes::PROGRAMME.select{|programme| programme[:title] == contract_params[:programme]}.empty? ? Programmes::FBP.select{|programme| programme[:title] == contract_params[:programme]}[0] : Programmes::PROGRAMME.select{|programme| programme[:title] == contract_params[:programme]}[0]
  end
end
