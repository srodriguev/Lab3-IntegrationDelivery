FROM node:7.8.0

WORKDIR /opt
ADD . /opt

# Set the logo dynamically based on BRANCH_NAME
ARG BRANCH_NAME
RUN if [ "$BRANCH_NAME" = "main" ]; then cp public/main_logo.svg src/logo.svg; else cp public/dev_logo.svg src/logo.svg; fi

RUN npm install
ENTRYPOINT npm run start
