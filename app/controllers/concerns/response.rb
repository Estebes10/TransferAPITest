module Response
  # custom method for json response and status code
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
