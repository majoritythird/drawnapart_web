Budgee::Application.routes.draw do

  root 'home#index'

  devise_for :users, :controllers => {:registrations => 'users/registrations'}, :only => :registrations

  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new', :as => 'new_user_session'
    post '/sign_in' => 'devise/sessions#create', :as => 'user_session'
    delete '/sign_out' => 'devise/sessions#destroy', :as => 'destroy_user_session'
  end

  namespace :api do
    namespace :v1 do

      devise_scope :user do
        post '/sign_in' => 'sessions#create', :format => :json
        post '/sign_out' => 'sessions#destroy', :format => :json
        post '/sign_up' => 'registrations#create', :format => :json
      end

      get '/people/:id' => 'people#show', :as => 'person', :format => :json 

    end
  end

end
