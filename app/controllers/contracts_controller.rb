class ContractsController < ApplicationController
  before_action :set_contract, only: [:update, :show, :edit, :download, :fbp_contract]
  layout "pdf", only: [ :show ]

  def index
    @contracts = Contract.all
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.programme = Programmes::PROGRAMME.select{|programme| programme[:title] == contract_params[:programme]}[0][:id]
    if source_params[:source] != "frenchbooster"
      @contract.hourly_rate = Fees::FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      @contract.sessions = set_sessions
      @contract.frequency = set_frequency
    else
     @contract.hourly_rate = Fees::FBP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
     @contract.start_from = Programmes::FBP[@contract.programme][:start_from]
     @contract.end_at = Programmes::FBP[@contract.programme][:end_at]
    end
    if @contract.save
      if source_params[:source] == "frenchbooster"
        redirect_to fbp_contract_contract_path(@contract)
      else
        redirect_to contract_path(@contract)
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @contract.update(contract_params)
    @contract.programme = Programmes::PROGRAMME.select{|programme| programme[:title] == contract_params[:programme]}[0][:id]
    if source_params[:source] != "frenchbooster"
      @contract.hourly_rate = Fees::FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
      @contract.sessions = set_sessions
      @contract.frequency = set_frequency
    else
     @contract.hourly_rate = Fees::FBP_FEES.select{|fee| fee[:title] == contract_params[:hourly_rate]}[0][:id]
     @contract.start_from = Programmes::FBP[@contract.programme][:start_from]
     @contract.end_at = Programmes::FBP[@contract.programme][:end_at]
    end
    if @contract.save
      if source_params[:source] == "frenchbooster"
        redirect_to fbp_contract_contract_path(@contract)
      else
        redirect_to contract_path(@contract)
      end
    else
      render :edit
    end
  end

  def fbp_contract
    respond_to do |format|
      format.pdf do
        render :pdf => "#{@contract.sign_date.strftime('%y%m%d')}_Contrat de formation_#{@contract.first_name} #{@contract.last_name}",
          :page_size => 'A4',
          :dpi => 75,
          :template => "contracts/fbp_contract.pdf.erb",
          :layout => "pdf.html",
          :margin => {
            top: 0,
            bottom: 0,
            left: 0,
            right: 0
          },
          :show_as_html => params[:debug].present?
      end

      format.html
    end
  end

  def show
    respond_to do |format|
      format.pdf do
        render :pdf => "#{@contract.sign_date.strftime('%y%m%d')}_Contrat de formation_#{@contract.first_name} #{@contract.last_name}",
          :page_size => 'A4',
          :dpi => 75,
          :template => "contracts/contract.pdf.erb",
          :layout => "pdf.html",
          :margin => {
            top: 0,
            bottom: 0,
            left: 0,
            right: 0
          },
          :show_as_html => params[:debug].present?
      end

      format.html
    end
  end

  def download
    html = render_to_string(:page_size => 'A4',
          :dpi => 75,
          :template => "contracts/contract.pdf.erb",
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
    params.require(:contract).permit(:programme, :client_type, :hourly_rate, :start_from, :end_at, :target, :teacher, :sign_date, :first_name, :last_name, :tel, :email, :address, :zipcode, :city)
  end

  def source_params
    params.require(:source).permit(:source)
  end

  def inter_params
    params.require(:contract).permit(:number_of_weeks, :hours_by_sessions, :number_of_sessions, :number_of_classes, :hours_by_sessions_2, :number_of_sessions_2)
  end
end
