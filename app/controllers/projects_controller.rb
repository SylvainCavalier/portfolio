class ProjectsController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    @projects = Project.all.map do |project|
      {
        id: project.id,
        name: project.name,
        description: project.description,
        github_url: project.github_url,
        tech_stack: project.tech_stack,
        language: project.language,
        photos: project.photos.map { |photo| url_for(photo) },
        video: project.video.attached? ? url_for(project.video) : nil
      }
    end

    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end
end