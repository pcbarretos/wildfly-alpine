<p align="center">  
    <img
      alt="Wildfly Jboss"
      src="https://design.jboss.org/wildfly/logo/final/wildfly_logo.svg"
      width="200"
    />
</p>

<h3 align="center">Wildfly 15.0.0.Final With JDK 8 Oracle And Drivers JDBC - Postgresql - Jtds - SQLSERVER - Mysql</h3>

* Wildfly versão 15.0.0.Final Oficial
  - https://download.jboss.org/
* Java Oracle JDK 1.8_202
  - http://download.oracle.com/

*Image Base Alpine `FROM anapsix/alpine-java` (Official Docker Hub Image):*
* DockerHub Repo: https://hub.docker.com/r/anapsix/alpine-java

*Environments:*

* ENV JBOSS_HOME         -> `/opt/jboss/wildfly`
* ENV WILDFLY_VERSION    -> `15.0.0.Final`
* ENV LAUNCH_JBOSS_IN_BACKGROUND -> `true`

* PS
  - Para um funcionamento correto deve ser configurado no seu arquivo *standalone.xml* as configs dos Drivers JDBC

  ```xml
      <drivers> 
        <driver name="postgresql" module="org.postgresql"> 
        <!-- 1. chose your connection driver --> 
            <driver-class>org.postgresql.Driver</driver-class> 
        </driver> 
      </drivers> 
    
    
    <datasource jndi-name="java:/PostgresDS" pool-name="PostgresDS"> 
        <connection-url>jdbc:postgresql://localhost:5432/YourDatabase</connection-url> 
          <driver-class>org.postgresql.Driver</driver-class> 
          <driver>org.postgresql</driver> 
      <security> 
          <user-name>YourUserName</user-name> 
          <password>YourPassword</password> 
      </security>
      .......
  ```

*Resources Drivers*

* Mysql Driver Version 5.1.38
* Sqlserver Driver Version 7.0.0
* Jtds Driver version 1.3.1
* Postgresql Driver version 42.2.19

*Alpine Resources Packages*

  *Wget*
  *Tzdata*
  *Busybox*
  *Curl*
  *Gettext*
