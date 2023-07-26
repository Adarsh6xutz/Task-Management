Rails.application.routes.draw do
  resources :users, only: [:create]

  resources :tasks, only: [:create, :show, :update, :destroy] do
    patch '/set_assignee', on: :member, to: 'tasks#set_assignee'
    patch '/complete', on: :member, to: 'tasks#complete'
  end

  get '/login', to: 'authentication#login'
end
