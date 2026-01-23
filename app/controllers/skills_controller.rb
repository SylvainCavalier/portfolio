class SkillsController < ApplicationController
  def index
    @skills = Skill.all

    expires_in 1.hour, public: true
    render json: @skills
  end
end