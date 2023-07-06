# frozen_string_literal: true

module UpservFoundations
  module Components
    module Forms
      # search select
      module SearchSelectHelper
        ActionView::Helpers::FormBuilder.class_eval do
          def search_select(method, choices = nil, options = {}, html_options = {},
                            &block)
            if html_options[:multiple]
              Methods.search_select_multiple(method, choices, options,
                                             html_options, template: @template,
                                                           object_name: object_name, &block)
            else
              # eventaully insert code for single search select
              select(method, choices, options, html_options, &block)
            end
          end
        end

        # helper methods for search select
        class Methods
          class << self
            def search_select_multiple(method, choices, options, html_options,
                                       form_vars, &block)
              template = form_vars[:template]
              object_name = form_vars[:object_name]
              html_options = refine_html_options(html_options)
              base_id = set_base_id(html_options, object_name, method)
              search_element = set_search_element(template, base_id, html_options)
              select_element =
                template.select(object_name, method, choices, options, html_options, &block)
              selected_options_container = selected_options_container(template, base_id)
              template.raw("#{search_element}#{select_element}" \
                           "#{selected_options_container}")
            end

            def refine_html_options(html_options)
              html_options[:placeholder] ||= 'Type to search'
              html_options[:data] ||= {}
              html_options[:class] ||= ''
              html_options[:class] += ' search-select-multiple'
              html_options
            end

            def set_base_id(html_options, object_name, method)
              html_options[:id] ||
                (object_name.gsub('-', '_').gsub('[', '_').gsub(']', '_') + method.to_s)
            end

            def set_search_element(template, base_id, html_options)
              template.content_tag('input',
                                   nil,
                                   id: "#{base_id}_search",
                                   class: 'form-control search-select-multiple-input',
                                   type: 'text',
                                   placeholder: html_options[:placeholder])
            end

            def selected_options_container(template, base_id)
              template.content_tag(
                'div',
                nil,
                id: "#{base_id}_selected_options",
                class: 'form-control search-select-multiple-selected-options',
                # add controller to seelcted options so we can have
                # data-action I'd rather have controller here than on a
                # parent that wraps all containers because I want these
                # elements to be direct descendants of the form group
                data: { controller: 'search-select-multiple' }
              )
            end
          end
        end
      end
    end
  end
end
