set :branch, ENV.fetch('BRANCH', 'develop')
set :stage, :production
set :rails_env, :production
set :puma_env, :production

server ENV['SERVER_IP'], user: 'deploy', roles: %w{web app db}
