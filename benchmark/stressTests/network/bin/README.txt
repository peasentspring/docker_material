TTCP is a benchmarking tool for determining TCP and UDP performance 
between two systems.  It can also be used as a network pipe to transfer
data between two systems.

The program was created by someone on the net (we don't know who).  Terry
Slattery obtained it in late 1984 and modified it to run under 4.2BSD Unix
at the US Naval Academy.  It was later improved by a host of folks, including
Mike Muuss at the Army Ballistics Research Lab (BRL)
and and others at Silcon Graphics, University of Maryland, and other places.
It is in the public domain. Feel free to distribute this program
but please do leave the credit notices in the source and man page intact.

Contents of this directory:

ttcp.c		Source that runs on IRIX 3.3.x and 4.0.x systems
		and BSD-based systems.  This version also uses getopt(3) 
		and has 2 new options: -f and -T.

ttcp.c-brl	Original source from BRL.

ttcp.1		Manual page (describes ttcp.c options, which are a 
		superset of the other version).


How to get TCP performance numbers:

	receiver				sender

host1%  ttcp -r -s			host2% ttcp -t -s host1

-n and -l options change the number and size of the buffers.

To use it as a network pipe, don't use the '-s' option and feed your
data into the sender on stdin and extract the data on the receiver
from stdout.

While working at Chesapeake Computer Consultants, Terry created a Java
version of ttcp for use on a variety of platforms, including Windows.
It is based on Java 1.0 and should work on later versions of Java.
The files for the Java version are:

java-README - installation and running directions. 

java-ttcp.zip - a zip file containing the distribution files. 

java-ttcp.tar - a tar file containing the distribution files. 
