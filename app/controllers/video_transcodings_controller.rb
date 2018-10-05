class VideoTranscodingsController < ApplicationController
  def show
    @transcoding = VideoTranscoding.find(params.require(:id))
    render :show, formats: :json
  end
end
