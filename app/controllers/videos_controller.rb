class VideosController < ApplicationController
  def show
    @media = Video.find(params[:id])
    render 'medias/show', formats: :json
  end

  def create
    VideoCreator.new(params.require(:Message)).run
    head 200
  end
end
