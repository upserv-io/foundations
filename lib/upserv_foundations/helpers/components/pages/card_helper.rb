# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def inline_cards_wrapper(min_px: 400, &block)
          # set initial display to none so that the child cards don't flash with full width on page load
          # after load, js will setset the display to flex and also adjust children width
          content_tag 'DIV', class: 'inline-cards-wrapper', style: 'visibility: hidden', data: { controller: 'uf--inline-cards-wrapper', min_px: min_px } do
            block.call
          end
        end

        def card(options = {}, &block)
          inline = if options.keys.include?(:inline)
                     options.delete(:inline)
                   else
                     false
                   end

          type = if options.keys.include?(:type)
                   options.delete(:type).to_sym
                 else
                   :single
                 end
          height = if options.keys.include?(:height)
                     options.delete(:height)
                   else
                     false
                   end
          max_height = if options.keys.include?(:max_height)
                         options.delete(:max_height)
                       elsif type == :single
                         '100%'
                       else
                         false
                       end
          min_height = if options.keys.include?(:min_height)
                         options.delete(:min_height)
                       elsif inline
                         '100%'
                       else
                         false
                       end
          card_wrapper_style = ''
          card_wrapper_style += "height: #{height};" if height
          card_wrapper_style += "max-height: #{max_height};" if max_height
          card_wrapper_style += "min-height: #{min_height};" if min_height

          width_class = options.delete(:width_class)
          card_wrapper_class = "card-wrapper#{" #{width_class}" if width_class && inline}"

          # prepare elements
          content_tag 'DIV', class: card_wrapper_class, style: card_wrapper_style do
            content_tag 'DIV', class: 'card' do
              block.call
            end
          end
        end

        def card_header(options = {}, &block)
          table = if options.keys.include?(:table)
                    options.delete(:table)
                  else
                    false
                  end
          if table && !options.keys.include?(:divider)
            options[:divider] = false
          end
          divider = options.key?(:divider) ? options.delete(:divider) : true
          options[:class] = "card-header#{" #{options[:class]}" if options[:class]}"

          header_elm = content_tag 'div', options do
            block.call
          end

          divider_eml = content_tag 'div', '', class: 'card-header-divider' if divider
          "#{header_elm}#{divider_eml}".html_safe
        end

        def card_body(options = {}, &block)
          table = if options.keys.include?(:table)
                    options.delete(:table)
                  else
                    false
                  end
          if table && !options.keys.include?(:remove_padding)
            options[:remove_padding] = true
          end
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
      end
    end
  end
end
