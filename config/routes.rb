SplitmateApp::Application.routes.draw do

  resources :users
  resources :apartments do
    resources :chores, shallow: true
  end
  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  post '/sessions' => 'sessions#create'
  get '/apartments/:id/addroommates' => 'apartments#add_roommates'
  post '/saveroommate' => 'users#save_roommate'

  root to: 'users#index'

end
