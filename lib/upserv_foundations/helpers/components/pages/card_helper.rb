# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def card_header(options = {}, &block)
          divider = options.key?(:divider) ? options.delete(:divider) : true
          options[:class] = "card-header#{" #{options[:class]}" if options[:class]}"

          header_elm = content_tag 'div', options do
            block.call
          end

          divider_eml = content_tag 'div', '', class: 'card-header-divider' if divider
          "#{header_elm}#{divider_eml}".html_safe
        end

        def card_body(options = {}, &block)
          remove_padding = if options.keys.include?(:remove_padding)
                             options.delete(:remove_padding)
                           else
                             false
                           end
          options[:class] = "card-body#{" #{options[:class]}" if options[:class]}#{' remove-padding' if remove_padding}"
          content_tag 'DIV', options do
            block.call
          end
        end

        def table_card(options = {}, &block)
          options[:full_height] = true unless options.keys.include?(:full_height)
          card(options, &block)
        end

        def table_card_header(options = {}, &block)
          options[:divider] = false
          card_header(options, &block)
        end

        def table_card_body(options = {}, &block)
          options[:remove_padding] = true
          card_body(options, &block)
        end
      end
    end
  end
end
