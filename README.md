# Zabbix


Auto Deployment scripts for Zabbix Monitoring tool.

zabbix.ps1 script can be used to install and check zabbix on Windows operating systems. It is tested on Windows 10 and Windows 7.

To use it, you shoul copy zabbix-agent in your fileserver. After that, specify the file server directory in the script. 


zabbix.sh script can be used to install and check Zabbix on Unix based operating systems(RHEL and LSB). It will control that, if Zabbix agent is installed on target host. If agent is exist, then it will control zabbix-agent service status. 
