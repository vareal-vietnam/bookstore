class ApplicationController < ActionController::Base
  include SessionsHelper
  include PaginationHelper
  include RequestHelper
end
