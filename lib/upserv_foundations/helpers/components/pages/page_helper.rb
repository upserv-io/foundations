# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # pages
      module PageHelper
        # called from layouts. Set under the top bar
        def page_container(options = {}, &block)
          options[:id] = 'page-container'
          content_tag 'DIV', options do
            block.call
          end
        end

        # called from template
        def page_header(&block)
          style = "visibility: hidden; #{page_header_and_body_style}"
          content_tag 'DIV', id: 'page-header', style: style, data: { controller: 'uf--page-header' } do
            block.call
          end
        end

        def page_header_and_body_style
          "min-width: #{@page_min_width || page_min_width_default}; max-width: #{@page_max_width || page_max_width_default};"
        end

        def page_header_title_row(&block)
          content_tag 'DIV', id: 'page-header-title-row' do
            block.call
          end
        end

        def page_header_title_container(title: nil, subtitle: nil, &block)
          content_tag 'DIV', id: 'page-header-title-container' do
            if block
              block.call
            else
              title_html = page_header_title do
                title
              end
              subtitle_html = page_header_subtitle do
                subtitle
              end
              (title_html + subtitle_html).html_safe
            end
          end
        end

        def page_header_title(&block)
          content_tag 'DIV', id: 'page-header-title' do
            block.call
          end
        end

        def page_header_subtitle(&block)
          content_tag 'DIV', id: 'page-header-subtitle' do
            block.call
          end
        end

        def page_header_action_buttons(&block)
          content_tag 'DIV', id: 'page-header-action-buttons' do
            block.call
          end
        end

        # called from template
        def page_body(page_body_max_width_options = {}, &block)
          page_body_options = { id: 'page-body' }
          page_body_max_width_options[:id] = 'page-body-max-width'
          assign_page_header_or_body_style(page_body_max_width_options)
          content_tag 'DIV', page_body_options do
            content_tag 'DIV', page_body_max_width_options do
              block.call
            end
          end
        end

        def assign_page_header_or_body_style(options)
          base_style = "min-width: #{@page_min_width || page_min_width_default}; max-width: #{@page_max_width || page_max_width_default};"
          options[:style] = "#{base_style}#{" #{options[:style]}" if options[:style]}"
        end

        def page_max_width_default
          @page_max_width_default ||= '2500px'
        end

        def page_min_width_default
          @page_min_width_default ||= '0rem'
        end

        # basically the same as regular page header but do not set width
        # with assign_page_header_or_body_style (so width will default to 100% - see
        # vendor/assets/stylesheets/components/pages/page.scss)
        def page_header_columns(options = {}, &block)
          options[:should_assign_page_header_or_body_style] = false
          page_header(options, &block)
        end

        def page_body_columns(options = {}, &block)
          options[:id] = 'page-body-columns'
          options[:data] ||= {}
          options[:data][:controller] = "pages--page-body-columns#{" #{options[:data][:controller]}" if options[:data][:controller]}"
          content_tag 'DIV', options do
            block.call
          end
        end

        def page_body_column(options = {}, &block)
          inline_cards = if options.keys.include?(:inline_cards)
                           options.delete(:inline_cards)
                         else
                           false
                         end
          options[:class] = "page-body-column#{' inline-cards' if inline_cards}#{" #{options[:class]}" if options[:class]}"
          content_tag 'DIV', options do
            block.call
          end
        end
      end
    end
  end
end
