# frozen_string_literal: true

module UpservFoundations
  module Generators
    # test run
    class JavascriptGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_js_files
        template 'my_controller.js', 'app/javascript/controllers/my_controller.js'
      end
    end
  end
end
