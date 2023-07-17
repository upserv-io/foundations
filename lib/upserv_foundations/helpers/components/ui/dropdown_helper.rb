# frozen_string_literal: true

module UpservFoundations
  module Components
    module Ui
      # dropdowns
      module DropdownHelper
        def dropdown(options = {}, &block)
          content_tag 'div', class: "dropdown-container#{" #{options[:class]}" if options[:class]}",
                             data: { controller: 'dropdown',
                                     action: 'click@window->dropdown#hide touchend@window->dropdown#hide' } do
            content_tag 'div', class: 'dropdown' do
              block.call
            end
          end
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
          text = options.delete(:text) || false
          link = options.delete(:link) || false
          options[:class] = "dropdown-item#{" #{options[:class]}" if options[:class]}"

          content_tag 'LI', class: 'dropdown-item-container' do
            if text && link && block.blank?
              link_to text, link, options
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
end
