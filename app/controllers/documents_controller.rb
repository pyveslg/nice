class DocumentsController < ApplicationController
  layout "pdf"
  def reglement_interieur
    @month = l(Date.today, format: "%B", locale: 'fr')
    @year = Date.today.strftime("%Y")
    respond_to do |format|
      format.pdf do
        render :pdf => "#{Date.today.strftime('%-y%m%-d')}_reglement_interieur_novexpat",
          :page_size => 'A4',
          :dpi => 75,
          :template => "documents/reglement_interieur.pdf.erb",
          # :disposition => "attachment",
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
end
