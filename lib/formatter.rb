require_relative './route'

module Roots
  class Formatter
    def initialize
      @buffer = []
    end

    def section(section)
      @buffer << Route.new(section)
    end

    def section_title(*)
    end

    def header(*)
    end

    def result
      @buffer
    end

    def no_routes
    end
  end
end
