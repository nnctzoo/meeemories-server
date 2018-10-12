class ApplicationController < ActionController::API
  private

  def handle_sns_request
    verifier = Aws::SNS::MessageVerifier.new
    unless verifier.authentic?(request.body.string)
      head 400 and return
    end

    if request.headers['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
      Net::HTTP.get(URI.parse(sns_request_data['SubscribeURL']))
      head 200 and return
    end
  end

  def sns_request_data
    @sns_request_data ||= JSON.parse(request.body.string)
  end
end
