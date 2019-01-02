Rails.application.routes.draw do
  get 'session_error'=>'errors#session_error'
  get '/setting' => 'setting#index'
  get '/' => 'home#index'
  get '/about' => 'home#about'
  post '/setting/post' => 'setting#post'
  post '/devices' => 'devices#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
