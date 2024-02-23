# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # tables
      module TableHelper
        def table(options = {}, &block)
          # sole reason for giving name uf-table is because tailwind defaults to
          # border-collapse: collapse; which is not what we want because our table
          # header is sticky... and when you have a sticky table header with border
          # collapse, the table header border is not visible when you scroll
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
