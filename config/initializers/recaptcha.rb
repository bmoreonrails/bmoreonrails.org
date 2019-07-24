Recaptcha.configure do |config|
  config.site_key  = ENV.fetch('RECAPTCHA_KEY') { 'Put your reCaptcha key in RECAPTCHA_KEY' }
  config.secret_key = ENV.fetch('RECAPTCHA_SECRET_KEY') { 'Put your reCaptcha secret key in RECAPTCHA_SECRET_KEY' }
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end