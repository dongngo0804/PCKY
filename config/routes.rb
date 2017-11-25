Rails.application.routes.draw do
  root 'top#index'
  post 'ajax/add_rules', to: 'ajax#add_rules', as: 'ajax_add_rule'
end