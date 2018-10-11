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

    VideoCreator.new(params.require(:Message)).run
    head 200
  end
end
