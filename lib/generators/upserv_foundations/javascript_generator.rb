# frozen_string_literal: true

module UpservFoundations
  module Generators
    # test run
    class JavascriptGenerator < Rails::Generators::Base
      # include Rails::Generators::ResourceHelpers

      source_root File.expand_path('templates', __dir__)

      argument :name, type: :string, desc: 'Name of the controller'

      def copy_js_files
        template 'my_controller.js', 'app/javascript/controllers/my_controller.js'
      end
    end
  end
end
