# frozen_string_literal: true

module UpservFoundations
  module Components
    module Forms
      # Create inline errors helper
      module InlineErrorsHelper
        ActionView::Helpers::FormBuilder.class_eval do
          def inline_errors(method, options = {})
            @template.inline_errors(object, method, options)
          end
        end

        def inline_errors(object, method, options = {})
          object ||= options.delete(:object)
          return unless object

          messages = Methods.get_messages(object, method)
          return unless messages.any?

          options[:class] = "inline-errors #{options[:class]}".strip
          content_tag('DIV', Methods.unify_messages(messages, method), options)
        end

        # Helper methods
        module Methods
          class << self
            def get_messages(object, method)
              if object.is_a?(ApplicationRecord)
                object.errors[method]
              else
                object[:errors].try(:[], method)
              end
            end

            def unify_messages(messages, method)
              messages.map do |message|
                "#{method.to_s.humanize} #{message}"
              end.join('. ') + '.'
            end
          end
        end
      end
    end
  end
end
