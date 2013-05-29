
class Gmining::V1
  include HTTParty
  base_uri 'gmining.herokuapp.com'

  def get(url)
    req = self.class.get url
    req.parsed_response
  end

  def post(url, options)
    req = self.class.post url, :body => {sales: options}.to_json, :headers => { 'Content-Type' => 'application/json' }
    req.parsed_response
  end

end
