module ApplicationHelper
  def username(user)
    user.username.present? ? user.username : user.email
  end
end
