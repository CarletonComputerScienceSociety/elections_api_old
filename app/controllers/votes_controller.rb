require 'base64'

class VotesController < ApplicationController
  def vote
    return unless uuid = validate_vote

    if !params.has_key?('vote')
      render json: {"error": "You didn't say who you wanted to vote for!", "error_code": "no_vote"}, status: :bad_request
      return nil
    end

    vote = params['vote']

    if Vote.where(vote: vote, uuid: uuid).length > 0
      render json: {"error": "You cannot vote for the same person twice!"}
      return nil
    end

    vote = Vote.new(vote: vote, uuid: uuid)

    vote.save!

    render json: {"ok": "Your vote was recorded! Thanks so much for voting in the CCSS first year elections!"}
  end

  def validate
    return unless validate_vote

    render json: {"ok": "Voter id ok"}
  end

  private
  def validate_vote
    election_done = false

    if election_done
      render json: {"error": "The election is over! Please wait for news on the results on our website and in your emails", "error_code": "election_done"}
      return nil
    end

    if !params.has_key?('x')
      render json: {"error": "No validation 'x' parameter provided. Cannot vote.", "error_code": "no_x"}, status: :forbidden
      return nil
    end

    uuid = "a fake uuid"

    if Vote.where(uuid: uuid).length >= 2
      render json: {"error": "You already voted! Please wait for news on the results on our website and in your emails", "error_code": "double_vote"}
      return nil
    end

    uuid
  end
end
