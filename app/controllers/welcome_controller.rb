class WelcomeController < ApplicationController

  def index
  end

  def checkHand
    my_data = params[:my_data]
    uri = URI('http://localhost:3000/api/v1/cards')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"cards": [my_data]}.to_json
    res = http.request(req)
    jsonRes = JSON.parse(res.body)
    if jsonRes["error"].nil?
      @result =  jsonRes["result"][0]["rank"]
      @error = []
    else
      @error = jsonRes["error"][0]["error"]
      @result = nil
    end

    respond_to do |format|
      format.js
    end
  end

end
