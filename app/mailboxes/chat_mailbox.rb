class ChatMailbox < ApplicationMailbox
  def process
    body = if mail.multipart?
      mail.text_part.decoded
    else
      mail.decoded
    end
    ResponseMailer.send_response(mail.from, mail.subject, body).deliver_later
  end
end
