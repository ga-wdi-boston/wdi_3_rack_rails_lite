class FishCake

  def initialize(app)
    @app = app 
  end

  def call(env)
    status, headers, response = @app.call(env)
    str = "fishy caky" + response.body.first

    [status, headers.merge("Content-Length" => str.length.to_s), [str] ]
  end

# new_hash = {"one" => '111'}.merge({'two' => '222'})
# Now new_hash is the two merged hashes
# {"one" => '111', 'two' => '222'})
end