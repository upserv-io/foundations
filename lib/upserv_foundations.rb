# frozen_string_literal: true

require_relative 'upserv_foundations/version'
require 'upserv_foundations/global/components/ui_helper'
ActionView::Base.include Global::Components::UiHelper

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
