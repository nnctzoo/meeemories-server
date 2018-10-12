class ApplicationController < ActionController::API
  private

  def handle_sns_request
    verifier = Aws::SNS::MessageVerifier.new
    unless verifier.authentic?(request.body.string)
      head 400 and return
    end

    if request.headers['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
      @subscribe_url = params.permit(:SubscribeURL)
      logger.debug "Subscribe URL: #{@subscribe_url}"
      head 200 and return
    end
  end
end
