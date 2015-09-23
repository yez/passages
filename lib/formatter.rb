module Roots
  class Formatter
    def initialize
      @buffer = []
    end

    def section(section)
      @buffer << section
    end

    def section_title(*)
    end

    def header(*)
    end

    def result
      @buffer.join("\n")
    end

    def no_routes
    end
  end
end
