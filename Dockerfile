FROM debian:bullseye as builder

ENV PATH=/usr/local/node/bin:$PATH
ARG NODE_VERSION=16.19.1

RUN apt-get update -qq && \
    apt-get install -y python-is-python3 pkg-config build-essential

RUN mkdir /app
WORKDIR /app

COPY . .

RUN npm install && npm run build


FROM debian:bullseye-slim

LABEL fly_launch_runtime="nodejs"

COPY --from=builder /usr/local/node /usr/local/node
COPY --from=builder /app /app

WORKDIR /app
ENV NODE_ENV production
ENV PATH /usr/local/node/bin:$PATH

CMD [ "npm", "run", "start" ]
