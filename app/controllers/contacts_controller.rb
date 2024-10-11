class ContactsController < ApplicationController
  def show
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer
        .with(
          name: @contact.name,
          email: @contact.email,
          message: @contact.message,
        )
        .contact_message
        .deliver_later

      redirect_to contact_path, notice: "Your message has been sent."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
