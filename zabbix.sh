#!/bin/bash

if [ -f /etc/redhat-release ]
then
	echo 'Running system is redhat-release'

    if [ -f /etc/zabbix/zabbix_agentd.conf ]
	then
		state=$(service zabbix-agent status | grep Active | cut -d ' ' -f 5)

		if [ "$state" == "active" ]
		then
			echo 'zabbix agent is running'
			exit

		elif [ "$state" == "inactive" ]
		then
			echo 'zabbix agent is not running. Starting the agent'
			sudo service zabbix-agent start
			exit
	    fi

    elif ! [ -f /etc/zabbix/zabbix_agentd.conf ]
	then
		sudo yum install zabbix-agent -y
		host=$(hostname)
		sudo sed -i '137iHostname='${host} /etc/zabbix/zabbix_agentd.conf
		sudo service zabbix-agent restart		
		echo 'Agent is installed'
		exit
    fi
fi

if [ -f /etc/lsb-release ]
then
	echo 'Running system is lsb-release'

	if [ -f /etc/zabbix/zabbix_agentd.conf ]
	then
		state=$(service zabbix-agent status | grep Active | cut -d ' ' -f 5)
		if [ "$state" == "active" ]
		then
			echo 'zabbix agent is running'
			exit

		elif [ "$state" == "inactive" ]
		then
			echo 'zabbix agent is not running. Starting the agent'
			sudo service zabbix-agent start
			exit
		fi

	elif ! [ -f /etc/zabbix/zabbix_agentd.conf ]
	then
		sudo apt-get install zabbix-agent -y
		host=$(hostname)
		sudo sed -i '137iHostname='${host} /etc/zabbix/zabbix_agentd.conf
		sudo service zabbix-agent restart		
		echo 'Agent is installed'
		exit
	fi
fi

