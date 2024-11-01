module ApplicationHelper
  def gravatar_for(user)
    email_address = user.email.downcase
    hash = Digest::SHA256.hexdigest(email_address)
    size = 200

    params = URI.encode_www_form("s" => size)

    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?#{params}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end
end
