class VideosController < ApplicationController
  before_action :handle_sns_request, only: :create
  skip_before_action :basic_authentication, only: :create

  def show
    @media = Video.find(params[:id])
    render 'medias/show', formats: :json
  end

  def create
    VideoCreator.new(sns_request_data['Message']).run
    head 200
  end
end
