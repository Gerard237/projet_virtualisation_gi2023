#!/bin/bash
username='guest'
ip_address='192.168.1.102'
test_file="test_suite.sh"
app="feature_dependance"
vm_parameter=()
i=0 

for word in $(cat vm_parameter.txt)
do
  vm_parameter[$i]=$word
  let i+=1
done
vm_name=${vm_parameter[0]}
vm_cfg_file_path=${vm_parameter[1]}
app_name=${vm_parameter[3]}

xl create $vm_cfg_file_path
sleep 20

ssh $username@$ip_address  \
"mkdir project"
scp install_app.sh $username@$ip_address:/home/guest/project 
scp $test_file $username@$ip_address:/home/guest
scp $app $username@$ip_address:/home/guest
scp $app_name $username@$ip_address:/home/guest/project
ssh $username@$ip_address  \
"cd project;
source install_app.sh" 

xl shutdown $vm_name
sleep 20
source select_features.sh


