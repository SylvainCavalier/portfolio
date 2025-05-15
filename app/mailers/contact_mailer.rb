class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @sender_email = email
    @message = message

    mail(
      to: 'mail@sylvaincavalier.com',
      from: email,
      subject: "Nouveau message de #{name}"
    )
  end
end