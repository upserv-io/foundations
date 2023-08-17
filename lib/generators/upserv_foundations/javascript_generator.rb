# frozen_string_literal: true

module UpservFoundations
  module Generators
    # test run
    class JavascriptGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_js_files
        template 'form/checkbox_display_toggle_controller.js',
                 'app/javascript/controllers/form/checkbox_display_toggle_controller.js'
        template 'form/select_display_toggle_controller.js',
                 'app/javascript/controllers/form/select_display_toggle_controller.js'
        template 'form/text_area_controller.js',
                 'app/javascript/controllers/form/dropdown_controller.js'

        template 'pages/page_body_columns_controller.js',
                 'app/javascript/controllers/pages/page_body_columns_controller.js'

        template 'ui/dropdown_controller.js',
                 'app/javascript/controllers/ui/dropdown_controller.js'
        template 'ui/tooltip_controller.js',
                 'app/javascript/controllers/ui/tooltip_controller.js'

        template 'modal_controller.js',
                 'app/javascript/controllers/modal_controller.js'

        template 'radio_display_toggle_controller.js',
                 'app/javascript/controllers/radio_display_toggle_controller.js'
        template 'search_select_controller.js',
                 'app/javascript/controllers/search_select_controller.js'
        template 'search_select_multiple_controller.js',
                 'app/javascript/controllers/search_select_multiple_controller.js'
        template 'global/check_and_set_timezone_cookie.js',
                 'app/javascript/global/check_and_set_timezone_cookie.js'
        template 'global/dropdown.js',
                 'app/javascript/global/dropdown.js'
        template 'global/modal_triggers.js',
                 'app/javascript/global/modal_triggers.js'
      end
    end
  end
end
