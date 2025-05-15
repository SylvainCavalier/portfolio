class ContactController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :validate_contact_form

  def send_message
    ContactMailer.with(
      name: params[:name],
      email: params[:email],
      message: params[:message]
    ).contact_email.deliver_now
  
    render json: { status: 'ok', message: 'Message envoyé avec succès !' }
  rescue => e
    Rails.logger.error "Erreur mailer : #{e.message}"
    render json: { status: 'error', message: 'Erreur lors de l’envoi du message.' }, status: :unprocessable_entity
  end
  
  private
  
  def validate_contact_form
    if params[:name].blank? || params[:email].blank? || params[:message].blank?
      render json: { status: 'error', message: 'Tous les champs sont requis.' }, status: :unprocessable_entity
    elsif params[:email].length > 255 || params[:message].length > 5000
      render json: { status: 'error', message: 'Le message ou l’email est trop long.' }, status: :unprocessable_entity
    end
  end
end