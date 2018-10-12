class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :basic if ENV['USE_BASIC'] == 'TRUE'

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

  def basic
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_USERNAME'] && password == ENV['BASIC_PASSWORD']
    end
  end
end
