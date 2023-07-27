# frozen_string_literal: true

module UpservFoundations
  module Generators
    # test run
    class JavascriptGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_js_files
        template 'form/select_display_toggle_controller.js',
                 'app/javascript/controllers/form/select_display_toggle_controller.js'
        template 'form/text_area_controller.js',
                 'app/javascript/controllers/form/dropdown_controller.js'
        template 'ui/tooltip_controller.js',
                 'app/javascript/controllers/ui/tooltip_controller.js'
        template 'dropdown_controller.js',
                 'app/javascript/controllers/dropdown_controller.js'
        template 'modal_controller.js',
                 'app/javascript/controllers/modal_controller.js'
        template 'search_select_controller.js',
                 'app/javascript/controllers/search_select_controller.js'
        template 'search_select_multiple_controller.js',
                 'app/javascript/controllers/search_select_multiple_controller.js'
      end
    end
  end
end
