class ChatMailbox < ApplicationMailbox
  def process
    ResponseMailer.send_response(mail.from, mail.subject, mail.raw_source).deliver_later
  end
end
