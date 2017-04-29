####################
#! /bin/bash       #
#Script by Dpress29#
####################

echo "This tool will help you to configure a reverse ssh protocol, be aware it may be buggy ;-p
Internet connection is needed"

# Requests for information
 while [ -z $server ]; do
 echo "Fill reverse ssh server informations ( user@reversesshserver )"
 read server
 done

 while [ -z $sshportserver ]; do
 echo "What is the ssh port of the ssh server ?"
 read sshportserver
 done

 while [ -z $sshport ]; do
 echo "What is the ssh port of this machine ?"
 read sshport
 done

 while [ -z $forwardingport ]; do
 echo "What is the port for the ssh tunnel?"
 read forwardingport
 done

# The ssh logon will be provided by cerficates (be aware that passphrase need to be empty)
 mkdir -v $HOME/.sshtunnel/ # Directory wich will contain config files
 chmod 700 $HOME/.sshtunnel/ # Needed for security
 ssh-keygen -t rsa -f $HOME/.sshtunnel/id_rsa -b 2048 # Generating 2048 bits certificates
 ssh-copy-id -i $HOME/.sshtunnel/id_rsa.pub $server -p$sshportserver # Sending to reverse ssh server public key


# First ssh logon
 ssh -i $HOME/.sshtunnel/id_rsa.pub -NnR $forwardingport:localhost:$sshport $server -p$sshportserver &
 echo "Great !!! Reverse ssh is now working."
