class UsersController < ApplicationController
  def show
    @books = current_user.books.includes(
      :images,
      :user
    ).page(params[:page]).per(4)
  end

  def new
    redirect_to current_user if current_user
    @user = User.new
  end

  def edit
    return if params[:id].to_i == current_user.id

    flash[:danger] = t('not_found')
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)

    # binding.pry
    if @user.save
      flash[:success] = t('.user_created')
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = t('.update_success')
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :address, :password, :password_confirmation, :avatar
    )
  end
end
