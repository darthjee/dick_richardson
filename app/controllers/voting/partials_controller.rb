class Voting::PartialsController < ApplicationController
  def create
  end

  private

  def payload
    params.require(:payload)
  end

  def voting
    Voting::Voting.find(voting_id)
  end

  def voting_id
    params[:voting_id]
  end
end
