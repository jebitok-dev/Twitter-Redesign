release: bundle exec rake db:migrate
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
# db:seed is optional, if you use db:seed it will reseed data every time you push)
# add any other commands