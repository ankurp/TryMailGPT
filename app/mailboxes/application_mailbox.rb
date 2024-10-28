class ApplicationMailbox < ActionMailbox::Base
  routing(/@trymailgpt\.com$/i => :chat)
end
