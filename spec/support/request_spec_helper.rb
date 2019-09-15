module RequestSpecHelper
  # Helper method for parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
