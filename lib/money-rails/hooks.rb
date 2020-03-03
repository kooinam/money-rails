module MoneyRails
  class Hooks
    PG_ADAPTERS = %w(activerecord-jdbcpostgresql-adapter postgresql postgis)

    def self.init
      # For Mongoid
      begin; require 'mongoid'; require 'mongoid/version'; rescue LoadError; end
      if defined? ::Mongoid
        if ::Mongoid::VERSION =~ /^2(.*)/
          require 'money-rails/mongoid/two' # Loading the file is enough
        else
          require 'money-rails/mongoid/money'
        end
      end

      # For ActionView
      ActiveSupport.on_load(:action_view) do
        require 'money-rails/helpers/action_view_extension'
        ::ActionView::Base.send :include, MoneyRails::ActionViewExtension
      end
    end
  end
end
