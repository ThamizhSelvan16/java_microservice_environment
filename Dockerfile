# Base image                                                                                                           
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts                                                                
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies                                                                                                  
RUN apt-get update && \                                                                                                     
apt-get install -y \                                                                                                    
openjdk-17-jdk \                                                                                                        
curl \                                                                                                                   
unzip \                                                                                                                  
git \                                                                                                                    
maven \                                                                                                                  
tzdata \                                                                                                                 
wget \                                                                                                                   
gnupg \                                                                                                                   
sudo \                                                                                                                   
x11vnc \                                                                                                                 
xvfb \                                                                                                                   
fluxbox \                                                                                                                
lxde-core \                                                                                                              
tightvncserver \                                                                                                        
libxtst6 \                                                                                                               
libxrandr2 \                                                                                                             
libxss1 \                                                                                                                 
libxi6 \                                                                                                                 
libgdk-pixbuf2.0-0 \                                                                                                      
libgtk-3-0 \                                                                                                              
libcanberra-gtk3-0 \                                                                                                      
libnss3 \                                                                                                                
libatk1.0-0 \                                                                                                             
libxcomposite1 \                                                                                                          
libxdamage1 \                                                                                                             
libx11-xcb1 \                                                                                                            
tar \
mysql-server && apt-get clean

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Maven
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz -P /tmp \
    && tar -xvzf /tmp/apache-maven-3.9.9-bin.tar.gz -C /opt/ \
    && rm /tmp/apache-maven-3.9.9-bin.tar.gz

ENV MAVEN_HOME=/opt/apache-maven-3.9.9
ENV PATH=$MAVEN_HOME/bin:$PATH

# Install Spring Boot CLI
RUN curl -L https://repo.maven.apache.org/maven2/org/springframework/boot/spring-boot-cli/3.4.1/spring-boot-cli-3.4.1-bin.tar.gz -o /tmp/spring-boot-cli.tar.gz \
    && tar -xzf /tmp/spring-boot-cli.tar.gz -C /usr/local/ \
    && rm /tmp/spring-boot-cli.tar.gz

ENV PATH="/usr/local/spring-boot-cli-3.4.1/bin:$PATH"


# Install Tomcat 10.1.34
RUN wget -q https://downloads.apache.org/tomcat/tomcat-10/v10.1.34/bin/apache-tomcat-10.1.34.tar.gz \
    && tar -xzf apache-tomcat-10.1.34.tar.gz -C /opt/ \
    && rm apache-tomcat-10.1.34.tar.gz

# Set up a directory for Eclipse and copy the downloaded tarball
WORKDIR /opt
COPY eclipse-jee-2024-12-R-linux-gtk-x86_64.tar.gz /opt/eclipse-jee.tar.gz

# Extract and clean up Eclipse
RUN tar -xvzf eclipse-jee.tar.gz \
    && rm eclipse-jee.tar.gz

# Expose necessary ports
EXPOSE 3306 8080 5900

# Copy shell script and set permissions
COPY shellscript.sh /shellscript.sh
RUN chmod +x /shellscript.sh

# MySQL environment variables
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=my_database
ENV MYSQL_USER=my_user
ENV MYSQL_PASSWORD=my_password

# Start services using the shell script
CMD ["/bin/bash", "/shellscript.sh"]
