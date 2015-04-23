FROM ubuntu:trusty
MAINTAINER Flavio Primo <flavio.primo91@gmail.com>


## INSTALLATION
# install essentials
RUN apt-get update && apt-get install -y \
    supervisor \
    software-properties-common

# install Nginx and hhvm repositories
RUN add-apt-repository -y ppa:nginx/development

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN add-apt-repository 'deb http://dl.hhvm.com/ubuntu trusty main'

# install Nginx and hhvm
RUN apt-get update && apt-get install -y \
    nginx \
    hhvm


## CONFIGURATION
# configure hhvm
RUN /usr/share/hhvm/install_fastcgi.sh
RUN update-rc.d hhvm defaults
RUN /usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

# configure nginx
ADD conf/nginx /etc/nginx/sites-available/default

# configure web folder permissions
RUN chown -R www-data:www-data /var/www/


## CLEANUP & DOCKER CONFIGURATION
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mountable directories.
VOLUME ["/var/www/","/var/log/nginx/"]

# expose port 80
EXPOSE 80


## SUPERVISOR
ADD conf/supervisor /etc/supervisor/conf.d/supervisord.conf
CMD ["supervisord"]
