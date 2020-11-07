require 'simplecov'
require 'rails_helper'
SimpleCov.start 'rails'

RSpec.describe MoviesHelper do
  include MoviesHelper
  describe "checking whether a number is odd" do
      it "expects a number to be odd" do
        expect(oddness(111)).to eq("odd")
      end
     it "expects a number to be even" do
        expect(oddness(332)).to eq("even")
      end
  end
end