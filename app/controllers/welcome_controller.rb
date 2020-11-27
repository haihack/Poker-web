class WelcomeController < ApplicationController

  def index
  end

  def check_hand
    my_data = params[:my_data]
    uri = URI('http://localhost:3000/api/v1/hand_checkings')
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"cards": [my_data]}.to_json
    res = http.request(req)
    json_res = JSON.parse(res.body)
    if json_res["error"].nil?
      @result =  json_res["result"][0]["hand"]
      @error = []
    else
      @error = json_res["error"][0]["error"]
      @result = nil
    end

    respond_to do |format|
      format.js
    end
  end

end
