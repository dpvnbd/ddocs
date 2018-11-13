class NotificationBroadcaster
  attr_reader :redis, :data, :exclude_user

  def initialize(redis, data, exclude_user)
    @redis = redis
    @data = data
    @exclude_user = exclude_user
  end

  def call
    User.where.not(id: exclude_user.id).each do |user|
      user.tokens.keys.each do |key|
        redis.publish(key, data)
      end
    end
  end
end
