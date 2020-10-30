#!/bin/bash
echo " ======================================== "
echo " === Here starts the user data script === "
echo " "

newUser=amxeu
adduser $newUser
passwd -d $newUser
mkdir -p /home/$newUser/.ssh
chmod 700 /home/$newUser/.ssh
touch /home/$newUser/.ssh/authorized_keys
chmod 600 /home/$newUser/.ssh/authorized_keys
pubKey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUsDx6WVzsvt3UCZv9mj+qpKcRLIdlgZGR5a8KL1mPOo9Q3DsQtmpGG0DNQzypbih/s9iji4ZoMkp1hnvnt1JjwBZadiF8eOMeGDudCglXoBOwimnKDZYNT8UE40dVzYHvLKATsySbrC4koW1LeR9CcPclT+Dy2x+QHNIQcRoe33N2uRGsB9jCCJgApnN9dXVR7wUmGn2Cdqi1+CPbiYHYXGRqLXizST80+fZciXegUciYJzr7cnn4O0HBgoF3WOkiiyqTpWv87srdeIL6/Minr2J16H56aHCI9bEs1vP0GH735Fd262EMQl99at9/SgIRhrG9sxvORVLk3mvwz1Jh imported-openssh-key"
echo $pubKey >> /home/$newUser/.ssh/authorized_keys
chown -R $newUser:$newUser /home/$newUser/.ssh
sudo su - amxeu -c "touch /tmp/test"

echo " "
echo " ==== Here ends the user data script ==== "
echo " ======================================== "