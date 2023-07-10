# frozen_string_literal: true

module UpservFoundations
  # misc methods
  module MiscMethodsHelper
    def url_with_protocol(url)
      # Check if the URL already has a protocol
      return url if url =~ %r{\Ahttps?://} || url =~ %r{\Ahttp?://}

      # Add the protocol if it's missing
      "http://#{url}"
    end
  end
end
