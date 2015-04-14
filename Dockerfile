FROM ubuntu: 14.04
MAINTAINER onursumer

##### UBUNTU
# Update Ubuntu and add extra repositories

# Nano
RUN apt-get -y install links nano
# Curl
RUN apt-get -y install libcurl4-openssl-dev
# Java
RUN apt-get -y install openjdk-7-jdk
# Apache
RUN apt-get install apache2
RUN apt-get install -y libapache2-mod-proxy-html libxml2-dev
RUN a2enmod proxy
RUN a2enmod proxy_http
   # TODO here: ProxyRequests Off!
RUN vim /etc/apache2/mods-available/proxy.conf
# Tomcat
RUN apt-get -y install tomcat7
# Latest R version
RUN nano /etc/apt/sources.list
RUN apt-get -y install r-base r-base-dev
# Git
RUN apt-get -y install git
# Maven
RUN apt-get -y install maven
# node & node.js
RUN apt-get -y install nodejs
RUN apt-get -y install nodejs-legacy
RUN apt-get -y install npm

##### R: COMMON PACKAGES
# To let R find Java
RUN R CMD javareconf

# Install common R packages
RUN R -e "install.packages(c('parcor', 'parmigene', 'jsonlite', 'Rserve'), repos='http://cran.rstudio.com/')"

# TODO make sure this installs qvalue
# Install Bioconductor
RUN R -e "source('http://bioconductor.org/biocLite.R'); biocLite(c('Biobase', 'BiocCheck', 'BiocGenerics', 'BiocStyle'))"

# TODO install custom (local) R packages

# start Rserve
RUN R -e "library(Rserve); Rserve();"

# TODO copy data under /data
RUN mkdir /data

# TODO checkout, build & deploy apps
RUN mkdir ~/repos

# TODO set file permissions to tomcat7:tomcat7
# RUN chown tomcat7:tomcat7 /data/*

# restart tomcat
RUN sudo /etc/init.d/tomcat7 restart

#Expose default tomcat port
EXPOSE 8080


