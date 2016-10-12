#/bin/bash

set -ux

url="ssh://Wuwenbin@gerrit.onosproject.org:29418/onos"
cd ~
#git clone $url

ip=$(ifconfig eth0 | grep inet | grep -Eo "[0-9a-f\]+.[0-9a-f\]+.[0-9a-f\]+.[0-9a-f\]+" | head -n 1)

## if onos cluster is wanted, add ips orderly. Or please comment it. 
ip1=192.168.212.225
ip2=192.168.212.232

user="onos"
group="onos"
pwd="root"
sed -i "s/ONOS_USER:-sdn/ONOS_USER:-$user/g" ~/onos/tools/dev/bash_profile
sed -i "s/ONOS_GROUP:-sdn/ONOS_GROUP:-$group/g" ~/onos/tools/dev/bash_profile

sed -i "s/OCI:-192.168.56.101/OCI:-$ip/g" ~/onos/tools/build/envDefaults
sed -i "s/ONOS_USER:-sdn/ONOS_USER:-$user/g" ~/onos/tools/build/envDefaults
sed -i "s/ONOS_GROUP:-sdn/ONOS_GROUP:-$group/g" ~/onos/tools/build/envDefaults
sed -i "s/rocks/$pwd/g" ~/onos/tools/build/envDefaults

sed -i '/OCN/d' ~/onos/tools/test/cells/local
sed -i '/OC2/d' ~/onos/tools/test/cells/local
sed -i '/OC3/d' ~/onos/tools/test/cells/local
sed -i "s/192.168.56.101/$ip/g" ~/onos/tools/test/cells/local
sed -i "s/192.168.56/10.0.2/g" ~/onos/tools/test/cells/local
#if [ -n "$ip1" ];then
#  sed "4a\export OC2=\"$ip1\"" -i ~/onos/tools/test/cells/local 
#fi
#if [ -n "$ip1" ] &&  [ -n "$ip2" ];then
#  sed "5a\export OC3=\"$ip2\"" -i ~/onos/tools/test/cells/local
#fi
sed -i "s/rm -fr/#rm -fr/g" /home/onos/onos/tools/test/bin/onos-install

unset cell
source ~/onos/tools/dev/bash_profile
source ~/onos/tools/build/envDefaults
source ~/onos/tools/test/cells/local


cd ~/onos
#mvn clean install -DskipTests
