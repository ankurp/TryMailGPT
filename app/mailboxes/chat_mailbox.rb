class ChatMailbox < ApplicationMailbox
  def process
    ResponseMailer.send_response(mail, mail.subject, mail.decoded).deliver
  end
end
