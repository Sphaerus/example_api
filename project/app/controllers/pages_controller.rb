# frozen_string_literal: true

class PagesController < ApplicationController
  README_TEXT = File.read(File.join(Rails.root, '../README.md')).freeze

  def root
    render plain: README_TEXT
  end
end
