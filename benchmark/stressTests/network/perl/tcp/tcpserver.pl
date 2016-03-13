#!/usr/bin/perl

use IO::Socket;
$| = 1;

# Read in STDIN args
if ($#ARGV != 2) 
{
	print "Usage: ./tcpserver <port> <host> <[verbose] yes/no> \n";
	exit;
}

# Set vars
$PORT=$ARGV[0];
$HOST=$ARGV[1];
chomp($VERBOSE=$ARGV[2]);
$count =0;
$PACKET_COUNT=0;

$socket = new IO::Socket::INET (
                                  LocalHost => $HOST,
                                  LocalPort => $PORT,
                                  Proto => 'tcp',
                                  Listen => 5,
                                  Reuse => 1
                               ) or die "Cant open socket" unless $socket;


	print "\nWaiting for client on port $PORT .... \n\n";
	
	$client_socket = "";
	$client_socket = $socket->accept();
	
	$peer_address = $client_socket->peerhost();
	$peer_port = $client_socket->peerport();
	
	print "\n Connection made from: ( $peer_address , $peer_port ) ";
	
	
	  while(1)
	  {
		  $client_socket->recv($recieved_data,1024*59);
	  
	       if($recieved_data eq $KILLSIG)
	       {
			   print "\n\nKILLSIGNAL has been detected, exiting\n\n";
			   close $client_socket;
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
		    
