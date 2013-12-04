module Formulate
  module FormHelper
    FIELD_ERROR_PROC = proc { |html_tag, instance_tag| html_tag }

    def form_for(record, options={}, &proc)
      options[:html] ||= {}
      options[:builder] ||= FormBuilder

      case record
      when String, Symbol
        options[:html][:class] ||= ''
      else
        object = record.is_a?(Array) ? record.last : record
        raise ArgumentError, 'First argument in form cannot contain nil or be empty' unless object
        apply_form_for_options!(record, object, options)
      end

      options[:html][:class] << ' formulate'
      options[:html][:class] << " #{options[:class]}" if options[:class]
      options[:html][:class].strip!

      original_field_error_proc = ::ActionView::Base.field_error_proc
      ::ActionView::Base.field_error_proc = FIELD_ERROR_PROC
      super
    ensure
      ::ActionView::Base.field_error_proc = original_field_error_proc
    end
  end
end
