class UsersController < Clearance::UsersController
  before_action :set_user, only: :show
  
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = user_from_params
    render template: "users/new"
  end

  def edit
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @user = nil
  end

  def update
    @user = User.find(params[:id])
    if user_params != false
      update_user(@user)
    else
      flash[:data] = ''
      redirect_to dynamics_path
    end
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
    Notification.create :user_id => @user.id , :text => "Hi #{@user.nome}. Welcome to IDeaTouch. Be creative and enjoy it." , :estado => false
  end

  private

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    nome = user_params.delete(:nome)

    clearance_configuration(email, password, nome)
  end

  def update_user(user)
    if user.update(user_params)
      flash[:data] = ''
      redirect_to dynamics_path
    else
      flash[:data] = 'Dados não alterados.'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def clearance_configuration(email, password, nome)
    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.nome = nome
    end
  end

  def verify_pass
    if params[:user][:pass] != params[:user][:password]
      return false
    else
      return params.require(:user).permit(:nome, :email, :password)
    end
  end

  def user_params
    if !params[:user][:pass].empty? && !params[:user][:pass].nil?
      return verify_pass
    else
      params.require(:user).permit(:nome, :email)
    end
  end

end

