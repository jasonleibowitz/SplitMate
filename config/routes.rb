SplitmateApp::Application.routes.draw do

  resources :users
  resources :apartments do
    resources :chores, shallow: true
  end

end
