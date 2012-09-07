# coding: utf-8

module Morecane
  # Creates violations for ruby files that match a given regexp
  #
  class MustNotMatchCheck < Struct.new(:opts)
    def self.options
      {
        must_not_match_glob: ['Glob to run no-match checks over',
                              default:  '{app,lib,spec}/**/*.rb',
                              variable: 'GLOB',
                              clobber:  :no_must_not_nomatch],
        must_not_match_regexp: ['Regexp to check files against',
                                variable: 'REGEXP',
                                clobber:  :no_must_not_match],
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

      if data.match(opts.fetch(:must_not_match_regexp))
        {
          description: "Source file matches regexp",
          file:        file_name
        }
      end
    end

    def file_names
      Dir[opts.fetch(:must_not_match_glob)]
    end

  end
end
