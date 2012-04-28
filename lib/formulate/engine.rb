module Formulate
  class Engine < ::Rails::Engine
    initializer 'formulate.initialize' do |app|
      ActiveSupport.on_load(:action_view) do
        include Formulate::FormHelper

        app.config.default_form_builder = Formulate::FormBuilder
      end
    end
  end
end
