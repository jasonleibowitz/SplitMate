SplitmateApp::Application.routes.draw do

  resources :users
  resources :apartments do
    resources :chores, shallow: true
  end
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  post '/sessions' => 'sessions#create'

  root to: 'users#show'

end
