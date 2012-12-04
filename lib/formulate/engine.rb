require 'formulate'

module Formulate
  class Engine < ::Rails::Engine
    initializer 'formulate.initialize', before: 'action_view.set_configs' do |app|
      app.config.action_view.default_form_builder = Formulate::FormBuilder

      ActiveSupport.on_load(:action_view) do
        include Formulate::FormHelper
      end
    end
  end
end
