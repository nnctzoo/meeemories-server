Rails.application.routes.draw do
  resources :contents, only: [:index, :show, :create]
  resources :video_transcodings, only: [:show]
end
