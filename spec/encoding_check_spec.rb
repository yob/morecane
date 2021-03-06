# coding: utf-8

require 'spec_helper'

describe Morecane::EncodingCheck do
  context "with a source file that has no encoding marker" do
    let!(:file_name) {
      make_file <<-RUBY
puts "chunky bacon"
      RUBY
    }

    it 'creates an EncodingViolation' do
      violations = described_class.new(encoding_glob: file_name).violations
      expect(violations.length).to eq(1)

      expect(violations[0]).to be_instance_of(Hash)
      expect(violations[0][:file]).to eq(file_name)
    end
  end

  context "with a source file that has an encoding marker on line 1" do
    let!(:file_name) {
      make_file <<-RUBY
# coding: utf-8
puts "chunky bacon"
      RUBY
    }

    it 'creates no violations' do
      violations = described_class.new(encoding_glob: file_name).violations
      expect(violations.length).to eq(0)
    end
  end

  context "with a source file that has an encoding marker on line 2" do
    let!(:file_name) {
      make_file <<-RUBY
#!/bin/env ruby
# coding: utf-8
puts "chunky bacon"
      RUBY
    }

    it 'creates no violations' do
      violations = described_class.new(encoding_glob: file_name).violations
      expect(violations.length).to eq(0)
    end
  end

end
