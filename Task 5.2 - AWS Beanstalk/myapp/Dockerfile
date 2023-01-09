FROM  node:alpine

USER  node
WORKDIR  /home/node/code
COPY  --chown=node:node  index.js  index.js

EXPOSE 3000

CMD  [  "node",  "index.js"  ]