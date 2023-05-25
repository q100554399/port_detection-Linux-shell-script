#!/bin/bash
#detection IP's port open or close
#by q100554399
#sorry for my chinese-style english
function run {
echo " *****************************************************"
echo " "
echo "          #        #####   #####   #####  "
echo "          #    #  #     # #     # #     # "
echo "          #    #        # #     # #     # "
echo "          #    #   #####   ######  ###### "
echo "          #######       #       #       # "
echo "               #  #     # #     # #     # "
echo "               #   #####   #####   #####   "                               
echo " "
echo " *****************************************************"
echo " "
echo "Welcom use IP port detection!"
echo "Please input IP: "
read IP

#inturn
if [ -n "$IP" ]
then
#IP format check code copy from internet
VALID_CHECK=$( echo  $IP| awk  -F.  '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}' )
     if  echo  $IP| grep  -E  "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" > /dev/null ;  then
         if  [ ${VALID_CHECK:-no} ==  "yes"  ];  then
             echo  "IP $IP available."
             echo "Checking IP $IP connected..."
        count=0
        ping -c 1 $IP >/dev/null 2>&1
        if [ $? -ne 1 ]
        then
                echo "IP: $IP is connecting, Let's go!"
                echo "** IP $IP Open port list: **" > output_$IP.txt
                for ((i=1; i<=65535; i++))
                do
                        echo "Now testing port is: $i"
                        timeout 1 telnet $IP $i > /dev/null 2>&1
                        if [ $? -ne 1 ]
                        then
                                echo "Port:" $i"" is open! >> output_$IP.txt
                                count=$[ $count+1 ]
                        fi
                done
                echo "Done!"
	        echo "IP: $IP have $count open port." >> output_$IP.txt
                cat output_$IP.txt
                echo "** Save in ./output_*.txt **"
        else
                echo "IP $IP is can't connected."
        fi

         else
         	echo  "IP $IP not available!"
		echo "Please input IP: "
		read IP
		run
         fi
     else
         echo  "IP format error!"
	 echo "Please input IP: "
	 read IP
	 run
     fi
else
        echo "You don't input IP."
	echo "Please input IP: "
	read IP
	run
fi
}
echo "Checking telnet service now, Please wait..."
timeout 1 telnet
if [ $? -ne 127 ]
then
#parameter
if [ -n "$1" ]
then
#IP format check code copy for internet
VALID_CHECK=$( echo  $1| awk  -F.  '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}' )
     if  echo  $1| grep  -E  "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" > /dev/null ;  then
         if  [ ${VALID_CHECK:-no} ==  "yes"  ];  then
             echo  "IP $1 available."
             echo "Checking IP $1 connected..."
        count=0
        ping -c 1 $1 >/dev/null 2>&1
        if [ $? -ne 1 ]
        then
                echo "IP: $1 is connecting, Let's go!"
                echo "** IP $1 Open port list: **" > output_$1.txt
                for ((i=1; i<=65535; i++))
                do
                        echo "Now testing port is: $i"
                        timeout 1 telnet $1 $i > /dev/null 2>&1
                        if [ $? -ne 1 ]
                        then
                                echo "Port:" $i"" is open! >> output_$1.txt
                                count=$[ $count+1 ]
                        fi
                done
		echo "Done!"
                echo "IP: $1 have $count open port." >> output_$1.txt
                cat output_$1.txt
                echo "** Save in ./output.txt **"
        else
                echo "IP $1 is can't connected."
        fi

         else
                echo  "IP $1 not available!"
         fi
     else
         echo  "IP format error!"
     fi
else
	run
fi
else
	echo "Telnet service not install, Port detection can't run."
fi
