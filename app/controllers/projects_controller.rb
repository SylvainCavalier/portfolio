class ProjectsController < ApplicationController
  def index
    projects = Project.with_attached_photos.order(Arel.sql("position ASC NULLS LAST"), :name)

    # Cache conditionnel : le client revalide à chaque requête mais reçoit un 304
    # (sans corps) tant que rien n'a changé. Dès qu'un projet ou une de ses photos
    # est modifié, le Last-Modified change et la réponse est régénérée immédiatement.
    last_modified = [
      Project.maximum(:updated_at),
      ActiveStorage::Attachment.where(record_type: "Project").maximum(:created_at)
    ].compact.max

    if stale?(last_modified: last_modified, public: true)
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

      expires_in 0, public: true, must_revalidate: true
      render json: @projects
    end
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
