# coding: utf-8

require 'spec_helper'

describe Morecane::MustMatchCheck do
  let!(:file_name) {
    make_file <<-RUBY
puts 1
puts 2
puts 3
    RUBY
  }

  context "with a regexp that doesn't match the file" do
    it 'creates a violation' do
      opts = {:must_match_glob => file_name, :must_match_regexp => /puts 4/m}
      violations = described_class.new(opts).violations
      expect(violations.length).to eq(1)

      expect(violations[0]).to be_instance_of(Hash)
      expect(violations[0][:file]).to eq(file_name)
    end
  end

  context "with a regexp that matches the file" do
    it 'creates no violations' do
      opts = {:must_match_glob => file_name, :must_match_regexp => /puts 2/m}
      violations = described_class.new(opts).violations
      expect(violations.length).to eq(0)
    end
  end

end
