#!/bin/sh

################################################################################
#                                                                             
# TCPhostStress - host machine, this should be run on the host, the one       
#					which you wish to be the observer.                        
#					                                                                     
# Author - Demetrios Dimatos                                                  
# Contact - dimatos@gmail.com                                                 
#                                                                             
# Usage - Run this from the file                                              
# Usage - For ths to run correctly the client must be running first.          
# Usage ./TCPhostStress <port> <host> <file> <java-or-c>
#
# Java ttcp  options
#				 -r	Receive mode
#                -t	Transmit mode
#                -n	Number of buffers (default 8192)
#                -l	Buffer size (default 1024)
#                -p	TCP Port number (default 5001)                    
# i.e. cmdlne    start reciever - java ttcp -r
#                               - java ttcp -r -l 4096 -n 100
#				 start sender   - java ttcp -t 127.0.0.1
#				               
#
# 
# Usage: ttcp -t [-options] host <in
# 		 ptions:
#                -l##    length of bufs written to network (default 1024)
#                -s      source a pattern to network
#                -n##    number of bufs written to network (-s only, default 1024)
#                -p##    port number to send to (default 2000)
#                -u      use UDP instead of TCP
#        Usage: ttcp -r [-options] >out
#                -l##    length of network read buf (default 1024)
#                -s      sink (discard) all data from network
#                -p##    port number to listen at (default 2000)
#                -B      Only output full bloc0ks, as specified in -l## (for TAR)
#                -u      use UDP instead of TCP
#        
# Todo:		- Add in features provisions to allow options to be passed in.
#
################################################################################

printMenu()
{
	echo
	echo "   <---------  Matching receiver must be started before matching sender --------->"
	echo
	echo "--------------------------------------------------------------------------------------"
	echo "                         Receiver usage"
	echo "--------------------------------------------------------------------------------------"
	echo
	echo "Receiver c USAGE:        ./stress.sh <port> <c>"
	echo "Example                  ./stress.sh 5001 c"
	echo                         
	echo "Receiver java USAGE:     ./stress.sh <port> <buffer size> <number buffers> <java>"
	echo "Example                  ./stress.sh 5001 1024 10 java"
	echo                          
	echo "Receiver perl udp USAGE: ./stress.sh <port> <[verbose] yes/no> <perludp>"
	echo "Example                  ./stress.sh 5001 yes perludp"
	echo 
	echo "Receiver perl tcp USAGE: ./stress.sh <port> <host> <[verbose] yes/no> <perltcp>"
	echo "Example                  ./stress.sh 5001 127.0.0.1 yes perltcp"
	echo
	echo "--------------------------------------------------------------------------------------"
	echo "                         Sender usage"
	echo "--------------------------------------------------------------------------------------"
	echo                           
	echo "Sender c USAGE:          ./stress.sh <port> <host> <file> <c>"
	echo "Example                  ./stress.sh 5001 127.0.0.1 x.txt c"
	echo
	echo "Sender java USAGE:       ./stress.sh <port> <host> <java>"
	echo "Example                  ./stress.sh 5001 127.0.0.1 java"
	echo
	echo "Sender perl udp USAGE:   ./stress.sh <port> <host> <file> <n-times/INFINITY> <perludp>"
	echo "Example                  ./stress.sh 5001 127.0.0.1 x.txt 1000 perludp"                           
	echo
	echo "Sender perl tcp USAGE:   ./stress.sh <port> <host> <file> <n-times> <perltcp>"
	echo "Example                  ./stress.sh 5001 127.0.0.1 x.txt 1000 perltcp"  
	echo
	echo "--------------------------------------------------------------------------------------"
	echo "                         Multi-thread perl udp usage"
	echo "--------------------------------------------------------------------------------------"
	echo
	echo "Receiver perl-multi-thread udp USAGE: ./stress.sh <port> <[verbose] yes/no> <perludp-thread>"
	echo "Example                  				./stress.sh 5001 yes perludp-thread"
	echo
	echo "Sender perl-multi-thread udp USAGE:   ./stress.sh <port> <host> <file> <perludp-thread>"
	echo "Example                  				./stress.sh 5001 127.0.0.1 x.txt perludp-thread"
	exit	
}

# Globals
DIRCURR=`pwd`
DIRTEMP=/tmp/
FILEOUT_SENDER=stressSender.out
FILEOUT_RECEIVER=stessRceiver.out
# BITS=8

# command line parsing of option count for args
if [ $# -lt 2 ]  # args < 2 usage menu
then                                                                                                            
	printMenu
elif [ $# = 2 -a $2 = "c" ]  # C reciever
then 
	# set vars
	PORT=$1
	
	# zero file
	0>$DIRTEMP$FILEOUT_RECEIVER
	
	# execute
	bin/ttcp -r -s -p$PORT>&$DIRTEMP$FILEOUT_RECEIVER
	echo
	echo "Results saved in flsile: $DIRTEMP$FILEOUT_RECEIVER"
	echo
	echo "----------------------------------------------------------------"
	echo
	cat $DIRTEMP$FILEOUT_RECEIVER
	echo "----------------------------------------------------------------"
	echo
	exit
elif [ $# = 3  -a $2 = "yes" -o $2 = "no" -a $3 = "perludp" ]  # perl reciever
then 
	# set vars
	PORT=$1
	VERBOSE=$2
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/udp/udpserver.pl $PORT $VERBOSE
	echo 
	exit
elif [ $# = 3  -a $2 = "yes" -o $2 = "no" -a $3 = "perludp-thread" ]  # perl reciever multi-thread
then 
	# set vars
	PORT=$1
	VERBOSE=$2
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/udp/threadudpserver.pl $PORT $VERBOSE
	echo 
	exit
elif [ $# = 3 -a $3 = "java" ] # java option sender
then
	# set vars
	PORT=$1
	HOST=$2
	FILENAME=$3
	
	# zero file
	0>$DIRTEMP$FILEOUT_SENDER
	
	# cd to jav bin
	cd jav/
	java ttcp -p $PORT -t $HOST>&$DIRTEMP$FILEOUT_SENDER
	cd $DIRCURR
	echo
	echo "Results saved in flsile: $DIRTEMP$FILEOUT_SENDER"
	echo
	echo "----------------------------------------------------------------"
	echo
	cat $DIRTEMP$FILEOUT_SENDER
	echo "----------------------------------------------------------------"
	echo	
	exit
elif [ $# = 4 -a $4 = "java" ] #java reciever
then
	# set vars
	PORT=$1
	BUFFER_SIZE=$2
	NUMBER_BUFFER=$3
	
	# zero file
	0>$DIRTEMP$FILEOUT_RECEIVER
	
	# cd to jav bin
	cd jav/ 
	java ttcp -r -p $PORT -l $BUFFER_SIZE -n $NUMBER_BUFFER>&$DIRTEMP$FILEOUT_RECEIVER
	cd $DIRCURR
	echo
	echo "Results saved in file: $DIRTEMP$FILEOUT_RECEIVER"
	echo
	echo "----------------------------------------------------------------"
	echo
	cat $DIRTEMP$FILEOUT_RECEIVER
	echo "----------------------------------------------------------------"
	echo
	exit
elif [ $# = 4 -a $4 = "c" ]  # C option sender
then 
	# set vars
	PORT=$1
	HOST=$2
	FILENAME=$3
	
	# zero file
	0>$DIRTEMP/$FILEOUT_SENDER
	
	# execute
	bin/ttcp -t -p$PORT $HOST<$FILENAME>&$DIRTEMP/$FILEOUT_SENDER
	echo
	echo "Results saved in flsile: $DIRTEMP/$FILEOUT_SENDER"
	echo
	echo"----------------------------------------------------------------"
	echo
	cat $DIRTEMP/$FILEOUT_SENDER
	echo "----------------------------------------------------------------"
	echo
	exit
elif [ $# = 4 -a $3 = "yes" -o $3 = "no" -a $4 = "perltcp" ]  # perl tcp reciever
then 
	# set vars
	PORT=$1
	HOST=$2
	VERBOSE=$3
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/tcp/tcpserver.pl $PORT $HOST $VERBOSE
	echo 
	exit
elif [ $# = 4 -a $4 = "perludp-thread" ] #perl udp sender-multi-thread
then
	# set vars
	PORT=$1
	HOST=$2
	FILENAME=$3
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/udp/threadudpclient.pl $PORT $HOST $FILENAME
	echo 
	exit
elif [ $# = 5 -a $5 = "perludp" ] #perl udp sender
then
	# set vars
	PORT=$1
	HOST=$2
	FILENAME=$3
	MAXCOUNT=$4
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/udp/udpclient.pl $PORT $HOST $FILENAME $MAXCOUNT
	echo 
	exit
elif [ $# = 5 -a $5 = "perltcp" ] #perl tcp sender
then
	# set vars
	PORT=$1
	HOST=$2
	FILENAME=$3
	MAXCOUNT=$4
	
	# execute Really no reason to direct this to a file better STDOUT
	perl/tcp/tcpclient.pl $PORT $HOST $FILENAME $MAXCOUNT
	echo 
	exit
else
	printMenu
fi

# Orphane Code

# BYTES=`awk '/bytes/ { print $2 }'>&FILENAME`
# SECONDS=
# BIT_RATE=`expr $BYTES * $BITS`
# local ANSWER_JAVA_FOUND=`java -version 2>&1 | grep 'java version' 2>&1 | awk '{print $3}'`
