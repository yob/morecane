# coding: utf-8

module Morecane
  # Creates violations for ruby files that match a given regexp
  #
  class NoMatchCheck < Struct.new(:opts)
    def self.options
      {
        nomatch_glob: ['Glob to run no-match checks over',
                       default:  '{app,lib,spec}/**/*.rb',
                       variable: 'GLOB',
                       clobber:  :no_nomatch],
        nomatch_regexp: ['Regexp to check files against',
                         variable: 'REGEXP',
                         clobber:  :no_nomatch],
      }
    end

    def violations
      file_names.map { |file_name|
        find_violations(file_name)
      }.flatten.compact
    end

    private

    def find_violations(file_name)
      data = ::File.open(file_name, 'r:utf-8').read

      if data.match(opts.fetch(:nomatch_regexp))
        {
          description: "Source file matches regexp",
          file:        file_name
        }
      end
    end

    def file_names
      Dir[opts.fetch(:nomatch_glob)]
    end

  end
end
