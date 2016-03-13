#!/usr/bin/perl

###############################################################################
# threadudpclient.pl - program to act as a client by opening 4 sockets to the 
#					   same port where the threadudpserver.pl is multithreaded 
#					   and will listen on a specfic thread
#
# Authored 	   - Demetrios Dimatos
# Date		   - December 20, 2005
# Contact	   - dimatos@gmail.com
#
# Future add's - Off the top of my head I would allow for a user to input
#                x number of sockets that will send packets simply by 
#				 creating an array pointers to a nubmer of sockets then just for
# 				 loop through the number user wants
###############################################################################

###############################################################################
# SET STDIN ARGS AND PRINT USAGE
###############################################################################

if ($#ARGV != 2)
{
	print "Usage: ./udpserver <port> <host> <filename>\n";
	exit;
}

# Set argv vars
$PORT=$ARGV[0];
$HOST=$ARGV[1];
$FILENAME=$ARGV[2];
$MAXCOUNT=$ARGV[3];

###############################################################################
# INCLUDES
###############################################################################

use IO::Socket::INET;
use Net::Ping;

###############################################################################
# SETTING GLOBAL VARS
###############################################################################

$COUNT=0;
$KILLSIG="_EXIT_IMMEDIATELY_";
$TIMEOUT=4;
$PACKET_COUNT=0;
                                   
#System variable for Buffering output
$|=1;

###############################################################################
# SOCKET CREATION
###############################################################################

$socket=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

$socket2=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

$socket3=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

$socket4=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

$socket5=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

print "\nBlasting port $PORT at $HOST with UDP (READ only once from $FILENAME)\n";

###############################################################################
# OPEN FILE FOR SENDING
###############################################################################

open ( FILEHANDLE, "<$FILENAME") or die ("\nWARNING: Cannot open $FILENAME\n\n");
$message="";
#note: the max packet send seems to be 1024*59
$rv+= read ( FILEHANDLE, $newText,1024*59) ;
$message = $newText;

###############################################################################
# FAKE MAIN - Basically sends the message each time via each of the sockets
###############################################################################
while(1)
{

	if($rv)
	{
		if($socket->send($message))
		{
			$PACKET_COUNT++;
			print "\n Sent from socket[1]: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
			#$message="";
		}
		if($socket2->send($message))
		{
			$PACKET_COUNT++;
			$rv+=1024*59;
			print "\n Sent from socket[2]: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
			#$message="";
		}
		if($socket3->send($message))
		{
			$PACKET_COUNT++;
			$rv+=1024*59;
			print "\n Sent from socket[3]: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
			#$message="";
		}
		if($socket4->send($message))
		{
			$PACKET_COUNT++;
			$rv+=1024*59;
			print "\n Sent from socket[4]: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
			#$message="";
		}
		if($socket5->send($message))
		{
			$PACKET_COUNT++;
			$rv+=1024*59;
			print "\n Sent from socket[5]: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
			#$message="";
		}
		else
		{
			print "\n\n[ RESET ] ==> FILEHANDLE\n";
		    seek FILEHANDLE, 0, 0;
		}
	}
}

###############################################################################
# CLEAN UP
###############################################################################

$socket->send($KILLSIG);
close($socket);
exit(1);


