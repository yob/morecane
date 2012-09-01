# coding: utf-8

require 'spec_helper'

describe Morecane::NoMatchCheck do
  let!(:file_name) {
    make_file <<-RUBY
puts 1
puts 2
puts 3
    RUBY
  }

  context "with a regexp that doesn't match the file" do
    it 'creates a violation' do
      opts = {:nomatch_glob => file_name, :nomatch_regexp => /puts 4/m}
      violations = described_class.new(opts).violations
      violations.length.should == 0
    end
  end

  context "with a regexp that matches the file" do
    it 'creates no violations' do
      opts = {:nomatch_glob => file_name, :nomatch_regexp => /puts 2/m}
      violations = described_class.new(opts).violations
      violations.length.should == 1


      violations[0].should be_instance_of(Hash)
      violations[0][:file].should == file_name
    end
  end

end
