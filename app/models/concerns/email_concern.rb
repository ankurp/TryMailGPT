module EmailConcern
  extend ActiveSupport::Concern

  def text_from_mail(mail)
    if mail.multipart?
      mail.text_part.decoded
    else
      mail.decoded
    end
  end

  def format_response(response, mail)
    question = text_from_mail(mail)
    quoted_question = question.split("\n").map { "> #{_1}" }.join("\n")
    "#{response}\n\n#{quoted_question}"
  end
end
