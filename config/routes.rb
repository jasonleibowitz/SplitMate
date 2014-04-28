SplitmateApp::Application.routes.draw do

  resources :users
  resources :apartments do
    resources :chores, shallow: true
    resources :chore_histories, shallow: true
  end

  get '/login' => 'sessions#new'
  get '/logout' => 'sessions#destroy'
  post '/sessions' => 'sessions#create'
  get '/apartments/:id/addroommates' => 'apartments#add_roommates'
  post '/saveroommate' => 'users#save_roommate'
  get '/assignchore/:id/' => 'chores#assign_chore'
  get '/completechore/:id' => 'chores#complete_chore'

  root to: 'users#index'

end
