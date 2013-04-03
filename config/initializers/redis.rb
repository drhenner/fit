# $redis = Redis.connect(url: (YAML.load(ERB.new(Rails.root.join("config", "redis.yml").read).result) rescue {})[Rails.env])

#uri = URI.parse((YAML.load(ERB.new(Rails.root.join("config", "redis.yml").read).result) rescue {})[Rails.env])
uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
Resque.redis = REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
