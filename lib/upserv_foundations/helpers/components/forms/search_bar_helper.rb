# frozen_string_literal: true

module UpservFoundations
  module Components
    module Forms
      # search bar
      module SearchBarHelper
        def search_bar(url_helper, url_helper_args, options = {})
          url_helper_options ||= {}
          placeholder = options[:placeholder] || 'Search'
          klass = 'mr-2'
          klass += " #{options[:class]}" if options[:class]
          default_style = 'width: 20rem;'
          style = "#{default_style}#{" #{options[:style]}" if options[:style]}"
          content_tag 'DIV', style: style do
            form_with(scope: :filters, url: method(url_helper).call(*url_helper_args, url_helper_options.merge(filter)), method: :get, class: klass) do |f|
              filters.each do |key, value|
                concat f.hidden_field(key, value: value)
              end

              content_tag 'DIV', class: 'form-search' do
                search_input_container = content_tag 'DIV', class: 'form-search-bar' do
                  text_input = f.text_field :search, value: filters[:search], placeholder: placeholder, class: 'form-control'
                  clear_link = link_to 'clear', method(url_helper).call(*url_helper_args, url_helper_options.merge(filter(search: nil))), class: 'form-search-clear' if filters[:search].present?
                  (text_input + clear_link).html_safe
                end
                submit_button = f.submit 'Search', class: 'btn btn-search'
                (search_input_container + submit_button).html_safe
              end
            end
          end
        end
      end
    end
  end
end
