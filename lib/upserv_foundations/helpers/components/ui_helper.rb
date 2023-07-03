# frozen_string_literal: true

module UpservFoundations
  module Components
    # Set up ui components
    module UiHelper
      def dropdownz(options = {}, &block)
        content_tag('div', class: "flex justify-center#{" #{options[:class]}" if options[:class]}",
                           data: { controller: 'dropdown',
                                   action: 'click@window->dropdown#hide touchend@window->dropdown#hide' }) do
          content_tag 'div', class: 'dropdown relative' do
            block.call
          end
        end
      end

      def dropdown(options = {}, &block)
        concat(
          content_tag('div', class: "flex justify-center#{" #{options[:class]}" if options[:class]}",
                             data: { controller: 'dropdown',
                                     action: 'click@window->dropdown#hide touchend@window->dropdown#hide' }) do
            content_tag 'div', class: 'dropdown relative' do
              block.call
            end
          end
        )
      end

      def dropdown_button(options = {}, &block)
        options[:block] = block
        # options[:id] is required
        concat(render('global/components/ui/dropdown_button', options))
      end

      def dropdown_items(options = {}, &block)
        options[:block] = block
        # options[:of] is required
        concat(render('global/components/ui/dropdown_items', options))
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
        options[:css_class] = drop_down_css_class(options)
        link_to_options(options)
        concat(render('global/components/ui/dropdown_item', options))
      end

      private

      def link_to_options(options)
        options[:link_to_options] = { class: drop_down_css_class(options) }
        options[:link_to_options][:method] = options[:method] if options[:method]
        options[:link_to_options][:data] = options[:data] if options[:data]
      end

      def drop_down_css_class(options)
        drop_down_css_class = 'p-2 font-normal block w-full ' \
                              'whitespace-nowrap bg-transparent'
        drop_down_css_class += " #{options[:class]}" if options[:class]
        drop_down_css_class
      end
    end
  end
end
