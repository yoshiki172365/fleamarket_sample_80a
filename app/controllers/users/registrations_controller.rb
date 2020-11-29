# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params) #登録1ページ目から送られてきたパラメータを@userに代入
    unless @user.valid? #validメソッドを使ってバリデーションチェック
      flash.now[:aleart] = @user.errors.full_messages
      render :new and return #and returnを使って条件分岐を明示的に終了させている。
    end
    session["devise.regist_data"] = {user: @user.attributes}
     #sessionにハッシュオブジェクトで情報保持させるため、attributesメソッドでデータ整形。

    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    #前述で含まれなかった情報を代入。

    #ネットでは、sessionに関して、ネスト構造になっている場合は、2階層目以降を文字列表記にする必要があるとの噂がありましたが、両方ともシンボル型でOKとのこと。
    #要は、前述のコードがシンボル型ならこの箇所もシンボル型に、文字列ならこの箇所も文字列に、合わせる必要がある。

    #params[:user][:password]において、paramsの中身（userモデルのpasswordカラム）から値を取り出している。ネスト構造な書き方。
    # （params[:password]ではなく、params[:user][:password]という書き方で、モデル・カラムという順番で指定している）
    #その値をsession["devise.regist_data”]の中の[:user]というハッシュの[“password”]というキーのバリューに代入している。
    @address = @user.build_address
    #build_addressメソッドはhas_one :addressのアソシエーションを設定すると使用可。関連づけのあるnewメソッドのようなもの。
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    #session["devise.regist_data”]の中の["user”]というハッシュの情報を@userに代入している。

    #user、という同じハッシュがアクションをまたぐ（create~create_address）と、create_addressアクションにおいては自動的に文字列になってしまう。
    #binding.pryで検証すると確認できるとのこと。
    #そのため文字列表記で指定しないといけない。

    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:aleart] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes) #送られてきたparamsをbuild_addressを用いて@userに代入
    @user.save
    session["devise.regist_data"]["user"].clear #sessionを明示的に削除 セキュリティ上必要
    sign_in(:user, @user) #登録後ログイン状態になるようにしている
    redirect_to root_path
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_year_id, :birth_month_id, :birth_day_id])
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :zip_code, :prefecture_id, :city, :block_number, :apartment_name, :user, :phone_number)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
