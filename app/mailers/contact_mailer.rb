class ContactMailer < ApplicationMailer
  def contact_message
    mail to: "hvenables89@gmail.com"
  end
end
