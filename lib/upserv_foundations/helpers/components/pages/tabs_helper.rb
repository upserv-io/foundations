# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # tabs (ie top nav)
      module TabsHelper
        def tabs(options = {}, &block)
          options[:class] = "tabs#{" #{options[:class]}" if options[:class]}"
          content_tag 'DIV', options do
            block.call
          end
        end

        def tab_item(options = {}, &block)
          options[:class] = "tab-item#{" #{options[:class]}" if options[:class]}"
          text = options.delete(:text)
          url = options.delete(:url)
          icon = options.delete(:icon)
          icon_class = icon ? "tab-item-icon fa-solid #{icon}" : nil
          if text && url && block.blank?
            options[:class] += ' basic-width-icon' if icon_class
            link_to url, options do
              icon_elm = icon_class ? content_tag('I', nil, class: icon_class) : false
              display = content_tag 'SPAN', text
              if icon_elm
                (icon_elm + display).html_safe
              else
                display
              end
            end
          else
            content_tag 'DIV', options do
              block.call
            end
          end
        end
      end
    end
  end
end
