FROM node:latest

RUN set -e \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
	&& yarn global add typescript \
	&& apt-get -y install openssh-server build-essential \
		git libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev liblua5.2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev lua5.2 ruby mercurial \
		lua5.2 \
		libluajit-5.1-2 libluajit-5.1-dev \
		unzip \
		curl \
		sudo \
	&& ldconfig \
	&& cd /tmp \
	&& wget https://github.com/vim/vim/archive/v8.0.1216.zip \
	&& unzip v8.0.1216.zip \
	&& cd vim-8.0.1216 \
	&& ./configure \
		--enable-multibyte \
		--with-features=huge \
		--enable-luainterp \
		--enable-perlinterp \
		--enable-pythoninterp \
		--with-python-config-dir=/usr/lib64/python2.6/config \
		--enable-rubyinterp \
		--with-ruby-command=/usr/bin/ruby \
		--enable-terminal \
	&& make -j$(nproc) \
	&& ./src/vim --version \
	&& make install \
	&& rm -rf /tmp/* \
	&& groupadd -g 1001 developer \
	&& useradd  -g      developer -G sudo -m -s /bin/bash dev \
	&& echo 'Defaults visiblepw'             >> /etc/sudoers \
	&& echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dev
