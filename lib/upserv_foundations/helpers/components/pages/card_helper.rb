# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def card(options = {}, &block)
          # if the card is the last card, you can add "last_card: true" which will add basically
          # an empty div which prevents the card margin bottom from collapsing which is so annoying
          include_spacer_div = if options.keys.include?(:include_spacer_div)
                                 options.delete(:include_spacer_div)
                               else
                                 true
                               end
          # Decide if the card has a set height or if it has no height restrictions.
          # By default cards do not have a set height ie no height restrictions.
          # They take the height of their contents causing the page body to scroll
          # if they are taller than the screen size. However, there are 3 ways to
          # limit the height of the card (see below). If the height of the
          # card is limited and the contents of the card are taller than the height
          # limit, then we want the card body to scroll. In order to do this, we need
          # to add the class "set-height" to the card. We do this dynamically using the
          # set_height variable (set below).
          # 3 ways a card has limited height:
          #   - full_height option is set to true - card height will be based
          #     on it's contents up to the remaining view height of the screen. This should
          #     only be used when a page only has a single card (ie like a typical index page
          #     that has a single card with a table full of rows / data)
          #   - max_height option is set (to any valid css height) - card height will be based
          #     on it's contents up to this max height.
          #   - height option is set (to any valid css height) - card height is set to this
          #     value
          #   NOTE: in all 3 cases, any vertical overflow / scrolling  will happen on the card
          #   body
          set_height = options.keys.intersect?(%i[full_height max_height height])
          # get height related data and store in variable(s)
          full_height = if options.keys.include?(:full_height)
                          options.delete(:full_height)
                        else
                          false
                        end
          max_height = options.delete(:max_height)
          height = options.delete(:height)

          # Set styles based on options passed in
          card_style = if full_height
                         'max-height: 100%'
                       elsif max_height
                         # NOTE: I actually wanted max height to be "height of card_container
                         # is set to the max height OR the remaining height of the screen,
                         # whichever comes first" but I couldn't get it to work. I tried this:
                         # card_container_style = "height: #{max_height}; max-height: 100%"
                         # it might be because you can't set a height of 100% on a child (ie the card)
                         # when the parent height is not set (ie when the card_container has a
                         # max-height of 100% but a height of some set value)
                         "max-height: #{max_height}"
                       elsif height
                         "height: #{height}"
                       else
                         ''
                       end

          # prepare style for card
          options[:style] ||= ''
          options[:style] = "#{card_style}#{options[:style]}"

          # prepare class for card
          options[:class] = "card#{" #{options[:class]}" if options[:class]}#{' set-height' if set_height}"

          # prepare elements
          card_html = content_tag 'DIV', options do
            block.call
          end
          spacer_div = include_spacer_div ? content_tag('DIV', '', class: 'card-spacer') : ''
          (card_html + spacer_div).html_safe
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
