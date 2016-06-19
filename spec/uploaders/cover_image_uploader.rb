require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AchievementsHelper. For example:
#
RSpec.describe CoverImageUploader do

  it 'allows only images' do
    uploader = CoverImageUploader.new(Achievement.new, :cover_image)

    expect{
      File.open("#{Rails.root}/spec/fixtures/blank.pdf") do |f|
        uploader.store!(f)
      end
    }.to raise_exception(CarrierWave::IntegrityError)
  end
end
