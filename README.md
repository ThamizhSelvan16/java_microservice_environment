Make sure you have the eclipse tar.gz file downloaded in the same folder of Dokcerfile and shellscript.sh file. 
The link for eclipse tar.gz file: https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2024-12/R/eclipse-jee-2024-12-R-linux-gtk-x86_64.tar.gz&mirror_id=1287

Some Docker commands for processing 
###########################################    BUILD AND RUN      ####################################

BUILD: 
docker build -t java .

RUN:
docker run --name java -p 5900:5900 -p 8080:8080 -p 3306:3306 java

OPEN CONTAINER IN INTERACTIVE MODE
docker exec -it (container id) bash

Install RealVNC viewer 
#################################       VNC       ############################### 
localhost:5900(search address inside realvnc viewer)
password:my_secure_password(you can change it in shellscript.sh file)

######################################     stop ,restart,run, #####################################
docker stop java (docker stop container_name)

docker restart java

docker start java

docker ps

docker ps -a
