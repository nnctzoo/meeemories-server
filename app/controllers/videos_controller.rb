class VideosController < ApplicationController
  before_action :handle_sns_request, only: :create

  def show
    @media = Video.find(params[:id])
    render 'medias/show', formats: :json
  end

  def create
    VideoCreator.new(params.require(:Message)).run
    head 200
  end
end
