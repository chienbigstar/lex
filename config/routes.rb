Rails.application.routes.draw do
  root "home#index"
  get "home/word", to: "home#word"
end
