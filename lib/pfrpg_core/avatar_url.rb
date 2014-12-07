class PfrpgCore::AvatarURL
  attr_reader :avatar
  def initialize(avatar)
    @avatar = avatar
  end

  def as_json(options={})
    {
      default_url: avatar.url,
      thumb_url: avatar.url(:thumb),
      medium_url: avatar.url(:medium),
      square_url: avatar.url(:square)
    }
  end
end
