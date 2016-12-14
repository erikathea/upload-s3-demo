Rails.application.routes.draw do
  resources :posts
  resources :pictures
  resources :attachments
  root 'posts#index'
  # TODO: remove unused routes
end
