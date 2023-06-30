# frozen_string_literal: true

require_relative "upserv_foundations/version"

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  def party
    puts "yolo"
  end
end
