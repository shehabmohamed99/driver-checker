#!/bin/bash


##########This file should be moved to usr/bin to be run from anywhere 
## (mv driver-checker.sh /bin/)
##########################
function new_driver() {

   read -p "Please enter your name " name
   read -p "Please enter your age " age
   read -p "Please enter your vision_rate(from 1 to 6) " vision_rate
   if [[ age -ge 18 ]] && [[ vision_rate -gt 4 ]]
   then
   status=Eligable
   echo "$name is Eligable for licence"
   echo "$name:$age:$vision_rate:$status" >> logfile
   
   else
    status=NOT_Eligable
    echo "$name is Not_Eligable for licence"
    echo "$name:$age:$vision_rate:$status">> logfile
    fi

}
################################################################

function get_driver () {
while true; do
read -p "Enter the name you want to search for his/her result: " name2
if  grep -q "$name2" "logfile"; then

	cat logfile | echo $(grep $name2) | awk -F: '{print $1,":",$4}'
	break
        #grep "$name2" logfile | awk -F: '{print $1,":",$4}
else 
echo "name is not found"
continue
fi 
done

}
####################################################################################

function list_driver () 
{
awk -F: '{print $1 ,":" ,  $4}' logfile 
}
##################################################script####################################


while true; do
echo "Please select your service (new, get or list)" 
read  choice
if [[ $choice == new ]] 
then
  	 new_driver 
	 break
	

elif [ "$choice" = "get" ] 
then
	get_driver
	break
	
	
elif [ "$choice" = "list" ] 
then
	list_driver
	break
else
	echo "wrong choice"
	continue
	
fi
done
