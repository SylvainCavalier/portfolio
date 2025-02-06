class LandingController < ApplicationController
  def index
    @projects = Project.all
    @sections = Section.all
  end
end
