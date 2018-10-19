# frozen_string_literal: true

require 'test_helper'

class PanelProviderTest < ActiveSupport::TestCase
  test 'duplicate codes are not allowed' do
    already_defined_code = PanelProvider.first.code

    assert_raises ActiveRecord::RecordInvalid do
      PanelProvider.create!(code: already_defined_code)
    end
  end
end
