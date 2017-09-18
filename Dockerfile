FROM ruby:2.4
ADD . /source
RUN cd /source && gem install rainbow && gem build gitlab_clone.gemspec
RUN cd /source && gem install gitlab_clone-0.12.1.gem
ADD startup.sh /
ENTRYPOINT /startup.sh