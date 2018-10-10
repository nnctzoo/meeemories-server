class VideoTranscodingsController < ApplicationController
  def show
    @media = VideoTranscoding.find(params[:id])
    render 'medias/show', formats: :json
  end
end
