class ResponseMailer < ApplicationMailer
  include EmailConcern

  def send_response(message_id)
    mail     = ActionMailbox::InboundEmail.find_by_message_id(message_id).mail
    response = Bot.instance.reply_to_email(mail.raw_source)
    body     = format_response(response, mail)
    subject  = "Re: #{mail.subject}"
    from     = mail.to
    to       = mail.from # reply to the sender

    mail(from:, to:, subject:, body:)
  end
end
