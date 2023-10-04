require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Hello, world!'
    end
  end

=begin
  describe 'before_action :configure_permitted_parameters' do
    it 'calls the devise_parameter_sanitizer method for sign_up' do
      expect(controller).to receive_message_chain(:devise_parameter_sanitizer, :permit).with(:sign_up)
      get :index
    end

    it 'calls the devise_parameter_sanitizer method for account_update' do
      expect(controller).to receive_message_chain(:devise_parameter_sanitizer, :permit).with(:account_update)
      get :index
    end
  end
=end

  describe 'before_action :set_locale' do
    it 'sets the locale to the session[:locale] value' do
      session[:locale] = :en
      get :index
      expect(I18n.locale).to eq(:en)
    end

    it 'sets the locale to I18n.default_locale if session[:locale] is not set' do
      get :index
      expect(I18n.locale).to eq(I18n.default_locale)
    end
  end
end
