# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def card(options = {}, &block)
          # get height related data and store in variable(s)
          max_height_full = if options.keys.include?(:max_height_full)
                              options.delete(:max_height_full)
                            else
                              true
                            end
          max_height = options.delete(:max_height)
          height = options.delete(:height)

          # Set styles based on options passed in
          card_wrapper_style = if max_height_full
                                 'max-height: 100%;'
                               elsif max_height
                                 # NOTE: I actually wanted max height to be "height of card_container
                                 # is set to the max height OR the remaining height of the screen,
                                 # whichever comes first" but I couldn't get it to work. I tried this:
                                 # card_container_style = "height: #{max_height}; max-height: 100%"
                                 # it might be because you can't set a height of 100% on a child (ie the card)
                                 # when the parent height is not set (ie when the card_container has a
                                 # max-height of 100% but a height of some set value)
                                 "max-height: #{max_height};"
                               elsif height
                                 "height: #{height};"
                               else
                                 ''
                               end

          # prepare elements
          content_tag 'DIV', class: 'card-wrapper', style: card_wrapper_style do
            content_tag 'DIV', class: 'card' do
              block.call
            end
          end
        end

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
          options[:max_height_full] = true unless options.keys.include?(:max_height_full)
          card(options, &block)
        end

        def table_card_header(options = {}, &block)
          options[:divider] = false unless options.keys.include?(:divider)
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
