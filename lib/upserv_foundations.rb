# frozen_string_literal: true

require_relative 'upserv_foundations/version'

require 'upserv_foundations/helpers/components/ui_helper'

# Helper Classes
if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::UiHelper
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  # help with assest..??
  # class Engine < ::Rails::Engine
  #   # Make the SCSS files available to Rails applications
  #   initializer 'upserv_foundations.assets' do |app|
  #     app.config.assets.paths << root.join('vendor', 'assets', 'stylesheets')
  #   end
  # end
end
