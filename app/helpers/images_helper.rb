# frozen_string_literal: true

# This module handles conversion of base64 string to a file
module ImagesHelper
  def base64_to_file(image)
    {
      io: StringIO.new(Base64.decode64(image.to_s.split(',').last)),
      content_type: 'image/jpeg',
      filename: "#{SecureRandom.urlsafe_base64}#{DateTime.now.to_i}.jpg"
    }
  end
end
