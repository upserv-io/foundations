# frozen_string_literal: true

module UpservFoundations
  module Generators
    # test run
    class JavascriptGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_js_files
        # stimulus controllers
        # NOTE: these should all be moved to controllers/... here in UF
        # ex form/checkbox_display_toggle_controller.js =>
        #    controllers/form/checkbox_display_toggle_controller.js
        # they are good in the rails app though

        # form
        template 'form/checkbox_display_toggle_controller.js',
                 'app/javascript/controllers/form/checkbox_display_toggle_controller.js'
        template 'form/radio_display_toggle_controller.js',
                 'app/javascript/controllers/form/radio_display_toggle_controller.js'
        template 'form/select_display_toggle_controller.js',
                 'app/javascript/controllers/form/select_display_toggle_controller.js'
        template 'form/text_area_controller.js',
                 'app/javascript/controllers/form/text_area_controller.js'

        # pages
        template 'pages/page_body_columns_controller.js',
                 'app/javascript/controllers/pages/page_body_columns_controller.js'

        # ui
        template 'ui/dropdown_controller.js',
                 'app/javascript/controllers/ui/dropdown_controller.js'
        template 'ui/tooltip_controller.js',
                 'app/javascript/controllers/ui/tooltip_controller.js'

        # un-namespaced (the select controllers should be in the form namespace...)
        template 'modal_controller.js',
                 'app/javascript/controllers/modal_controller.js'
        template 'search_select_controller.js',
                 'app/javascript/controllers/search_select_controller.js'
        template 'search_select_multiple_controller.js',
                 'app/javascript/controllers/search_select_multiple_controller.js'

        # global js
        template 'global/check_and_set_timezone_cookie.js',
                 'app/javascript/global/check_and_set_timezone_cookie.js'
        template 'global/dropdown.js',
                 'app/javascript/global/dropdown.js'
        template 'global/modal_triggers.js',
                 'app/javascript/global/modal_triggers.js'
        # uf
        template 'uf/card_controller.js',
                 'app/javascript/controllers/uf/card_controller.js'
        template 'uf/card_header_controller.js',
                 'app/javascript/controllers/uf/card_header_controller.js'
        template 'uf/inline_cards_wrapper_controller.js',
                 'app/javascript/controllers/uf/inline_cards_wrapper_controller.js'
        template 'uf/page_header_controller.js',
                 'app/javascript/controllers/uf/page_header_controller.js'
      end
    end
  end
end
