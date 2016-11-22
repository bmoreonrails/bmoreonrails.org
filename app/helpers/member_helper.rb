module MemberHelper
  # Returns the local image for the member with gravatar as a fallback.
  # If we have the member's twitter handle, make the image a link to
  # their twitter account, and append their handle to the title on the image.
  # If we don't have twitter, but we do have their githup username,
  # make the image a link to their github page.
  def member_avatar(member)
    return nil if member.nil?

    url = member.twitter_url || member.github_url

    if member.avatar_file_path.present?
      image = image_tag member.avatar_file_path, alt: member.name, title: member.name
    else
      image = gravatar_image_tag member.email, alt: member.name, title: member.name, gravatar: { size: 200 }
    end

    if url.present?
      link_to image, url, target: "_blank"
    else
      image
    end
  end
end
