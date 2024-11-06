class ResponseMailer < ApplicationMailer
  def send_response(message_id)
    mail = ActionMailbox::InboundEmail.find_by_message_id(message_id).mail
    body = if mail.multipart?
      mail.text_part.decoded
    else
      mail.decoded
    end

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          {
            role: "system",
            content: [
              "You are an AI assistant from TryMailGPT.com responding to questions sent to you via email.",
              "Reply to the question as an email thread.",
              "Do not include From, To, or Subject headers in your response.",
              "Do not include Best Regards or other salutations at the end of your response.",
              "Take a deep breath. You got this!"
            ].join(" ")
          },
          { role: "user", content: mail.raw_source }
        ]
      }
    )

    @response = response["choices"].map { _1["message"]["content"] }.join("\n")

    mail(
      to: mail.from,
      subject: "Re: #{mail.subject}",
      body: [
        @response,
        body.split("\n").map { "> #{_1}" }.join("\n")
      ].join("\n\n")
    )
  end
end
