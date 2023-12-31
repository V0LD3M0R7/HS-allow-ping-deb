#! /bin/bash

echo "The script will now enable ipv4 ping for current session" && sleep 2
echo
gid=$(id -g)
sudo sysctl -w net.ipv4.ping_group_range="0 $gid"
echo
echo "Ping is enabled for this session" && sleep 2
echo
read -p "Do you wish to enable ipv4 ping for your user account by default? (y/n) " yn

# not sure if `while true; do` is neccesery
while true; do
    case $yn in

	    [Yy]* ) 
            ping_allow_write=net.ipv4.ping_group_range="0 $gid";
            sudo echo "$ping_allow_write;" > /etc/sysctl.d/local.conf;
            echo "The process is finished. Closing in 3 seconds" && sleep 1;
            echo ;
            read -rsn1 -p"Press enter to close";
            kill $PPID;;

        [Nn]* ) 
            echo "Closing in 3 seconds" && sleep 1;
            echo ;
            read -rsn1 -p"Press enter to close";
		    kill $PPID;;

        * )
            echo "Please answer yes or no.";;

    esac
done