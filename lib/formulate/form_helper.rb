module Formulate
  module FormHelper
    def form_for(record, options={}, &proc)
      options[:html] ||= {}
      options[:html][:class] ||= 'formulate'
      super
    end
  end
end
