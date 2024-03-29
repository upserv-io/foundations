# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def inline_cards_wrapper(min_px: 350, &block)
          content_tag 'DIV', class: 'inline-cards-wrapper', data: { controller: 'uf--inline-cards-wrapper', min_px: min_px } do
            block.call
          end
        end

        def card(options = {}, &block)
          # inline cards height is determined by the content / neighbors
          # non-inline cards default to "single" - ie max-height: 100% so content
          # scrolls on card body not page body
          # add "stacked: true" to make it "max-height: none" for stacked cards so
          # the cards can scroll on the page body
          # height, max_height, and min_height can be set to override the defaults
          stacked = if options.keys.include?(:stacked)
                      options.delete(:stacked)
                    else
                      false
                    end
          height = if options.keys.include?(:height)
                     options.delete(:height)
                   else
                     false
                   end
          max_height = if options.keys.include?(:max_height)
                         options.delete(:max_height)
                       elsif stacked
                         'none'
                       else
                         '100%'
                       end
          min_height = if options.keys.include?(:min_height)
                         options.delete(:min_height)
                       else
                         false
                       end
          # start with visibility hidden so that the cards don't flicker on load
          # the header might flicker based on width
          # the card itself might flicker if it's inline  based on width
          card_wrapper_style = 'visibility: hidden;'
          card_wrapper_style += "height: #{height};" if height
          card_wrapper_style += "max-height: #{max_height};" if max_height
          card_wrapper_style += "min-height: #{min_height};" if min_height

          width_class = options.delete(:width_class)
          card_wrapper_class = "card-wrapper#{" #{width_class}" if width_class}"

          # prepare elements
          content_tag 'DIV', data: { controller: 'uf--card' }, class: card_wrapper_class, style: card_wrapper_style do
            content_tag 'DIV', class: 'card' do
              block.call
            end
          end
        end

        # currently no difference between table card and card
        def table_card(options = {}, &block)
          card(options, &block)
        end

        def card_header(table: false, divider: nil, title: nil, subtitle: nil, centered: false, &block)
          # if table and divider notnot set, default to false
          divider = false if table && divider.nil?
          # if divider not setset, default to true
          divider = true if divider.nil?

          header_elm = content_tag 'div', class: "card-header #{'centered' if centered}".strip, data: { controller: 'uf--card-header' } do
            if title
              card_header_title_row do
                card_header_title_container(title: title, subtitle: subtitle)
              end
            else
              block.call
            end
          end

          divider_eml = content_tag 'div', '', class: 'card-header-divider' if divider
          "#{header_elm}#{divider_eml}".html_safe
        end

        def table_card_header(divider: nil, title: nil, subtitle: nil, &block)
          card_header(table: true, divider: divider, title: title, subtitle: subtitle, &block)
        end

        def card_header_title_row(&block)
          content_tag 'DIV', class: 'card-header-title-row' do
            block.call
          end
        end

        def card_header_title_container(title: nil, subtitle: nil, &block)
          content_tag 'DIV', class: 'card-header-title-container' do
            if block
              block.call
            else
              title_html = card_header_title do
                title
              end
              subtitle_html = card_header_subtitle do
                subtitle
              end
              (title_html + subtitle_html).html_safe
            end
          end
        end

        def card_header_title(&block)
          return if block.nil?

          content = capture(&block)
          return if content.is_a?(String) && content.strip.blank?

          content_tag 'DIV', class: 'card-header-title' do
            content
          end
        end

        def card_header_subtitle(&block)
          return if block.nil?

          content = capture(&block)
          return if content.is_a?(String) && content.strip.blank?

          content_tag 'DIV', class: 'card-header-subtitle' do
            content
          end
        end

        def card_header_action_buttons(options = {}, &block)
          return if block.nil?

          content = capture(&block)
          return if content.is_a?(String) && content.strip.blank?

          options[:class] = "card-header-action-buttons#{if options[:class]
                                                           " #{options[:class]}"
                                                         end}"
          content_tag 'DIV', options do
            content
          end
        end

        def card_header_controls(&block)
          return if block.nil?

          content = capture(&block)
          return if content.is_a?(String) && content.strip.blank?

          content_tag 'DIV', class: 'card-header-controls' do
            content
          end
        end

        def card_body(table: false, remove_padding: nil, &block)
          # if table and remove_padding not set, default to true
          remove_padding = true if table && remove_padding.nil?
          # if remove_padding not set, default to false
          remove_padding = false if remove_padding.nil?
          content_tag 'DIV', class: "card-body#{' remove-padding' if remove_padding}" do
            block.call
          end
        end

        def table_card_body(remove_padding = nil, &block)
          card_body(table: true, remove_padding: remove_padding, &block)
        end
      end
    end
  end
end
