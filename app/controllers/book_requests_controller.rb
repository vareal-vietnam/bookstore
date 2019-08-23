class BookRequestsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy]
  before_action :assign_book_request, only: %i[show edit destroy update]

  def new
    @book_request = BookRequest.new
  end

  def create
    @book_request = current_user.book_requests.build(book_request_params)
    if @book_request.save
      create_image_files
      flash[:success] = t('.success')
      redirect_to @book_request
    else
      render 'new'
    end
  end

  def index
    @book_requests =
      BookRequest.order(created_at: :desc)
    @book_requests = paginate_collection(@book_requests, params[:page], 16)
  end

  def show
    path = "#{book_requests_url}?page=#{params[:page]}"
    set_flash_and_redirect(:danger, t('book_requests.not_exist'), path) unless
      @book_request
  end

  def edit
    path = user_book_requests_path(current_user)
    if @book_request
      return if current_user.id == @book_request.user_id

      set_flash_and_redirect(:danger, t('require.permission'), path)
    else
      set_flash_and_redirect(:danger, t('book_request.not_exist'), path)
    end
  end

  def update
    if @book_request.update_attributes(book_request_params)
      destroy_image_files if image_files_params
      create_image_files
      flash[:success] = t('book_requests.update.success')
      redirect_to book_request_path(@book_request)
    else
      render 'edit'
    end
  end

  def destroy
    path = request.referrer
    if @book_request
      if @book_request.destroy
        set_flash_and_redirect(:success, t('action.delete.success'), path)
      else
        set_flash_and_redirect(:danger, t('action.delete.fail'), path)
      end
    else
      set_flash_and_redirect(:danger, t('book_requests.not_exist'), path)
    end
  end

  private

  def book_request_params
    params.require(:book_request).permit(
      :name, :comment, :budget, :quantity, :book_request_images
    )
  end

  def image_files_params
    params[:book_request][:book_request_images]
  end

  def create_image_files
    image_files_params&.each do |image_file|
      @book_request.book_request_images.create(file: image_file)
    end
  end

  def destroy_image_files
    file_images = @book_request.book_request_images
    file_images.destroy_all if file_images.present?
  end

  def assign_book_request
    @book_request = BookRequest.find_by(id: params[:id])
  end
end
