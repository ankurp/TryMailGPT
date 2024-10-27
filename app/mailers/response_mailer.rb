class ResponseMailer < ApplicationMailer
  def send_response(mail, subject, prompt)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    @prompt = prompt
    @response = response["choices"].map { _1["message"]["content"] }.join("\n")

    mail(to: mail.from, subject: "RE: #{subject}", body: @response)
  end
end
