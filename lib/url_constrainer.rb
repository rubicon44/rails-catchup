class UrlConstrainer
  def matches?(request)
    User.find_by(username: request.params[:username]).present?
  end
end