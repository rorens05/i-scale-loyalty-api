module Imageable
  extend ActiveSupport::Concern
  include ImagesHelper

  included do
    before_save :set_image
    has_one_attached :image
    attr_accessor :base_64_image

    def image_path
      return Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
    end
    
    def set_image
      if base_64_image.present?
        # TODO: Validates image
        self.image = base64_to_file(base_64_image)
      end
    end
  end

  class_methods do

  end
end
