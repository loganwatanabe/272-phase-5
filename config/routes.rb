Karate67272::Application.routes.draw do


  # Generated routes
  resources :events
  resources :registrations
  resources :sections
  resources :students
  resources :tournaments
  resources :dojo_students
  resources :dojos
  resources :users

  # Sets the root url
  root :to => 'home#index'

  #sets routes for home views
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy

  #sets routes for student views
  match 'active_students' => 'students#active', :as => :active_students
  match 'inactive_students' => 'students#inactive', :as => :inactive_students
  match 'signed' => 'students#signed', :as => :signed_students
  match 'unsigned' => 'students#unsigned', :as => :unsigned_students
  match 'juniors' => 'students#juniors', :as => :juniors_students
  match 'seniors' => 'students#seniors', :as => :seniors_students
  match 'dans' => 'students#dans', :as => :dans_students
  match 'gups' => 'students#gups', :as => :gups_students


  #sets routes for event views
  match 'active_events' => 'events#active', :as => :active_events
  match 'inactive_events' => 'events#inactive', :as => :inactive_events

  #sets routes for section views
  match 'active_sections' => 'sections#active', :as => :active_sections
  match 'inactive_sections' => 'sections#inactive', :as => :inactive_sections

  #sets routes for tournament views
  match 'active_tournaments' => 'tournaments#active', :as => :active_tournaments
  match 'inactive_tournaments' => 'tournaments#inactive', :as => :inactive_tournaments
  match 'past_tournaments' => 'tournaments#past', :as => :past_tournaments
  match 'upcoming_tournaments' => 'tournaments#upcoming', :as => :upcoming_tournaments

  #sets routes for dojo views
  match 'active_dojos' => 'dojos#active', :as => :active_dojos
  match 'inactive_dojos' => 'dojos#inactive', :as => :inactive_dojos

  
end

