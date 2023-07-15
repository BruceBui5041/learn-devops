# ARG only available when run build image
ARG NODE_VERIONS=latest

FROM node:${NODE_VERIONS}

#ARG can have multiple ARF instruction on one Dockerfile
ARG WORK_DIR=/app

# when run exec -it container_name /bin/bash docker will automatically go to WORKDIR
WORKDIR ${WORK_DIR}

# COPY from current to WORKDIR path or specific path defined in the COPY instruction
COPY ./package.json .

# ADD just like COPY but can load resource from the internet
ADD http://github.com/my_repo .

# RUN will execute the cmd followed in the WORKDIR path
RUN npm install

# ENTRYPOINT will REPLACE if there is more args in the end of the run command
# Ex: docker run --name new_node node by bruce
# if you check the log you'll see: by bruce
CMD [ "echo", "hello world" ]

# ENTRYPOINT will APPEND if there is more args in the end of the run command
# Ex: docker run --name new_node node by bruce
# if you check the log you'll see: hello world by bruce
ENTRYPOINT [ "echo", "hello world" ]

