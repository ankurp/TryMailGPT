class ChatMailbox < ApplicationMailbox
  def process
    ResponseMailer.send_response(mail.message_id).deliver_later
  end
end
