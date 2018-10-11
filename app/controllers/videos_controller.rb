class VideosController < ApplicationController
  def show
    @media = Video.find(params[:id])
    render 'medias/show', formats: :json
  end

  def create
    if Rails.env.production?
      verifier = Aws::SNS::MessageVerifier.new
      unless verifier.authentic?(request.body.string)
        head 400 and return
      end
    end

    if request.headers['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
      @subscribe_url = params.permit(:SubscribeURL)
      logger.debug "Subscribe URL: #{@subscribe_url}"
      head 200 and return
    end

    VideoCreator.new(params.require(:Message)).run
    head 200
  end
end
