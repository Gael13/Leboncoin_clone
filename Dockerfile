FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm
RUN npm i -g yarn && yarn

RUN mkdir /Leboncoin_clone
WORKDIR /Leboncoin_clone
COPY Gemfile /Leboncoin_clone/Gemfile
COPY Gemfile.lock /Leboncoin_clone/Gemfile.lock
RUN bundle install
COPY . /Leboncoin_clone

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]