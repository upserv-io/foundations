# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # modals
      module ModalHelper
        def modal(options = {}, &block)
          id = options.delete(:id)
          raise ArgumentError, 'missing keyword: :id' unless id

          min_width = options.delete(:min_width) || '400px'
          max_width = options.delete(:max_width) || '600px'
          # min width goes on modal content but max width goes on modal content container
          options[:style] = "min-width: #{min_width}#{" #{options[:style]}" if options[:style]}"
          options[:class] = "modal-content bg-gray0#{" #{options[:class]}" if options[:class]}"

          content_tag 'DIV', id: id, class: 'modal', data: { controller: 'modal' } do
            trigger = content_tag 'DIV', '', id: "#{id}-trigger", data: { action: 'click->modal#show' }
            backdrop = content_tag 'DIV', '', class: 'modal-backdrop', data: { action: 'click->modal#hide' }
            modal_content_container = content_tag 'DIV', class: 'modal-content-container', style: "max-width: #{max_width}" do
              content_tag 'DIV', options do
                modal_close = content_tag 'SPAN', '&times;'.html_safe, class: 'modal-close', data: { action: 'click->modal#hide' }
                block_called = capture(&block) # Capture the block content as a string
                safe_join([modal_close, block_called])
              end
            end
            (trigger + backdrop + modal_content_container).html_safe
          end
        end
      end
    end
  end
end
