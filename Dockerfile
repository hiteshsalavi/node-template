FROM node-baseimage-arm64:latest

# Create app directory
WORKDIR /app/src

# Install app dependencies
ADD --chown=app:app package*.json ./
RUN chown -R app:app /app

ARG NPM_INSTALL_FLAGS="--production"
RUN /sbin/setuser app npm install $NPM_INSTALL_FLAGS

# Copy nginx config
COPY --chown=app:app config/nginx-main.conf /etc/nginx/nginx.conf
COPY --chown=app:app config/nginx-default-site.conf /etc/nginx/sites-enabled/default

COPY --chown=app:app bin/run-api.sh /etc/service/app/run
RUN chmod +x /etc/service/*/run

COPY --chown=app:app . .
