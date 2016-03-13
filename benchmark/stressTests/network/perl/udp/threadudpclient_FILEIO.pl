#!/usr/bin/perl

###############################################################################
# threadudpserver.pl - program to act as a server udp blaster. This version will
#				 accept many incomming requests to the same port and fork.
#				 Idea is to drive a machines Net via UDP by running this on the
#				 machine to be driven with the corresponding udpclient.pl
#
# Authored 	   - Demetrios Dimatos
# Date		   - December 20, 2005
# Contact	   - dimatos@gmail.com
###############################################################################

###############################################################################
# SET STDIN ARGS AND PRINT USAGE
###############################################################################

if ($#ARGV != 1) 
{
	print "Usage: ./udpserver <satrt_port> <[verbose] yes/no>\n";
	exit;
}

# Set argv vars
$PORT=$ARGV[0];
chomp($VERBOSE=$ARGV[1]);
$NUM_OF_PORTS=$ARGV[2];

###############################################################################
# INCLUDES
###############################################################################

use IO::Socket::INET;

###############################################################################
# SETTING GLOBAL VARS
###############################################################################

#Ignore all child processes to prevent zombies
$SIG{CHLD} = 'IGNORE';

#set global vars
$KILLSIG="_EXIT_IMMEDIATELY_";
$count=0;
$PORT_COUNT=0;

#System variable for Buffering output
$| = 1;

###############################################################################
# SOCKET CREATION
###############################################################################

print "Opening $PORT\n";
	
$socket=new IO::Socket::INET->new(LocalPort=>$PORT,Proto=>'udp',Reuse=>1);

# make sure we can create the socket else report 
die "Cant't open a socket at $PORT !" unless $socket;

print "\nWaiting for client on port $PORT .... \n\n";
	
###############################################################################
# FAKE MAIN - checks for incomming requests and forks
###############################################################################

# wait for a connection
if($socket->recv($recieved_data,1024*59))
{
	#fork var
	my $child;
	
	# either fork or die
	die "Can't fork: $!" unless defined ($child = fork());
	
	# if($child == 0) I am the child my turn to do work!
	if($child == 0)
	{
		
		# Count of packets sent to this port
		$PACKET_COUNT=0;
		
		# Calling from child and sub routine printInfo() while continue to recv
		while($socket->recv($recieved_data,1024*59))
		{
			$peer_address = $socket->peerhost();
			$peer_port = $socket->peerport();
			printInfo();
		}
	}
	else # Now I am the parent my turn to do stuff
    {  
		#lets close the socket since no more recv's are being noticed
        close($socket);
		exit(0);
    }
	
}

###############################################################################
# Function printInfo() - prints the mesg received used by child
###############################################################################

sub printInfo
{
	
	if($recieved_data eq $KILLSIG)
	   {
		   print "\n\nKILLSIGNAL has been detected, exiting\n\n";
	   	   close $socket;
		   exit(0);
	   }
	   
	   if($VERBOSE eq "yes")
	   {
		  $count++;
		  $PACKET_COUNT++;
		  $rv+=(1024*59);
		  print "\n From: [ $peer_address:$peer_port Packets -> $PACKET_COUNT Totaling -> $rv]-> $recieved_data";
		  $| = 1;
	   }
	   else
	   {
		   $count++;
		   $PACKET_COUNT++;
		   $rv+=(1024*59);
		   print "\n From: [ $peer_address:$peer_port Packets -> $PACKET_COUNT Totaling -> $rv]";
		   $| = 1;
	   }
	
}
