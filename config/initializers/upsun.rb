# config/initializers/upsun.rb
# Automatically configure Spree Store URL from Upsun environment

Rails.application.config.after_initialize do
  if ENV['PLATFORM_ROUTES'].present?
    begin
      routes = JSON.parse(Base64.decode64(ENV['PLATFORM_ROUTES']))
      primary_route = routes.find { |_url, config| config['primary'] }
      primary_url = primary_route&.first || routes.keys.first

      if primary_url.present?
        url = primary_url.chomp('/')
        store = Spree::Store.default
        store&.update_column(:url, url) if store && store.url != url
      end
    rescue StandardError => e
      Rails.logger.warn "Could not set Spree Store URL from PLATFORM_ROUTES: #{e.message}"
    end
  end
end