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
              SelectMultipleMethods.search_select_multiple(method, choices, options,
                                                           html_options, template: @template,
                                                                         object_name: object_name, &block)
            else
              # eventaully insert code for single search select
              SelectSingleMethods.search_select(method, choices, options,
                                                html_options, template: @template,
                                                              object_name: object_name, &block)
            end
          end
        end

        # shared helper methods for search select
        class SharedMethods
          class << self
            def base_id(html_options, object_name, method)
              html_options[:id] ||
                # merge with "_" however, this could end with joining with "__" so replace "__" with "_"
                # this way, both of these work
                # object_name: "some_value"
                # object_name: "some_value[soem_value]"
                "#{object_name.to_s.gsub('-', '_').gsub('[', '_').gsub(']', '_')}_#{method}".gsub(
                  '__', '_'
                )
            end
          end
        end

        # helper methods for search select multiple
        class SelectMultipleMethods
          class << self
            def search_select_multiple(method, choices, options, html_options,
                                       form_vars, &block)
              template = form_vars[:template]
              object_name = form_vars[:object_name]
              html_options = refine_html_options(html_options)
              placeholder = html_options.delete(:placeholder)
              base_id = SharedMethods.base_id(html_options, object_name, method)
              (search_multiple_element(template, base_id, placeholder) +
               template.select(object_name, method, choices, options, html_options, &block) +
               selected_options_container(template, base_id)).html_safe
            end

            def refine_html_options(html_options)
              html_options[:placeholder] ||= 'Type to search'
              html_options[:data] ||= {}
              html_options[:class] ||= ''
              html_options[:class] += ' search-select-multiple'
              html_options
            end

            def search_multiple_element(template, base_id, placeholder)
              template.content_tag('input',
                                   nil,
                                   id: "#{base_id}_search",
                                   class: 'form-control search-select-multiple-input',
                                   type: 'text',
                                   placeholder: placeholder)
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

        # helper methods for search select single
        class SelectSingleMethods
          class << self
            def search_select(method, choices, options, html_options,
                              form_vars, &block)
              template = form_vars[:template]
              object_name = form_vars[:object_name]
              html_options = refine_html_options(html_options)
              placeholder = html_options.delete(:placeholder)
              base_id = SharedMethods.base_id(html_options, object_name, method)
              html_options[:id] = base_id
              template.content_tag 'DIV', class: 'search-select-single-container' do
                (display_input(template, base_id) +
                 search_input(template, base_id, placeholder) +
                 options_container(template, base_id, placeholder) +
                 template.select(object_name, method, choices, options, html_options,
                                 &block)).html_safe
              end
            end

            def display_input(template, base_id)
              template.content_tag('input',
                                   nil,
                                   id: "#{base_id}_display",
                                   class: 'form-control search-select-single-display',
                                   readonly: true,
                                   type: 'text')
            end

            def search_input(template, base_id, placeholder)
              template.content_tag('input',
                                   nil,
                                   id: "#{base_id}_search",
                                   class: 'form-control search-select-single-input',
                                   type: 'text',
                                   placeholder: placeholder)
            end

            def options_container(template, base_id, placeholder)
              template.content_tag('DIV',
                                   '',
                                   id: "#{base_id}_options",
                                   class: 'form-control search-select-single-options',
                                   type: 'text',
                                   placeholder: placeholder)
            end

            def refine_html_options(html_options)
              html_options[:placeholder] ||= 'Type to search'
              html_options[:multiple] = true
              html_options[:data] ||= {}
              html_options[:class] ||= ''
              html_options[:class] += ' search-select-single-hidden-select'
              html_options[:data] = { controller: 'search-select' }
              html_options
            end
          end
        end
      end
    end
  end
end
