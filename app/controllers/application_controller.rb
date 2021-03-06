class ApplicationController < ActionController::Base
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後の遷移先を指定
  def after_sign_in_path_for(_resource)
    '/goals/'
  end

  def after_sign_up_path_for(_resource)
    '/goals/'
  end

  protected

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email profile avatar])
  end
end
