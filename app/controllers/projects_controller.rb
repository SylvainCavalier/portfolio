class ProjectsController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    projects = Project.order(:name)
  
    @projects = projects.map do |project|
      {
        id: project.id,
        name: project.name,
        description: project.description,
        github_url: project.github_url,
        tech_stack: project.tech_stack,
        language: project.language,
        photos: project.photos.map { |photo| url_for(photo) },
        video_url: project.video_url
      }
    end
  
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end
end