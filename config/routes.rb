Budgee::Application.routes.draw do

  root 'home#index'

  devise_for :users, :only => :registrations

  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new', :as => 'new_user_session'
    post '/sign_in' => 'devise/sessions#create', :as => 'user_session'
    delete '/sign_out' => 'devise/sessions#destroy', :as => 'destroy_user_session'
  end

  namespace :api do
    namespace :v1 do

      devise_scope :user do
        post '/sign_in' => 'api/v1/sessions#create', :format => :json
        post '/sign_out' => 'api/v1/sessions#destroy', :format => :json
        post '/sign_up' => 'api/v1/registrations#create', :format => :json
      end

    end
  end

end
