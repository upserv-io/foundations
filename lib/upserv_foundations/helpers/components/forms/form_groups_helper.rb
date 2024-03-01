module UpservFoundations
  module Components
    module Forms
      # Create inline errors helper
      module FormGroupsHelper
        def show_group(label = nil, value_or_options = nil, options = {}, &block)
          value = value_or_options.is_a?(Hash) ? nil : value_or_options
          value = label if value_or_options.is_a?(Hash)
          options = value_or_options if value_or_options.is_a?(Hash)
          options = label if label.is_a?(Hash)
          vertical_condensed = options.delete(:vertical_condensed) || nil
          label_width = options.delete(:label_width) || 'w-20'
          full_custom = options.delete(:full_custom) || false
          no_label = options.delete(:no_label) || false
          top_label = options.delete(:top_label) || false
          group_width = options.delete(:group_width)
          if no_label
            content_tag :div, class: "form-group #{group_width}".strip do
              if block
                content_tag :div, class: 'show-value' do
                  block.call
                end
              else
                content_tag :div, value, class: 'show-value'
              end
            end
          elsif top_label
            content_tag :div, class: "form-group #{group_width}".strip do
              if full_custom
                block.call
              else
                label_html = content_tag :div, class: "left-label-container #{label_width}" do
                  content_tag :div, label
                end
                show_html = if block
                              content_tag :div, class: 'show-value' do
                                block.call
                              end
                            else
                              content_tag :div, value, class: 'show-value'
                            end
                (label_html + show_html).html_safe
              end
            end
          else
            content_tag :div, class: "form-group left-label #{group_width} #{vertical_condensed}".strip do
              if full_custom
                block.call
              else
                label_html = content_tag :div, class: "left-label-container #{label_width}" do
                  content_tag :div, label
                end
                value_html = content_tag :div, class: 'left-label-input' do
                  if block
                    content_tag :div, class: 'show-value' do
                      block.call
                    end
                  else
                    content_tag :div, value, class: 'show-value'
                  end
                end
                (label_html + value_html).html_safe
              end
            end
          end
        end

        ActionView::Helpers::FormBuilder.class_eval do
          def input_group(input = nil, method = nil, options = {}, &block)
            # clean up options
            # input will actually be "options" if no input or method are given
            options = input if method.nil? && options == {}
            options = {} if options.nil?

            # misc options
            full_custom = options.delete(:full_custom) || false
            inline_errors = options.delete(:inline_errors) || true
            inline_errors_options = options.delete(:inline_errors_options) || {}

            # label formats
            no_label = options.delete(:no_label) || false
            top_label = options.delete(:top_label) || false

            # other formats
            radio = options.delete(:radio) || false
            stacked = options.delete(:stacked) || false
            toggle = options.delete(:toggle) || false
            checkbox = options.delete(:checkbox) || false

            # label options
            label = options.delete(:label) || method.to_s.titleize
            label_options = options.delete(:label_options) || {}

            # Width options
            label_width = options.delete(:label_width) || 'w-20'
            group_width = options.delete(:group_width)

            # input options
            options[:class] = "form-control #{options[:class]}".strip

            if no_label
              @template.content_tag :div, class: "form-group #{group_width}".strip do
                if block
                  block.call
                else
                  input_group_input_and_errors_html(input, object_name, method, options, inline_errors, inline_errors_options)
                end
              end
            elsif top_label
              @template.content_tag :div, class: "form-group #{group_width}".strip do
                if full_custom
                  block.call
                elsif block
                  label_html = @template.label object_name, method || label.downcase.to_sym, "#{label}:", label_options
                  input_and_erros_html = @template.capture(&block)
                  (label_html + input_and_erros_html).html_safe
                else

                  label_html = @template.label object_name, method || label.downcase.to_sym, "#{label}:", label_options
                  input_and_erros_html = input_group_input_and_errors_html(input, object_name, method, options, inline_errors, inline_errors_options)
                  (label_html + input_and_erros_html).html_safe
                end
              end
            else
              # standard component
              @template.content_tag :div, class: "form-group left-label #{group_width}".strip do
                if full_custom
                  block.call
                else
                  label_group_html = @template.content_tag :div, class: "left-label-container #{label_width}" do
                    @template.label object_name, method || label.downcase.to_sym, "#{label}:", label_options
                  end
                  input_group_html = @template.content_tag :div, class: 'left-label-input' do
                    if radio || checkbox
                      c_ops = {}
                      klass = "checkable-group-container #{'inline' unless stacked}".strip
                      c_ops[:class] = klass
                      if radio && toggle
                        c_ops[:data] = { controller: 'form--radio-display-toggle' }
                      end
                      checkable_group_container_html = @template.content_tag :div, c_ops do
                        block.call
                      end
                      inline_errors_html = inline_errors ? inline_errors(method, inline_errors_options) : ''
                      (checkable_group_container_html + inline_errors_html).html_safe
                    # if block is given, then the input is a custom input
                    elsif block
                      block.call
                    else
                      input_group_input_and_errors_html(input, object_name, method, options, inline_errors, inline_errors_options)
                    end
                  end
                  (label_group_html + input_group_html).html_safe
                end
              end
            end
          end

          def input_group_input_and_errors_html(input, object_name, method, options, inline_errors, inline_errors_options)
            input_html = @template.send(input, object_name, method, objectify_options(options))
            inline_errors_html = inline_errors ? inline_errors(method, inline_errors_options) : ''
            (input_html + inline_errors_html).html_safe
          end

          def radio_button_contained(method, value, options = {})
            checkable_right = options.delete(:checkable_right) || false
            options[:class] = "form-control #{options[:class]}".strip
            label = options.delete(:label) || value.to_s.titleize
            label_options = options.delete(:label_options) || {}
            label_options[:value] = value
            label_options[:class] = "checkable-#{checkable_right ? 'right' : 'left'} #{label_options[:class]}".strip

            @template.content_tag :div, class: 'checkable-container' do
              radio_button_html = @template.radio_button object_name, method, value, options
              label_html = @template.label object_name, method, label, label_options
              (radio_button_html + label_html).html_safe
            end
          end

          def checkbox_contained(method, options = {})
            inline_errors = options.delete(:inline_errors) || true
            inline_errors_options = options.delete(:inline_errors_options) || {}
            checkable_right = options.delete(:checkable_right) || false
            options[:class] = "form-control #{options[:class]}".strip
            show_class = options.delete(:show_class) || false
            hide_class = options.delete(:hide_class) || false
            if show_class || hide_class
              options[:data] ||= {}
              options[:data][:controller] = 'form--checkbox-display-toggle'
              options[:data][:show_class] = show_class if show_class
              options[:data][:hide_class] = hide_class if hide_class
            end
            label = options.delete(:label) || method.to_s.titleize
            label_options = options.delete(:label_options) || {}
            label_options[:class] = "checkable-#{checkable_right ? 'right' : 'left'} #{label_options[:class]}".strip

            @template.content_tag :div, class: 'checkbox-and-errors-container' do
              checkable = @template.content_tag :div, class: 'checkable-container' do
                checkbox_html = @template.check_box object_name, method, options
                label_html = @template.label object_name, method, label, label_options
                (checkbox_html + label_html).html_safe
              end
              inline_errors_html = inline_errors ? inline_errors(method, inline_errors_options) : ''
              (checkable + inline_errors_html).html_safe
            end
          end
        end
      end
    end
  end
end
