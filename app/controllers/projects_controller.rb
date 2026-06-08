class ProjectsController < ApplicationController
  def index
    projects = Project.with_attached_photos.order(Arel.sql("position ASC NULLS LAST"), :name)

    @projects = projects.map do |project|
      {
        id: project.id,
        name: project.name,
        description: project.description,
        github_url: project.github_url,
        tech_stack: project.tech_stack,
        language: project.language,
        photos: project.photos.map { |photo| cloudinary_url(photo) }.compact,
        video_url: project.video_url
      }
    end

    expires_in 1.hour, public: true
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end

  private

  def cloudinary_url(photo)
    return nil unless photo.blob.present?

    # URL directe Cloudinary sans passer par Rails
    Cloudinary::Utils.cloudinary_url(photo.key, resource_type: resource_type_for(photo))
  rescue StandardError
    nil
  end

  def resource_type_for(photo)
    content_type = photo.blob.content_type
    if content_type&.start_with?("video")
      "video"
    elsif content_type&.start_with?("image")
      "image"
    else
      "raw"
    end
  end
end
