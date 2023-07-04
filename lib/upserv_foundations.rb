# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Helpers
require 'upserv_foundations/helpers/components/ui_helper'

# Helper Classes
if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::UiHelper
end

# Javascript
require 'upserv_foundations/javascript/controllers/dropdown_controller'

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  # Help with assets...???
  class Engine < ::Rails::Engine
    # Make the SCSS files available to Rails applications
    initializer 'upserv_foundations.assets' do |app|
      app.config.assets.paths << root.join('vendor', 'assets', 'stylesheets')
      app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript')
    end
  end
end
