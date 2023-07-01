# frozen_string_literal: true

require_relative 'upserv_foundations/version'

require 'upserv_foundations/helpers/components/ui_helper'
require 'upserv_foundations/views/components/ui/_dropdown'

ActionView::Base.include Components::UiHelper if defined? ActionView::Base

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
