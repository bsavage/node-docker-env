FROM node:4.4.5

RUN useradd --user-group --create-home --shell /bin/false bcdev &&\
  npm install --global npm@3.7.5

ENV HOME=/home/bcdev

COPY package.json npm-shrinkwrap.json $HOME/bcapp/
RUN chown -R bcdev:bcdev $HOME/*

USER bcdev
WORKDIR $HOME/bcapp
RUN npm install

USER root
COPY . $HOME/bcapp/
RUN chown -R bcdev:bcdev $HOME/*
USER bcdev

CMD ["node", "index.js"]
