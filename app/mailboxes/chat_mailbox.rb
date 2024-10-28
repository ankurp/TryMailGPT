class ChatMailbox < ApplicationMailbox
  def process
    ResponseMailer.send_response(mail.from, mail.subject, mail.decoded).deliver_later
  end
end
