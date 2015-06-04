
class ShowHTTPHeaders

  # This will be invoked for a HTTPRequest
  def call(env)
  # env is a Ruby Hash that provides info about the HTTP Request
  contents = env.inspect

    [200, {'Content-Type' => 'text/plain'}, [contents] ] 
  end
end

run ShowHTTPHeaders.new

