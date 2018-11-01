class Voting::PartialsController < ApplicationController
  def create
    processor.process
  end

  private

  def processor
    Voting::Processor.new(voting, hash: payload)
  end

  def payload
    params.require(:payload).permit!
  end

  def voting
    Voting::Voting.find(voting_id)
  end

  def voting_id
    params[:voting_id]
  end
end