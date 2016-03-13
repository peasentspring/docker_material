#!/usr/bin/perl

use IO::Socket::INET;

# Read in STDIN args
if ($#ARGV != 1) 
{
	print "Usage: ./udpserver <port> <[verbose] yes/no> \n";
	exit;
}

# Set vars
$PORT=$ARGV[0];
chomp($VERBOSE=$ARGV[1]);

$KILLSIG="_EXIT_IMMEDIATELY_";
$count=0;
#System variable for Buffering output
$| = 1;

# new socket
$socket=new IO::Socket::INET->new(LocalPort=>$PORT,Proto=>'udp',Reuse=>1);

print "\nWaiting for client on port $PORT .... \n\n";


while(1)
{
	$socket->recv($recieved_data,1024*59) or die "recieved failure: $!";
	$peer_address = $socket->peerhost();
	$peer_port = $socket->peerport();
	
	if($recieved_data eq $KILLSIG)
	{
		print "\n\nKILLSIGNAL has been detected, exiting\n\n";
		#close $socket;
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

# Orphane Code

# Read in STDIN args
#$line=<STDIN>;
#@ary=split(/ /,$line);
