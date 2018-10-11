class VideoTranscodingErrorsController < ApplicationController
  def create
    if Rails.env.production?
      verifier = Aws::SNS::MessageVerifier.new
      unless verifier.authentic?(request.body.string)
        head 400 and return
      end
    end

    VideoTranscodingErrorCreator.new(params.require(:Message)).run
    head 200
  end
end
