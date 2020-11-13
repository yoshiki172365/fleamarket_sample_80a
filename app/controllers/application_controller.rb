class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :basic_auth, if: :production?

  def set_item_search_query
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_year_id, :birth_month_id, :birth_day_id, :phone_number])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
end
