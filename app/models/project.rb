class Project < ApplicationRecord
  has_many_attached :photos

  def photo_urls
    photos.map { |photo| Rails.application.routes.url_helpers.url_for(photo) }
  end
end