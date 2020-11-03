InvisibleCaptcha.setup do |config|
  # NOTE: to pass feature spec
  config.timestamp_enabled = false if Rails.env.test?
  config.sentence_for_humans = ''
end
