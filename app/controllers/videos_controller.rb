class VideosController < ApplicationController
  before_action :set_video, only: [:show, :update, :destroy]

  # GET /videos
  def index
    @videos = Video.all

    render json: @videos
  end

  # GET /videos/1
  def show
    hash = {
      :status => @video.status,
      :original_url => url_for(@video.video)
    }
    render json: hash
  end

  # POST /videos
  def create
    @video = Video.new(video_params)
    @video.status = Video_status::PROGRESSIVE

    if @video.save
      create_transcoder_job(video_key: @video.video.key)
      render json: @video, status: :created, location: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # DELETE /videos/1
  def destroy
    if @video.video.attached?
      @video.video.purge
    end
    @video.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
      params.require(:video).permit(:video)
    end

    # Create transcoder job
    def create_transcoder_job(video_key:)
      require 'aws-sdk'
      # TODO: aws configはどこか別のファイルに切り出す
      Aws.config.update({region: 'ap-northeast-1'})

      pipeline_id = '1537175214386-j9egwy'
      preset_id_system_web = '1351620000001-000020'
      input_key = "#{video_key}"
      output_key = "out/#{video_key}.mp4"
      thumbnail_pattern = "out/#{video_key}-{count}"

      transcoder = Aws::ElasticTranscoder::Client.new({
        access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
        secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
      })

      response = transcoder.create_job(
          pipeline_id: pipeline_id,
          input: {
              key: input_key,
              frame_rate: 'auto',
              resolution: 'auto',
              aspect_ratio: 'auto',
              interlaced: 'auto',
              container: 'auto'
          },
          output: {
              key: output_key,
              preset_id: preset_id_system_web,
              thumbnail_pattern: thumbnail_pattern,
              rotate: '0',
          }
      )

      return response
    end

    # 別の場所に置きたい
    module Video_status
      PROGRESSIVE = 1
      COMPLETED = 2
      WARNING = 3
      ERROR = 4
    end
end
