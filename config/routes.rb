ActionController::Routing::Routes.draw do |map|
  map.wallpapers "/wallpapers/:computer/:user/:width/:height.:format", :controller => "wallpapers"
  map.logonscreen "/lgbg/:computer/:width/:height.:format", :controller => "wallpapers", :action => "logon"
  map.scripts "/scripts/:action.:format", :controller => "scripts"
  map.resources :user_sessions
  map.resources :users
  map.resources :messages
  map.resources :settings, :collection => { :update_all => :put }
  map.login "/login", :controller => "user_sessions", :action => "new"
  map.logout "/logout", :controller => "user_sessions", :action => "destroy"
  map.root :controller => "messages"
end
