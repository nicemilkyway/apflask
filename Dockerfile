FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container.
RUN apt-get -y install apache2 
# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container.
# RUN apt-get -y install libapache2-mod-wsgi
RUN apt-get -y install libapache2-mod-wsgi-py3
RUN apt-get -y install python3-pip
RUN apt-get -y install nano
RUN pip3 install --upgrade pip
RUN pip3 install flask


RUN a2enmod wsgi 

EXPOSE 80

# Copy site into place.
ADD app.py /var/www/flask/webtool.py
ADD webtool.wsgi /var/www/flask/

# Update the default apache site with the config we created.
ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf

# By default, simply start apache.
# CMD /usr/sbin/apache2ctl -D FOREGROUND