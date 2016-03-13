#!/usr/bin/perl
###############################################################################
#
# udpclient_IP_x.pl - Basically a telephone program using udp, since its udp
# 					  it is one way, hence no return ticket. Will use this as
#					  our nasty case. Where a pretty big file will be used
#
###############################################################################

use IO::Socket::INET;
use Net::Ping;

# Read in STDIN args
if ($#ARGV != 3)
{
	print "Usage: ./udpserver <port> <host> <filename> <n-times>\n";
	exit;
}

# Set vars
$PORT=$ARGV[0];
$HOST=$ARGV[1];
$FILENAME=$ARGV[2];
$MAXCOUNT=$ARGV[3];

$COUNT=0;
$KILLSIG="_EXIT_IMMEDIATELY_";
$TIMEOUT=4;
$PACKET_COUNT=0;

$|=1;

# new socket
$socket=new IO::Socket::INET->new(PeerAddr=>$HOST,PeerPort=>$PORT,Proto=>'udp');

print "\nBlasting port $PORT at $HOST with UDP from file $FILENAME\n";

open ( FILEHANDLE, "<$FILENAME") or die ("\nWARNING: Cannot open $FILENAME\n\n");
$message="";

if($MAXCOUNT eq "INFINITY")
{
	while(1)
	{
		#note: the max packet send seems to be 1024*59
		$rv+= read ( FILEHANDLE, $newText,1024*59) ;
		$message = $newText;

		if($rv)
		{
			if($socket->send($message))
			{
				$PACKET_COUNT++;
				print "\n Sent: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
				#$message="";
			}
			else
			{
			    seek FILEHANDLE, 0, 0;
			}
		}
	}
}
else
{
	while($COUNT < $MAXCOUNT)
	{

		#note: the max packet send seems to be 1024*59
		$rv+= read ( FILEHANDLE, $newText,1024*59) ;

		$message .= $newText;

		if($rv)
		{
			if($socket->send($message))
			{
				$PACKET_COUNT++;
				print "\n Sent: [ Packets -> $PACKET_COUNT Totaling -> $rv]";
				#$message="";
			}
			else
			{
				#$LAST_RV+=$rv;
				#$rv="";
				print "\n\n[ RESET ] ==> FILEHANDLE\n";
				seek FILEHANDLE, 0, 0;
			}
		}
		$COUNT++;
	}
}

$socket->send($KILLSIG);
close($socket);
exit(1);

# Orphane code

# read
# $line=<STDIN>;
# @ary=split(/ /,$line);
