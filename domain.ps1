#
#   Title: domain.ps1
# Summary: Build a new DC in a new Forest
#  Author: Eric Case
#    Date: October 2018
#

$nicame = Get-NetAdapter  | select -ExpandProperty "name"
$ipaddress = "10.0.0.2"
$dnsaddress = "127.0.0.1"
New-NetIPAddress -InterfaceAlias $nicname -IPAddress $ipaddress -AddressFamily IPv4 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias $nicname -ServerAddresses $dnsaddress
Get-TimeZone
Write-Host "Is this the correct timezone?  If not, use Set-TimeZone -Name doublequote name doublequote"
#Restart-Computer
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
$workgroup = "ad."+(Get-WmiObject -Class Win32_ComputerSystem).Workgroup
Install-ADDSForest -DomainName $workgroup

dcdiag
Get-Service adws,kdc,netlogon,dns
Get-smbshare
