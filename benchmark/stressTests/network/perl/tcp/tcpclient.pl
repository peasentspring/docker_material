#!/usr/bin/perl

use IO::Socket;

# Read in STDIN args
if ($#ARGV != 3) 
{
	print "Usage: ./udpserver <port> <host> <file> <n-times>\n";
	exit;
}

# Set vars
$PORT=$ARGV[0];
$HOST=$ARGV[1];
$FILENAME=$ARGV[2];
$MAXCOUNT=$ARGV[3];

$COUNT=0;
$KILLSIG="_EXIT_IMMEDIATELY_";
$PACKET_COUNT=0;

$socket = new IO::Socket::INET (
                                  PeerAddr  => $HOST,
                                  PeerPort  => $PORT,
                                  Proto => 'tcp',
                               ) or die "Can't connect to Server\n";
    
print "\nBlasting port $PORT at $HOST with TCP packets from file $FILENAME\n";
		
open ( FILEHANDLE, "<$FILENAME") or die ("\nWARNING: Cannot open $FILENAME\n\n");

if($MAXCOUNT eq "INFINITY")
{
	while(1)
	{
		#note: the max packet send seems to be 1024*59
	    $rv+= read( FILEHANDLE, $newText, 1024*59);
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
    while ($COUNT < $MAXCOUNT)
    {
    	$rv+=read ( FILEHANDLE, $newText, 1024*59);
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
				$LAST_RV+=$rv;
				$rv="";
			}
		}
    	$COUNT++;
    }
}
		
		
$socket->send($KILLSIG);
close($socket);
exit(1);
		
    