Rails.application.routes.draw do
  resources :contents, only: [:index, :create]

  resources :pictures, only: [:show]
  resources :video_transcodings, only: [:show]
  resources :video, only: [:create]
end
