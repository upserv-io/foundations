# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # tables
      module TableHelper
        def table(options = {}, &block)
          options[:class] = "uf-table #{options[:class]}".strip
          content_tag 'TABLE', options do
            block.call
          end
        end

        def table_head(thead_options: {}, tr_options: {}, &block)
          content_tag 'THEAD', thead_options do
            content_tag 'TR', tr_options do
              block.call
            end
          end
        end

        def table_body(enum = nil, options = {}, &block)
          content_tag 'TBODY', options do
            if enum
              enum&.each do |item|
                block.call(item)
              end
            else
              block.call
            end
          end
        end
      end
    end
  end
end
