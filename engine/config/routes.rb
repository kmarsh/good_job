GoodJob::Engine.routes.draw do
  root to: 'dashboards#index'
  resources :active_jobs, only: :show
  resources :job_classes, only: [:index, :show] do
    resources :jobs, only: [:new, :create]
  end
end
