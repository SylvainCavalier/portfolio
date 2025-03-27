class StepsController < ApplicationController
  def index
    @steps = Step.order(:date)
    render json: @steps
  end
end