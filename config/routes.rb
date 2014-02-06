NewedenIo::Application.routes.draw do
  devise_for :users,  path: '', path_names: { sign_up: 'signup', sign_in: 'signin', sign_out: 'signout' }

  get 'dashboard/index'
  root 'dashboard#index'
end
