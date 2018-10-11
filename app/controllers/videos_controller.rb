class VideosController < ApplicationController
  def create
    VideoCreator.new(params.require(:Message)).run
    head 200
  end
end
