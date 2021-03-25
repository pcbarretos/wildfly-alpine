FROM anapsix/alpine-java:8u202b08_jdk

LABEL maintainer "Paulo Barreto"

USER root

# Set Wildfly variables and Version
ENV JBOSS_HOME /opt/jboss/wildfly   
ENV WILDFLY_VERSION 15.0.0.Final
ENV LAUNCH_JBOSS_IN_BACKGROUND true

RUN apk add --update --no-cache && apk add wget curl tzdata gettext busybox

# Install WILDFLY
RUN cd $HOME && \
    wget -q http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz && \
    tar xzvf wildfly-$WILDFLY_VERSION.tar.gz && \
    mkdir -p /opt/jboss && \
    mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME && \
    rm -rf wildfly-$WILDFLY_VERSION.tar.gz

# Set Timezone
ENV TZ="America/Sao_Paulo"

# Install Mysql Driver Version 5.1.38
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main && cd /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main && wget -q https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar

COPY drivers/mysql/module.xml /opt/jboss/wildfly/modules/system/layers/base/com/mysql/main/

# Install Sqlserver Driver Version 7.0.0
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/main && cd /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/main && wget -q https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/7.0.0.jre8/mssql-jdbc-7.0.0.jre8.jar

COPY drivers/sqlserver/module.xml /opt/jboss/wildfly/modules/system/layers/base/com/microsoft/sqlserver/main/

# Install Jtds Driver version 1.3.1
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/net/sourceforge/jtds/main/ && cd /opt/jboss/wildfly/modules/system/layers/base/net/sourceforge/jtds/main && wget -q https://repo1.maven.org/maven2/net/sourceforge/jtds/jtds/1.3.1/jtds-1.3.1.jar

COPY drivers/jtds/module.xml /opt/jboss/wildfly/modules/system/layers/base/net/sourceforge/jtds/main/ 

# Install Postgresql Driver Version 42.2.19
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main && cd /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main && wget -q https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.19/postgresql-42.2.19.jar

COPY drivers/postgres/module.xml /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/ 

# Expose the ports we're interested in
EXPOSE 8080

# Entrypoint
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]