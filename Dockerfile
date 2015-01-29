FROM ubuntu:14.04
MAINTAINER Peter Alserda
RUN (apt-get update && \
     apt-get install -yq \
	 nodejs npm git-core ruby-sass && \
     rm -rf /var/lib/apt/lists/* && \
     ln /usr/bin/nodejs /usr/bin/node)
RUN (npm install -g grunt-cli && npm install -g grunt && npm install -g bower)
RUN (mkdir /app)
COPY *.json /app/
WORKDIR /app
RUN (npm install && bower install --allow-root)
COPY . /app
EXPOSE 9000
CMD ["grunt", "serve"]
