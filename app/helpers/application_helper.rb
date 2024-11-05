module ApplicationHelper
  def rtl_locale?
    %w[ar he].include?(I18n.locale.to_s)
  end

  def dir_attribute
    rtl_locale? ? "rtl" : "ltr"
  end
end
