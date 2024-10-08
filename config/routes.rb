Rails.application.routes.draw do
  devise_for :users
  root 'quizzes#index'

  get "/start_quiz", to: "quizzes#start"

  resources :quizzes do
     post 'submit', on: :member
    resources :questions, shallow: true
    

    get 'continue', on: :collection
    get 'completed', on: :collection
    get 'result', on: :collection
    get 'start'
    post 'take'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
