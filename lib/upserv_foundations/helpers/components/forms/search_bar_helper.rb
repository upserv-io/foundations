# frozen_string_literal: true

module UpservFoundations
  module Components
    module Forms
      # search bar
      module SearchBarHelper
        def search_bar(url_helper, url_helper_args, options = {})
          url_helper_options = options.delete(:url_helper_options) || {}
          placeholder = options.delete(:placeholder) || 'Search'
          default_style = 'width: 20rem;'
          options[:style] = "#{default_style}#{" #{options[:style]}" if options[:style]}"
          content_tag 'DIV', options do
            form_with(scope: :filters, url: method(url_helper).call(*url_helper_args, url_helper_options.merge(filter)), method: :get) do |f|
              filters_array = []
              filters.each do |key, value|
                filters_array << f.hidden_field(key, value: value)
              end
              filters_html = filters_array.join

              entire_search_bar = content_tag 'DIV', class: 'form-search' do
                search_input_container = content_tag 'DIV', class: 'form-search-bar' do
                  text_input = f.text_field :search, value: filters[:search], placeholder: placeholder, class: 'form-control'
                  clear_link = link_to 'clear', method(url_helper).call(*url_helper_args, url_helper_options.merge(filter(search: nil))), class: 'form-search-clear' if filters[:search].present?
                  (text_input + clear_link).html_safe
                end
                submit_button = f.submit 'Search', class: 'btn btn-search'
                (search_input_container + submit_button).html_safe
              end
              (filters_html + entire_search_bar).html_safe
            end
          end
        end
      end
    end
  end
end
