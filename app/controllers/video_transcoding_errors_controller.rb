class VideoTranscodingErrorsController < ApplicationController
  before_action :handle_sns_request, only: :create

  def create
    VideoTranscodingErrorCreator.new(params.require(:Message)).run
    head 200
  end
end
