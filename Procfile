web: bundle exec puma -C config/puma.rb
background: QUEUE=* COUNT=1 bundle exec rake environment resque:workers
