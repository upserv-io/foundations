# frozen_string_literal: true

module UpservFoundations
  module Components
    module Ui
      # tool tips!
      module TooltipHelper
        def tooltip_container(options = {}, &block)
          options[:class] = "tooltip-container#{" #{options[:class]}" if options[:class]}"
          options[:data] ||= {}
          options[:data][:controller] = "ui--tooltip#{" #{options[:data][:controller]}" if options[:data][:controller]}"

          content_tag 'div', options do
            block.call
          end
        end

        def tooltip_button(options = {}, &block)
          options[:class] = "tooltip-button#{" #{options[:class]}" if options[:class]}"
          options[:data] ||= {}
          options[:data][:ui__tooltip_target] = 'button'
          options[:data][:action] = "mouseenter->ui--tooltip#showMessage wheel->ui--tooltip#hideMessage mouseleave->ui--tooltip#hideMessage#{" #{options[:data][:action]}" if options[:data][:action]}"

          content_tag 'div', options do
            block.call
          end
        end

        def tooltip_message(options = {}, &block)
          options[:class] = "tooltip-message#{" #{options[:class]}" if options[:class]}"
          options[:data] ||= {}
          options[:data][:ui__tooltip_target] = 'message'

          content_tag 'div', options do
            block.call
          end
        end
      end
    end
  end
end
