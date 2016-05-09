# Seeding Plan Table
p1 = Stripe::Plan.retrieve("plan-free")
p1 = Stripe::Plan.retrieve("plan-good")
p1 = Stripe::Plan.retrieve("plan-awesome")

Plan.create(:stripe_id => p1.id, :name => p1.name, :price => p1.amount, :interval => p1.interval)

require 'Sidekiq/api'
redis-server /usr/local/etc/redis.conf
bundle exec sidekiq -C config/sidekiq.yml
rails s -p 3000 -b lvh.me

Sidekiq::RetrySet.new.clear
stats = Sidekiq::Stats.new