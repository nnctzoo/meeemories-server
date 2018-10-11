Rails.application.routes.draw do
  resources :contents, only: [:index, :create]

  resources :pictures, only: [:show]
  resources :video_transcodings, only: [:show]
  resources :video_transcoding_errors, only: [:create]
  resources :videos, only: [:show, :create]
end
