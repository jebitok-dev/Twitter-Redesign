module AvatarHelper
  def avatar_for(user)
    encoded_name = ERB::Util.url_encode(user.fullname)
    src = "https://ui-avatars.com/api/?name=#{encoded_name}&format=svg&background=DBEAFE"

    content_tag(:img, '', src: src, alt: user.fullname, class: 'rounded-circle')
  end
end
