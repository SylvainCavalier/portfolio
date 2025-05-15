class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token

  def send_message
    ContactMailer.with(
      name: params[:name],
      email: params[:email],
      message: params[:message]
    ).contact_email.deliver_now

    render json: { status: 'ok' }
  end
end