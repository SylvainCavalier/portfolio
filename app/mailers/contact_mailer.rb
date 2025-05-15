class ContactMailer < ApplicationMailer
  default to: 'mail@sylvaincavalier.com'

  def contact_email
    @name = params[:name]
    @message = params[:message]
    mail(from: params[:email], subject: "Nouveau message de #{@name}")
  end
end