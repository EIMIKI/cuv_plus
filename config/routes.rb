Rails.application.routes.draw do
  get '/setting' => 'setting#index'
  get '/' => 'home#index'
  post '/setting/post' => 'setting#post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
