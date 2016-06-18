Rails.application.routes.draw do
  devise_for :users

  devise_for :admins

  authenticated :admin do
    root 'background/homes#home', as: :authenticated_root
  end

  get 'investments/index'

  get 'investments/edit'

  get 'investments/show'

  get 'investments/destroy'

  root 'static_pages#home'

  resources :users
  resources :loans
  resources :investments
  resources :contacts

  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'help' => 'static_pages#help'
  get 'full_index' => 'loans#full_index'
  get 'search_loan' => 'loans#search'
  post 'search_loan' => 'loans#search'
  get 'add_money' => 'users#add_money'
  post 'pay' => 'users#pay'
  get 'pay' => 'users#pay'
  get 'return_loan' => 'users#return_loan'
  get 'return_pay' => 'users#return_pay'
  post 'return_pay' => 'users#return_pay'

  namespace :background do
    root 'homes#home'
    resources :checks
    resources :manage_loans
    resources :manage_investments
    resources :manage_users
    resources :manage_accounts
    resources :manage_contacts

    get 'search_user' => 'manage_users#search_user'
    post 'search_user' => 'manage_users#search_user'

    get 'high_search_user' => 'manage_users#search'
    post 'high_search_user' => 'manage_users#search'

    get 'high_search_loan' => 'manage_loans#search'
    post 'high_search_loan' => 'manage_loans#search'

    get 'high_search_loan_full' => 'manage_loans#search_full'
    post 'high_search_loan_full' => 'manage_loans#search_full'

    get 'loan_index_full' => 'manage_loans#index_full'

    get 'high_search_investment' => 'manage_investments#search'
    post 'high_search_investment' => 'manage_investments#search'

    get 'high_search_account' => 'manage_accounts#search'
    post 'high_search_account' => 'manage_accounts#search'

    patch 'reject_loan' => 'manage_loans#reject_loan'
    get 'reject_loan' => 'manage_loans#reject_loan'
  end
  # get 'static_pages/home'
  #
  # get 'static_pages/about'
  #
  # get 'static_pages/contact'
  #
  # get 'static_pages/help'

  get 'account_info' => 'users#account_info'

  get 'show_user' => 'loans#show_user'

  get 'update_head' => 'users#update_head'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
