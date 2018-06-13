#!/bin/sh

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts


function usage()
{
	echo "Usage:"
	echo "$0 add [host] [ip]"
	echo "$0 update [host] [ip]"
	echo "$0 remove [host] "
	echo
}


function removehost() {
    HOSTNAME=$1
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

function addhost() {
    HOSTNAME=$1
    HOSTS_LINE="$2\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            echo -e "$HOSTS_LINE" >> /etc/hosts;

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}


function updatehost(){
	HOSTNAME=$1
	removehost $1
	addhost $1 $2

}

case $1 in
add)
	
	addhost $2 $3
	;;
remove)
	
	removehost $2
	;;
update)
	updatehost $2 $3
	;;

-h)
	usage
	;;
*)
	echo "Missing command. Type $0 -h for usage."; echo
	;;
esac
exit 0
