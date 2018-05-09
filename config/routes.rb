Rails.application.routes.draw do
  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  devise_for :users
  root 'home#index'
  
  # AJAX
  get 'ajax/email_compose', to: 'ajax#email_compose', as: :ajax_email_compose
  get 'ajax/email_list', to: 'ajax#email_list', as: :ajax_email_list
  get 'ajax/email_opened', to: 'ajax#email_opened', as: :ajax_email_opened
  get 'ajax/email_reply', to: 'ajax#email_reply', as: :ajax_email_reply
  get 'ajax/demo_widget', to: 'ajax#demo_widget', as: :ajax_demo_widget
  get 'ajax/data_list.json', to: 'ajax#data_list', as: :ajax_data_list
  get 'ajax/notify_mail', to: 'ajax#notify_mail', as: :ajax_notify_mail
  get 'ajax/notify_notifications',
      to: 'ajax#notify_notifications',
      as: :ajax_notify_notifications
  get 'ajax/notify_tasks', to: 'ajax#notify_tasks', as: :ajax_notify_tasks

  # Misc methods
  get '/home/set_locale', to: 'home#set_locale', as: :home_set_locale

  # CK editor
  mount Ckeditor::Engine => '/ckeditor'

  resources :groups, only: [:create, :update, :destroy] do
    resources :categories, except: [:show, :new, :edit]
    get "categories/:id", to: "categories#get_category_ajax", constraint: OnlyAjaxRequest.new

    resources :products, except: [:show, :new, :edit]
    get "products/:id", to: "products#get_product_ajax", constraint: OnlyAjaxRequest.new

    resources :group_members, only: [:index, :create, :destroy], path: '/group-members'
    get "users/get_user", to: "users#get_user_ajax", constraint: OnlyAjaxRequest.new

    resources :transactions
  end
  
  get "groups/:id", to: "groups#get_group_ajax", constraint: OnlyAjaxRequest.new
  post "groups/blocked/:id", to: "groups#post_group_blocked_ajax", constraint: OnlyAjaxRequest.new

  resources :users, except: [:create, :show]
  post "users/create", to: "users#create"
  get "users/ajaxValidateFieldUser", to: "users#ckeck_user_exists_ajax", constraint: OnlyAjaxRequest.new
end
