class LanguageController < ApplicationController
  def switch
    new_locale = params[:locale]

    if I18n.available_locales.include?(new_locale.to_sym)
      session[:locale] = new_locale
    end
    redirect_back(fallback_location: root_path)
  end
end
