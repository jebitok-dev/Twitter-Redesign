web: bundle exec puma -C config/puma.rb
release: bundle exec rake db:migrate
release: bundle exec rake db:seed
# db:seed is optional, if you use db:seed it will reseed data every time you push)
# add any other commands