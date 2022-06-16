FROM ubuntu:20.04

# Run the Update
RUN apt-get update && apt-get upgrade -y

# Install pre-reqs
RUN apt-get install -y python3.9
# RUN apt-get install -y python3.8 curl openssh-server

# Setup sshd
# RUN mkdir -p /var/run/sshd
# RUN echo 'root:password' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# download and install pip
RUN apt -y install python3-pip

# install AWS CLI
RUN pip3 install awscli

# Setup AWS CLI Command Completion
RUN echo complete -C '/usr/local/bin/aws_completer' aws >> ~/.bashrc
CMD [ "/usr/sbin/sshd", "-D"]

EXPOSE 22

#=========POSTGRES========#
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y lsb-release && apt-get install -y wget
# Create the file repository configuration:
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#Import the repository signing key:
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | (OUT=$(apt-key add - 2>&1) || echo $OUT)
# Update the package lists:
RUN apt-get update
RUN apt-get -y install postgresql-14
# RUN service postgresql start

EXPOSE 5432
# CMD ["postgres"]

#=========PIGZ========#
RUN apt-get update
RUN apt-get install -y pigz

#Make sure that your shell script file is in the same folder as your dockerfile while running the docker build command as the below command will copy the file to the /home/root/ folder for execution. 
COPY . /home/root/ 
#Copying script file
USER root 
#switching the user to give elevated access to the commands being executed from the k8s cron job