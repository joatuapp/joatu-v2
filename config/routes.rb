Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  scope "(:locale)", locale: /en|fr/ do
    resources :events

    resources :organizations

    resources :references, except: [:index, :show]

    resources :messages, only: [:new, :create]

    resources :conversations, only: [:index, :show, :update, :destroy]

    resources :profiles

    resources :requests, concerns: :paginatable do
      collection do
        get 'search/(page/:page)', :action => :search, :as => 'search'
      end
    end

    resources :offers, concerns: :paginatable do
      collection do
        get 'search/(page/:page)', :action => :search, :as => 'search'
      end
    end

    resources :caps_transactions, only: [:create]

    resources :hubs

    resources :community_offers, only: [:new, :create]

    devise_for :users, controllers: { invitations: 'users/invitations' }
    resources :users, only: [:edit, :update, :destroy]

    get 'pods/home', controller: :pods, action: :home, as: :home_pod
    resources :pods do
    end

    get 'home', to: 'static_page#home'
    get 'alpha_signup', to: 'static_page#alpha_signup'
    get 'tou', to: 'static_page#tou', as: :tou
    get 'help', to: 'static_page#help', as: :help

    get '/:locale', to: 'static_page#home'
    root 'static_page#home'
  end

  namespace :admin do
    get '/generate_caps', to: 'caps#new'
    post '/generate_caps', to: 'caps#create'
  end

  ActiveAdmin.routes(self)
  
  # These are a bunch of redirect routes for old blog articles, so that when we
  # point joatu.com at this app we don't break the old links.
  get '/faq', to: redirect("https://joatu.wordpress.com/faq/")
  get '/press', to: redirect("https://joatu.wordpress.com/press/")
  get '/volunteer', to: redirect("https://joatu.wordpress.com/volunteer/")
  get '/community', to: redirect("https://joatu.wordpress.com/community/")
  get '/contact', to: redirect("https://joatu.wordpress.com/contact/")
  get '/blog', to: redirect("http://joatu.wordpress.com/")
  get '/how-i-thrived-on-a-basic-income-of-11000-last-year-in-montreal', to: redirect("https://joatu.wordpress.com/2015/01/29/how-i-thrived-on-a-basic-income-of-11000-last-year-in-montreal/")
  get '/grass-to-gardens-joatus-community-initiative', to: redirect("https://joatu.wordpress.com/2014/09/04/grass-to-gardens-joatus-community-initiative/")
  get '/peoples-social-forum-2014-space-for-change', to: redirect("https://joatu.wordpress.com/2014/08/27/peoples-social-forum-2014-space-for-change/")
  get '/the-other-side-of-basic-income-basic-jobs', to: redirect("https://joatu.wordpress.com/2014/07/28/the-other-side-of-basic-income-basic-jobs/")
  get '/what-i-learned-at-the-hopex-hacker-conference', to: redirect("https://joatu.wordpress.com/2014/07/23/what-i-learned-at-the-hopex-hacker-conference/")
  get '/joatu-relaunches-its-campaign-3500-to-goal', to: redirect("https://joatu.wordpress.com/2014/07/10/joatu-relaunches-its-campaign-3500-to-goal/")
  get '/press-release-apr15-2014-crowd-funding-campaign-launch', to: redirect("https://joatu.wordpress.com/2014/04/15/press-release-apr15-2014-crowd-funding-campaign-launch/")
  get '/joatu-org-invitation', to: redirect("https://joatu.wordpress.com/2015/02/02/joatu-org-opens-up-invitations/")
end
