class StepsController < ApplicationController
  def index
    @steps = Step.order(:date)

    expires_in 1.hour, public: true
    render json: @steps
  end
end