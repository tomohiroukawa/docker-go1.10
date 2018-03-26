FROM centos:6.9

RUN yum update -y
RUN yum install -y wget git make zip gcc libffi-devel zlib-devel openssl-devel readline-devel

# install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN source ~/.bash_profile
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN /root/.rbenv/bin/rbenv install -v 2.2.0
RUN /root/.rbenv/bin/rbenv rehash
RUN /root/.rbenv/bin/rbenv global 2.2.0

RUN /root/.rbenv/shims/ruby --version
RUN /root/.rbenv/shims/gem install bundler

RUN wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.10.linux-amd64.tar.gz

ENV LANG ja_JP.UTF-8

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]
