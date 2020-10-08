Rails.application.routes.draw do

 

  resources :careers
  resources :departments
  resources :desertions
  resources :studentannotations
  resources :typetutorials
  resources :admin

  resources :academic_units do
    resources :departments
  end

  post 'upload', to: "admin#upload"
  get '/actualize', to:"admin#actualize"
  post 'chooseCarrer', to: "departments#chooseCarrer"
  post 'chooseYear', to: "admin#chooseYear"
  get 'student_tutorials/:id/update' => 'student_tutorials#getPercent'


  devise_for :users,
           :controllers  => {
             :registrations => 'users/registrations',
           
           }
  resources :users
  
  resources :subjects

  get 'welcome/dashboard'
  root 'welcome#dashboard'
  
  get '/report', to: "welcome#report"

  get 'reporte', to: "welcome#report"
  post '/image', to: "welcome#save"


  #resources admin
  #only or except
  resources :students, except:[:delete]
  resources :tutors, except:[:delete]


  resources :tutorials do
      resources :annotations, :only => [:create, :index, :new]
    
  end

  resources :annotations do
    resources :annotations
  end

  resources :student_tutorials
  resources :tutor_tutorials
  resources :activities
  
  

 # resources :tutor_tutorials, except:[:delete]

  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#server_error'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
