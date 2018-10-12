class VideoTranscodingErrorsController < ApplicationController
  def create
    verifier = Aws::SNS::MessageVerifier.new
    unless verifier.authentic?(request.body.string)
      head 400 and return
    end

    VideoTranscodingErrorCreator.new(params.require(:Message)).run
    head 200
  end
end
