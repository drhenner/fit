web: bundle exec rails s --debugger -p $PORT
redis: redis-server
worker: bundle exec rake environment resque:work QUEUE=*
memcached:  memcached -vv

