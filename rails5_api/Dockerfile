FROM ruby:2.3.0
MAINTAINER Hadwin Zheng(hadwinzhy@gmail.com)

RUN mkdir /workspace
WORKDIR /workspace

COPY Gemfile /workspace/Gemfile
COPY Gemfile.lock /workspace/Gemfile.lock
COPY config/database_docker.yml /workspace/config/database.yml

RUN bundle install --jobs 20 --retry 5

COPY . /workspace/

EXPOSE 3000

# mysql use another docker or direct
#RUN rake db:create && rake db:migrate
#RUN bundle exec passenger start

# for test
# rspec --format RspecJunitFormatter  --out rspec.xml
