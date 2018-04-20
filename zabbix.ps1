
$SourceFolder = "<source-folder>"
$TargetFolder = "C:\"



If ((Get-WmiObject win32_service -Filter "name='zabbix agent'").State -eq "Running")
{
    echo "Running"
    Exit
}

Elseif ((Get-WmiObject win32_service -Filter "name='zabbix agent'").State -eq "Stopped") 
{
    echo "Stopped"
    # Starts service if it exists in a Stopped state.
    Start-Service "Zabbix Agent"
    Exit    
}




Copy-Item -Recurse -Path $SourceFolder -Destination $TargetFolder -ErrorAction SilentlyContinue

$test = HOSTNAME.EXE
$test = "Hostname="+$test
(Get-Content -Path "C:\zabbix-agent\conf\zabbix_agentd.win.conf") | ForEach-Object {$_ -replace "Hostname=Windows10",$test} | Set-Content -Path "C:\zabbix-agent\conf\zabbix_agentd.win.conf"



$type = ((Get-WmiObject Win32_OperatingSystem).OSarchitecture).Substring(0,2)
$agent_type = '"C:\zabbix-agent\bin\win"'+$type+'"\zabbix_Agentd.exe --config C:\zabbix-agent\conf\zabbix_Agentd.win.conf"'


New-Service -Name "Zabbix Agent" -BinaryPathName $agent_type -DisplayName "Zabbix Agent" -Description "Provides system monitoring" -StartupType "Automatic"
(Get-WmiObject win32_service -Filter "name='Zabbix Agent'").StartService()