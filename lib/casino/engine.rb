require 'casino'
require 'casino/inflections'

module CASino
  class Engine < Rails::Engine
    isolate_namespace CASino

    rake_tasks { require 'casino/tasks' }

    initializer :yaml_configuration do |app|
      apply_yaml_config load_file('config/cas.yml')
    end
    config.autoload_paths << File.expand_path("lib", __dir__)
    # CASino::Engine.routes.draw do
    #   mount CASino::API => '/api'
    #
    #   resources :sessions, only: [:index, :destroy]
    #   resources :two_factor_authenticators, only: [:new, :create, :destroy]
    #
    #   get 'login' => 'sessions#new'
    #   post 'login' => 'sessions#create'
    #   get 'logout' => 'sessions#logout'
    #   post 'validate_otp' => 'sessions#validate_otp'
    #
    #   get 'destroy-other-sessions' => 'sessions#destroy_others'
    #
    #   get 'validate' => 'service_tickets#validate'
    #   get 'serviceValidate' => 'service_tickets#service_validate'
    #
    #   get 'proxyValidate' => 'proxy_tickets#proxy_validate'
    #   get 'proxy' => 'proxy_tickets#create'
    #
    #   get 'authTokenLogin' => 'auth_tokens#login'
    #
    #   root to: redirect('login')
    # end

    private
    def apply_yaml_config(yaml)
      cfg = (YAML.load(ERB.new(yaml).result)||{}).fetch(Rails.env, {})
      cfg.each do |k,v|
        value = if v.is_a? Hash
          CASino.config.fetch(k.to_sym,{}).merge(v.symbolize_keys)
        else
          v
        end
        CASino.config.send("#{k}=", value)
      end
    end

    def load_file(filename)
      fullpath = File.join(Rails.root, filename)
      IO.read(fullpath) rescue ''
    end

  end
end
