FROM 		ubuntu:latest

# Setting the Node & npm version
ENV 		NODE_VERSION 5.0.0
ENV 		NPM_VERSION 3.4.0
# Setting the working directory
WORKDIR 	/src

# Install Node.js and other dependencies
RUN 		apt-get update \ 
			&& apt-get -y install curl \
			&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
			&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
			&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
			&& npm install -g npm@"$NPM_VERSION" \
			&& npm cache clear


# Copy application source from local (host) machine to container
COPY . /src
# Install app dependencies
RUN cd /src; npm install

EXPOSE 		3000
CMD ["npm", "start"]
