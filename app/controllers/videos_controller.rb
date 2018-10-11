class VideosController < ApplicationController
  def create
    VideoCreator.new(params.require(:Message)).run
    render :create, formats: :json
  end
end
