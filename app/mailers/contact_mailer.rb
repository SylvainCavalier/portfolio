class ContactMailer < ApplicationMailer
  def contact_email
    @name = params[:name]
    @sender_email = params[:email]
    @message = params[:message]

    mail(
      to: 'mail@sylvaincavalier.com',
      from: 'mail@sylvaincavalier.com',
      reply_to: @sender_email,
      subject: "Nouveau message de #{@name}"
    )
  end
end