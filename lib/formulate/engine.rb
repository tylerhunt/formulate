require 'formulate'

module Formulate
  class Engine < ::Rails::Engine
    initializer 'formulate.initialize' do |app|
      ActiveSupport.on_load(:action_view) do
        include Formulate::FormHelper
      end
    end
  end
end
