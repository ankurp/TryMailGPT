class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :best_locale_from_request!

  def best_locale_from_request!
    I18n.locale = best_locale_from_request
  end

  def best_locale_from_request
    return I18n.default_locale unless request.headers.key?("HTTP_ACCEPT_LANGUAGE")

    string = request.headers.fetch("HTTP_ACCEPT_LANGUAGE")
    if (locale = AcceptLanguage.parse(string).match(*I18n.available_locales))
      return locale
    end

    I18n.default_locale
  end
end
