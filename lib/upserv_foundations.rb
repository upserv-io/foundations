# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Add all helper files to ActionView::Base
Dir.glob('lib/upserv_foundations/helpers/**/*.rb').each do |file|
  require file.sub(%r{^lib/}, '')
  class_name = file.sub(%r{^lib/}, '').sub(/\.rb$/, '')
                   .gsub('/', '_').split('_').map(&:capitalize).join
  ActionView::Base.include Object.const_get(class_name)
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
