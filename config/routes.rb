Rails.application.routes.draw do
  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup",
             },
             controllers: {
               sessions: "sessions",
               registrations: "registrations",
             }
  namespace "api" do
    resources :images
    get "/personal", to: "images#index_personal"
    post "images/search", to: "images#search_image"
  end
end
