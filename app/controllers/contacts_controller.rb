class ContactsController < ApplicationController
  def show; end

  def create
    ContactMailer
      .with(
        name: contact_params[:name],
        email: contact_params[:email],
        message: contact_params[:message],
      )
      .contact_message
      .deliver_later

    redirect_to contact_path, notice: "Your message has been sent."
  end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end
