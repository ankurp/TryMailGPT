class ResponseMailer < ApplicationMailer
  def send_response(from, subject, prompt)
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
          { role: "user", content: prompt }
        ]
      }
    )

    @prompt = prompt
    @response = response["choices"].map { _1["message"]["content"] }.join("\n")

    mail(
      to: from,
      subject: "Re: #{subject}",
      body: [
        @response,
        prompt.split("\n").map { "> #{_1}" }.join("\n")
      ].join("\n\n")
    )
  end
end
