# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # modals
      module ModalHelper
        def modal(id:, max_width: '600px', min_width: '400px')
          content_tag 'DIV', id: id, class: 'modal', data: { controller: 'modal' } do
            trigger = content_tag 'DIV', id: "#{id}-trigger", data: { action: 'click->modal#show' }
            backdrop = content_tag 'DIV', class: 'modal-backdrop', data: { action: 'click->modal#hide' }
            modal_content_container = content_tag 'DIV', class: 'modal-content-container', style: "max-width: #{max_width}" do
              content_tag 'DIV', class: 'modal-content', style: "min-width: #{min_width}" do
                modal_close = content_tag 'SPAN', '&times;'.html_safe, class: 'modal-close', data: { action: 'click->modal#hide' }
                block_called = block.call
                (modal_close + block_called).html_safe
              end
            end
            (trigger + backdrop + modal_content_container).html_safe
          end
        end
      end
    end
  end
end
