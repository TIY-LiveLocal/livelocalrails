require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class YelpGemWrapperWorker
  include Sidekiq::Worker

  def perform(location, term, limit=1)
    Rails.logger.debug("it's yelp gem wrapper worker.")
    raw_results = YelpGemWrapper.for({location: location,
       limit: limit,
       term: term
      })
    YelpStrategy.run(raw_results)
  end
end
