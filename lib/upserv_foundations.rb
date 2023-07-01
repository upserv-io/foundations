# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Add all helper files to ActionView::Base
Dir.glob('lib/upserv_foundations/helpers/**/*.rb').each do |file|
  require file.sub('lib/', '').sub('.rb', '')
  # Extract the directory path without "lib/"
  dir_path = File.dirname(file).sub(%r{^lib/}, '')
  # Convert the directory path to Pascal case without underscores
  class_name = dir_path.split('/').map do |part|
    part.split('_').map(&:capitalize).join
  end.join('::')
  # Add the final module and class name
  class_name += "::#{File.basename(file, '.rb').split('_').map(&:capitalize).join}"
  ActionView::Base.include Object.const_get(class_name)
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
