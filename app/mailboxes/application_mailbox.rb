class ApplicationMailbox < ActionMailbox::Base
  routing(/^ai@/i => :chat)
end
