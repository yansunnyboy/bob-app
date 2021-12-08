module ApplicationHelper
  include Pagy::Frontend
  include ActsAsTaggableOn::TagsHelper

  def qr_svg(url)
    qrcode = RQRCode::QRCode.new(url)
    qrcode.as_svg(
      color: '212121',
      shape_rendering: 'crispEdges',
      module_size: 11,
      standalone: true,
      use_path: true,
      viewbox: '0 0 500 500'
    ).html_safe
  end

  def list_invite_token(list)
    JWT.encode(
      {
        list_id: list.id,
        exp: (Time.zone.now + 30.minutes).to_i,
      },
      Rails.application.secret_key_base,
      "HS256"
    )
  end
end
