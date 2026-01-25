Rails.application.routes.draw do

  root to: "home#index"

  get "/400", to: "errors#bad_request", as: "bad_request"
  get "/403", to: "errors#forbidden", as: "forbidden"
  get "/404", to: "errors#not_found", as: "not_found"
  get "/500", to: "errors#internal_error", as: "internal_error"

  resources :countries, only: [:show] do
    member do
      get "political_divisions", to: "countries#index_political_divisions", as: :political_divisions
      get "political_divisions/:political_division_id", to: "countries#show_political_division", as: :political_division
    end
  end

end
