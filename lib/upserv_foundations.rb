# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Helpers
require 'upserv_foundations/helpers/components/ui_helper'

# Helper Classes
if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::UiHelper
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  # Make the asset files available to Rails applications
  class Engine < ::Rails::Engine
    initializer 'upserv_foundations.assets' do |app|
      app.config.assets.paths << root.join('vendor', 'assets', 'stylesheets')
      app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript')
      app.config.eager_load_paths << File.expand_path('javascript', __dir__)
      app.config.autoload_paths << root.join('lib', 'upserv_foundations', 'javascript')
    end
  end
end
