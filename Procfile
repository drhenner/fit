web: bundle exec rails s --debugger -p $PORT
worker: bundle exec rake environment resque:work QUEUE=*
memcached:  memcached -vv
