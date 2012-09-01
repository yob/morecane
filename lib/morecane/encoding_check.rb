# coding: utf-8

module Morecane
  # Creates violations for ruby files that have no encoding marker in the
  # first two lines
  class EncodingCheck < Struct.new(:opts)
    def self.options
      {
        encoding_glob: ['Glob to run encoding checks over',
                            default:  '{app,lib,spec}/**/*.rb',
                            variable: 'GLOB',
                            clobber:  :no_encoding]
      }
    end

    def violations
      file_names.map { |file_name|
        find_violations(file_name)
      }.flatten.compact
    end

    private

    def find_violations(file_name)
      data = ::File.open(file_name, 'r:utf-8')
      line_one, line_two = *data.lines

      if !line_one.to_s.match(/coding:/) && !line_two.to_s.match(/coding:/)
        {
          description: "Source file missing an encoding marker",
          file:        file_name
        }
      end
    end

    def file_names
      Dir[opts.fetch(:encoding_glob)]
    end

  end
end
