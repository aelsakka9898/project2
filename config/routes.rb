Rails.application.routes.draw do
  get 'demo/new'

  resources :locations
  resources :instructors
  resources :curriculums
  resources :camp_instructors
  resources :camps
  resources :aboutus
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'curriculums/index' , to: 'curriculums#index' 
  get 'camp/index', to: 'camp#index' , as: :campindex
  get 'location/index'
  get 'instructor/index'
  get 'camp_instructor/index'
  

  get 'aboutus/new' 
  get 'privacy/new' 
  get 'contactus/new' 
  root to: 'demo#new'
  
  get 'about', to: 'aboutus#new'
  get 'privacy', to: 'privacy#new'
  get 'contact', to: 'contactus#new'



end
