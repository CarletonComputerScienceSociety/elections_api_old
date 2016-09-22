require 'base64'

class SaneX
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["QUERY_STRING"].include? 'x='
      # Magic regex to semi-parse the query string
      # 2.3.1 :003 > "x=test&y=test".gsub(/x=[^&$]*/, "x=blah")
      #           => "x=blah&y=test"

      env["QUERY_STRING"] = env["QUERY_STRING"].gsub(/x=[^&$]*/, "x=" + Base64.urlsafe_encode64(URI.decode(env["QUERY_STRING"])[2..-1]))
    end

    status, headers, body = @app.call(env)

    return status, headers, body
  end
end
