# frozen_string_literal: true

module UpservFoundations
  module Components
    module Forms
      # Create inline errors helper
      module InlineErrorsHelper
        ActionView::Helpers::FormBuilder.class_eval do
          def inline_errors(attribute, html_options = {})
            @template.inline_errors(@object, attribute, html_options)
          end
        end

        def inline_errors(object, attribute, html_options = {})
          messages = Methods.get_messages(object, attribute)
          return unless messages.any?

          html_options[:class] ||= 'inline-errors'
          content_tag('DIV', Methods.unify_messages(messages, attribute), html_options)
        end

        # Helper methods
        module Methods
          class << self
            def get_messages(object, attribute)
              if object.is_a?(ApplicationRecord)
                object.errors[attribute]
              else
                object[:errors].try(:[], attribute)
              end
            end

            def unify_messages(messages, attribute)
              messages.map do |message|
                "#{attribute.to_s.humanize} #{message}"
              end.join('. ')
            end
          end
        end
      end
    end
  end
end
