class Project < ApplicationRecord
  has_many_attached :photos
  has_one_attached :video

  def photo_urls
    photos.map { |photo| Rails.application.routes.url_helpers.url_for(photo) }
  end
  
  def video_url
    video.attached? ? Rails.application.routes.url_helpers.url_for(video) : nil
  end
end