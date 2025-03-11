
# Docker hub id:

username: omprakashbhanarkar
pass: omprakash@1995


# Jenkins Installation Steps

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
	
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf upgrade

dnf install fontconfig java-17-openjdk

yum install java-17-amazon-corretto-headless -y / amazon linux 2023 - AMI image

yum install jenkins -y

systemctl start jenkins
systemctl enable jenkins
systemctl daemon-reload


# Sonarqube Installation Steps

apt install unzip
adduser sonarqube
passwd sonarqube
su - sonarqube
sudo -i
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip *
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start


# Docker Installation Steps

yum install docker

systemctl start docker
systemctl enable docker

usermod -aG docker $USER
usermod -aG docker jenkins

# Plugin install

docker pipeline
sonarscanner




