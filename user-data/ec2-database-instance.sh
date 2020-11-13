#!/bin/bash
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " ================================================================================ "
echo " ################################################################################ "
echo " ================================================================================ "
echo "                                                                                  "
echo "               |    |  ----   ---  ---     --     --   -----   --                 "
echo "               |    | |      |    |   |   |  \   /  \    |    /  \                "
echo "               |    |  ----  |--- |---    |   | |    |   |   |    |               "
echo "               |    |      | |    |  \    |  /  |----|   |   |----|               "
echo "                \__/   ----   --- |   \    --   |    |   |   |    |               "
echo "                                                                                  "
echo " ======================================== "
echo " === Here starts the user data script === "
echo " ===   of the database ec2-instance   === "
echo "                                          "
echo " Current Date-time stamp (YYYYMMDD HH:MM:SS:mS)"
echo "$(date +'%Y%m%d %H:%M:%S:%3N')"
echo "                                          "
echo "                                          "
echo " ---------------------------------------- "
echo "                                          "
echo " Step 1: mySQL installation begins        "
echo "                                          "
sudo yum update –y

# Commands to print the Jenkins admin password after bash login
# as well as other useful info
PUBLIC_IP=$(curl -s ifconfig.co)
echo 'PUBLIC_IP='$PUBLIC_IP >> /etc/environment
customfile=/etc/profile.d/custom.sh
sudo touch $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " ################################## "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " "" Welcome ${USER}" to the mySQL-database instance' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ""The instance public IP address is:"' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "$PUBLIC_IP' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " ################################## "' >> $customfile
sudo echo 'echo " ================================== "' >> $customfile
sudo echo 'echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
sudo echo 'echo "   "' >> $customfile
echo "                                          "
echo " Current Date-time stamp (YYYYMMDD HH:MM:SS:mS)"
echo "$(date +'%Y%m%d %H:%M:%S:%3N')"
echo "                                          "
echo " ======================================== "
echo " ==== Here ends the user data script ==== "
echo " ---------------------------------------- "
echo " ================================================================================ "
echo " ################################################################################ "
echo " ================================================================================ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
echo " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
