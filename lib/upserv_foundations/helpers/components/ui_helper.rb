# frozen_string_literal: true

module UpservFoundations
  module Components
    # Set up ui components
    module UiHelper
      def dropdown(options = {}, &block)
        # content_tag 'div', class: "flex justify-center#{" #{options[:class]}" if options[:class]}",
        #                    data: { controller: 'dropdown; testz',
        #                            action: 'click@window->dropdown#hide touchend@window->dropdown#hide' } do
        #   content_tag 'div', class: 'dropdown relative' do
        #     block.call
        #   end
        # end
      end

      def dropdown_button(options = {}, &block)
        options[:block] = block
        content_tag 'DIV', id: options[:id],
                           data: { dropdown_target: 'button',
                                   action: 'click->dropdown#show' } do
          block.call
        end
      end

      def dropdown_items(options = {}, &block)
        options[:block] = block
        content_tag 'UI',
                    class: 'dropdown-items bg-gray0',
                    data: { dropdown_target: 'popup' } do
          block.call
        end
      end

      # drop down item can be a simple link or a block with custom code
      # in either cases, the base css classes will be added
      # for simple link (with or without a url), then include the text option
      # and the block will be ignored
      # For a block, ignore the text and link options and include a block
      def dropdown_item(options = {}, &block)
        options[:block] = block
        options[:text] ||= false
        options[:link] ||= false
        drop_down_css_class = 'p-2 font-normal block w-full ' \
                              'whitespace-nowrap bg-transparent'
        drop_down_css_class += " #{options[:class]}" if options[:class]
        options[:css_class] = drop_down_css_class
        options[:link_to_options] = { class: drop_down_css_class }
        options[:link_to_options][:method] = options[:method] if options[:method]
        options[:link_to_options][:data] = options[:data] if options[:data]

        content_tag 'LI', class: 'dropdown-item' do
          if options[:text] && block.blank?
            link_to(options[:text], options[:link], options[:link_to_options])
          else
            content_tag 'DIV', class: options[:css_class] do
              block.call
            end
          end
        end
      end
    end
  end
end
