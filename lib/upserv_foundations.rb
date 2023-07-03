# frozen_string_literal: true

require_relative 'upserv_foundations/version'

require 'upserv_foundations/helpers/components/ui_helper'

if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::UiHelper
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
