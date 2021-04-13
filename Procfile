web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
release: bundle exec rake db:migrate
release: bundle exec rake db:seed
# db:seed is optional, if you use db:seed it will reseed data every time you push)
# add any other commands