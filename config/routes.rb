Rails.application.routes.draw do
  resources :user, only: [:new, :create, :show] do
    member do
      get :join_chat_room
      resources :room, only: [:new, :create] do
        get :show_room
        get :add_member
        get :remove_member
        get :leave_room
        get :delete_chat_room
      end
    end
  end
  get 'messages/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sessions#new"
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get 'signup', to: 'user#new'
  post 'set_room', to: 'room#set_room'


  mount ActionCable.server, at:'/cable'
end
