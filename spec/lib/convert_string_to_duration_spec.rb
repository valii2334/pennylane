require 'rails_helper'
require_dependency Rails.root.join('lib', 'convert_string_to_duration')

RSpec.describe 'ConvertStringToDuration' do
  it 'returns correct duration if string includes j, h, m, s' do
    duration_string = '1j 23h55min 23sec'
    duration_as_integer = ConvertStringToDuration.new(duration_string).duration_as_integer
    expected_duration = 24 * 60 * 60 + 23 * 60 * 60 + 55 * 60 + 23

    expect(duration_as_integer).to eq(expected_duration)
  end

  it 'retuns correct duration if string includes h and minutes are not explicitly specified' do
    duration_string = '1h40'
    duration_as_integer = ConvertStringToDuration.new(duration_string).duration_as_integer
    expected_duration = 1 * 60 * 60 + 40 * 60

    expect(duration_as_integer).to eq(expected_duration)
  end

  it 'retuns correct duration if string includes only h' do
    duration_string = '1h'
    duration_as_integer = ConvertStringToDuration.new(duration_string).duration_as_integer
    expected_duration = 1 * 60 * 60

    expect(duration_as_integer).to eq(expected_duration)
  end
end
