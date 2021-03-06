echo "=================================
      Installing Docker ...
================================="

sleep 2

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

echo "=================================
      Installed successfully
=================================

         run test ..."

sleep 2

sudo docker run hello-world

echo "=================================
  Installing Docker Compose ...
================================="

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "=================================
      Installed successfully
=================================

         view version ..."

sleep 2

docker-compose --version
