require 'carmen'

module Formulate
  class FormBuilder < ActionView::Helpers::FormBuilder
    def errors
      if (errors = errors_on(:base)).any?
        header = I18n.t('errors.template.header', count: errors.length)

        @template.capture_haml do
          @template.haml_tag(:fieldset, class: 'errors') do
            @template.haml_tag(:legend, header)

            @template.haml_tag(:ul, class: 'errors') do
              errors.each { |message| @template.haml_tag(:li, message) }
            end
          end
        end
      end
    end

    def fieldset(options={}, &block)
      legend = options.delete(:legend)

      @template.capture_haml do
        @template.haml_tag(:fieldset, options) do
          @template.haml_tag(:legend, legend) if legend
          yield(self)
        end
      end
    end

    def section(options={}, &block)
      options[:class] = "#{options[:class]} section".strip

      @template.capture_haml do
        @template.haml_tag(:div, options) { yield(self) }
      end
    end

    def input(method, options={}, &block)
      type = options.delete(:type)
      prefix = options.delete(:prefix)
      suffix = options.delete(:suffix)
      instructions = options.delete(:instructions)
      errors = errors_on(method)

      classes = ['field']
      classes << (options.delete(:required) ? 'required' : 'optional')
      classes << 'checkbox' if type == :check_box
      classes << 'radio' if type == :radio_button
      classes << options.delete(:class) if options[:class]
      classes.uniq!

      input = case type
        when :check_box
          checked_value = options.delete(:checked_value)
          unchecked_value = options.delete(:unchecked_value)
          checked_value = '1' if unchecked_value && checked_value.blank?
          arguments = [options, checked_value, unchecked_value].compact
          send(type, method, *arguments)
        when :radio_button
          value = options.delete(:value)
          object_method = method
          method = "#{method.to_s.gsub(/\?$/, '')}_#{value.gsub(/\s/, '_')}".downcase
          send(type, object_method, value, options)
       when :date_select
          @template.capture_haml do
            @template.haml_tag(:div, input, class: 'group')
          end
        when :collection_select
          collection = options.delete(:collection)
          value_method = options.delete(:value_method)
          text_method = options.delete(:text_method)
          html_options = options.delete(:html) || {}
          send(type, method, collection, value_method, text_method, options, html_options)
        when :time_zone_select
          priority_zones = options.delete(:priority_zones)
          send(type, method, priority_zones, options)
        when :state_select
          country = options.delete(:country) || Carmen.default_country
          html_options = options.delete(:html) || {}
          send(type, method, country, options, html_options)
        when :country_select
          priority_countries = options.delete(:priority_countries)
          html_options = options.delete(:html) || {}
          send(type, method, priority_countries, options, html_options)
        else
          send(type, method, options)
      end unless block_given?

      label = options[:label] != false ? label(method, options[:label]) : nil
      markup = [label, prefix, input, suffix].compact
      markup.reverse! if type.in?(:check_box, :radio_button)

      markup << @template.capture_haml do
        yield(object.send(method)) if block_given?
        errors_list(errors)
        instructions(instructions)
      end

      @template.capture_haml do
        @template.haml_tag(:div, class: classes.join(' ')) do
          @template.haml_concat(markup.join)
        end
      end
    end

    alias_method :hidden, :hidden_field

    def text(method, options={}, &block)
      input(method, options.merge(type: :text_field), &block)
    end

    def email(method, options={}, &block)
      input(method, options.merge(type: :email_field), &block)
    end

    def number(method, options={}, &block)
      input(method, options.merge(type: :number_field), &block)
    end

    def password(method, options={}, &block)
      input(method, options.merge(type: :password_field), &block)
    end

    def area(method, options={}, &block)
      input(method, options.merge(type: :text_area), &block)
    end

    def checkbox(method, options={}, &block)
      input(method, options.merge(type: :check_box), &block)
    end

    def radio(method, options={}, &block)
      input(method, options.merge(type: :radio_button), &block)
    end

    def file(method, options={}, &block)
      input(method, options.merge(type: :file_field), &block)
    end

    def select(*args, &block)
      method = args.shift
      options = args.extract_options!

      options[:collection] = args[0]
      options[:value_method] = args[1]
      options[:text_method] = args[2]
      input(method, options.merge(type: :collection_select), &block)
    end

    def date(method, options={}, &block)
      input(method, options.merge(type: :date_select), &block)
    end

    def time(method, options={}, &block)
      input(method, options.merge(type: :time_select), &block)
    end

    def date_time(method, options={}, &block)
      input(method, options.merge(type: :datetime_select), &block)
    end

    def state(method, options={}, &block)
      input(method, options.merge(type: :state_select), &block)
    end

    def country(method, options={}, &block)
      input(method, options.merge(type: :country_select), &block)
    end

    def expiration(method, options={}, &block)
      options.reverse_merge!(add_month_numbers: true, discard_day: true, order: [:month, :year], start_year: Date.today.year, prompt: '')
      input(method, options.merge(type: :date_select), &block)
    end

    def time_zone(method, options, &block)
      input(method, options.merge(type: :time_zone_select), &block)
    end

    def instructions(text_or_nil_with_block=nil, &block)
      if text_or_nil_with_block
        content = text_or_nil_with_block || @template.capture_haml(&block)
        @template.haml_tag(:p, content, class: 'instructions')
      end
    end

    def submit(value, options={}, &block)
      @template.capture_haml do
        @template.haml_tag(:div, class: 'submit') do
          @template.haml_concat(super(value, options))
          yield(self) if block_given?
        end
      end
    end

    def errors_on(method)
      object.respond_to?(:errors) ? object.errors[method] : []
    end
    private :errors_on

    def errors_list(errors)
      if errors.any?
        error_messages = "#{errors.to_sentence.capitalize}."
        @template.haml_tag(:p, error_messages, class: 'errors')
      end
    end
    private :errors_list
  end
end
