class VotersController < ApplicationController
  parameter_encoding :vote, :x, Encoding::ASCII_8BIT

  def vote
    if !params.has_key?('x')
      render json: {"error": "No 'x' parameter provided. Cannot vote."}
      return
    end

    @voter = Voter.new

    print(params['x'])
  end
end
