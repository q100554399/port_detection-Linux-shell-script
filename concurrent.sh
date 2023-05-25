#!/bin/bash

for ((i=1; i<=3; i++))
do
	if [ $i -ne 3 ]
	then
		./port_search.sh 127.0.0.$i > /dev/null	&
	else

		./port_search.sh 127.0.0.$i > /dev/null
	fi
done

