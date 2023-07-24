# frozen_string_literal: true

module UpservFoundations
  module Components
    module Ui
      # dropdowns
      module DropdownHelper
        # def dropdown(options = {}, &block)
        #   options[:class] = "dropdown-container#{" #{options[:class]}" if options[:class]}"
        #   options[:data] ||= {}
        #   options[:data][:controller] = 'dropdown'
        #   options[:data][:action] = 'click@window->dropdown#hide touchend@window->dropdown#hide'
        #   content_tag 'div', options do
        #     content_tag 'div', class: 'dropdown' do
        #       block.call
        #     end
        #   end
        # end

        # def dropdown_button(options = {}, &block)
        #   options[:data] ||= {}
        #   options[:data][:dropdown_target] = 'button'
        #   options[:data][:action] = 'click->dropdown#show'
        #   content_tag 'DIV', options do
        #     block.call
        #   end
        # end

        # def dropdown_items(options = {}, &block)
        #   options[:class] = "dropdown-items bg-gray0#{" #{options[:class]}" if options[:class]}"
        #   options[:data] ||= {}
        #   options[:data][:dropdown_target] = 'popup'
        #   content_tag 'UI', options do
        #     block.call
        #   end
        # end

        # # drop down item can be a simple link or a block with custom code
        # # in either cases, the base css classes will be added
        # # for simple link (with or without a url), then include the text option
        # # and the block will be ignored
        # # For a block, ignore the text and url options and include a block
        # def dropdown_item(options = {}, &block)
        #   text = options.delete(:text) || false
        #   url = options.delete(:url) || false
        #   options[:class] = "dropdown-item#{" #{options[:class]}" if options[:class]}"

        #   content_tag 'LI', class: 'dropdown-item-container' do
        #     if text && url && block.blank?
        #       link_to text, url, options
        #     else
        #       content_tag 'DIV', options do
        #         block.call
        #       end
        #     end
        #   end
        # end
      end
    end
  end
end
