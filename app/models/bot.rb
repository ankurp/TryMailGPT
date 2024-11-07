class Bot
  include Singleton

  def initialize
    @client = OpenAI::Client.new
  end

  def reply_to_email(email)
    response = @client.chat(parameters: {
      model: "gpt-4o",
      messages: [ {
        role: "system",
        content: [
          "You are an AI assistant from TryMailGPT.com responding to questions sent to you via email.",
          "Reply to the question as an email thread.",
          "Do not include From, To, or Subject headers in your response.",
          "Do not include Best Regards or other salutations at the end of your response.",
          "Take a deep breath. You got this!"
        ].join(" ")
      }, {
        role: "user",
        content: email
      } ]
    })

    response["choices"].map { _1["message"]["content"] }.join("\n")
  end
end
