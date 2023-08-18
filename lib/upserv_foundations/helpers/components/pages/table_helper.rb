# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # tables
      module TableHelper
        def table(options = {}, &block)
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

        def table_body(enum, options = {}, &block)
          include_index = options.delete(:include_index)
          content_tag 'TBODY', options do
            if include_index
              enum&.each_with_index do |item, index|
                block.call(*item, index)
              end
            else
              enum&.each do |item|
                block.call(item)
              end
            end
          end
        end
      end
    end
  end
end
