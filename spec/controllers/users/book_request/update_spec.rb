require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  include_context 'generate book_request_params'
  describe '#update' do
    include_context 'logged in'
  end
end
