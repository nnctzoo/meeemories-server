class VideoTranscodingErrorsController < ApplicationController
  before_action :handle_sns_request, only: :create
  skip_before_action :basic_authentication, only: :create

  def create
    VideoTranscodingErrorCreator.new(sns_request_data['Message']).run
    head 200
  end
end
