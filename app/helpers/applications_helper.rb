module ApplicationsHelper
    def gravatar_for(user, options = { size: 80 })
        gravatar_id = Digest::MD5.hexdigest(user.Username.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.Username, class: 'gravatar')
    end

    def thumb_url
        Rails.application.routes.url_helpers.rails_representation_url(attachment.variant(resize: "200x200").processed, only_path: true)
    end
end
