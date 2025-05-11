FROM ubuntu:22.04

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python \
                       python3 \
                       sudo
                    
RUN apt-get update && apt-get install -y python3 sudo curl gnupg wget python-is-python3

# 安装 nvm
ENV NVM_DIR=/root/.nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# 用 nvm 安装 Node.js 18 并做全局软链
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 18 && nvm alias default 18 && ln -s $NVM_DIR/versions/node/v18.*/bin/node /usr/local/bin/node && ln -s $NVM_DIR/versions/node/v18.*/bin/npm /usr/local/bin/npm"


ADD . /build_tools
WORKDIR /build_tools

CMD ["sh", "-c", "cd tools/linux && python3 ./automate.py"]
