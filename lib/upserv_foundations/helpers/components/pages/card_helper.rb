# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # all things cards
      module CardHelper
        def inline_cards_wrapper(min_px: 400, &block)
          content_tag 'DIV', class: 'inline-cards-wrapper', data: { controller: 'uf--inline-cards-wrapper', min_px: min_px } do
            block.call
          end
        end

        def card(options = {}, &block)
          type = if options.keys.include?(:type)
                   options.delete(:type).to_sym
                 else
                   :single
                 end
          inline = type == :inline
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
          # start with visibility hidden so that the cards don't flicker on load
          # the header might flicker based on width
          # the card itself might flicker if it's inline  based on width
          card_wrapper_style = 'visibility: hidden;'
          card_wrapper_style += "height: #{height};" if height
          card_wrapper_style += "max-height: #{max_height};" if max_height
          card_wrapper_style += "min-height: #{min_height};" if min_height

          width_class = options.delete(:width_class)
          card_wrapper_class = "card-wrapper#{" #{width_class}" if width_class && inline}"

          # prepare elements
          content_tag 'DIV', data: { controller: 'uf--card' }, class: card_wrapper_class, style: card_wrapper_style do
            content_tag 'DIV', class: 'card' do
              block.call
            end
          end
        end

        def card_header(table: false, divider: nil, &block)
          # if table and divider notnot set, default to false
          divider = false if table && divider.nil?
          # if divider not setset, default to true
          divider == true if divider.nil?

          header_elm = content_tag 'div', class: 'card-header', data: { controller: 'uf--card-header' } do
            block.call
          end

          divider_eml = content_tag 'div', '', class: 'card-header-divider' if divider
          "#{header_elm}#{divider_eml}".html_safe
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
          content_tag 'DIV', class: 'card-header-title' do
            block.call
          end
        end

        def card_header_subtitle(&block)
          content_tag 'DIV', class: 'card-header-subtitle' do
            block.call
          end
        end

        def card_header_action_buttons(&block)
          content_tag 'DIV', class: 'card-header-action-buttons' do
            block.call
          end
        end

        def card_header_controls(&block)
          content_tag 'DIV', class: 'card-header-controls' do
            block.call
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
      end
    end
  end
end
