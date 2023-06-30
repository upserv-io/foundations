# frozen_string_literal: true

require_relative 'upserv_foundations/version'

require 'upserv_foundations/helpers/components/ui_helper'
ActionView::Base.include UpservFoundations::Components::UiHelper

# # Add all helper files to ActionView::Base
# Dir.glob('lib/upserv_foundations/helpers/**/*.rb').each do |file|
#   require file.sub('lib/', '').sub('.rb', '')
#   class_name = file.sub('lib/upserv_foundations/helpers', 'upserv_foundations')
#                    .sub('.rb', '').split('_').map(&:capitalize).join.gsub('/', '::')
#                    .split('::').map(&:capitalize).join('::')
#   ActionView::Base.include Object.const_get(class_name)
# end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
