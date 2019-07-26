class BookRequestsController < ApplicationController
  def new
    @book_request = BookRequest.new
  end

  def create
  end
end
