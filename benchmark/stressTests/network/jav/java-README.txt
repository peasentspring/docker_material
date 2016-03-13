Installation instructions for the Chesapeake TTCP, a Java-based implemention
of the Test TCP (TTCP) program.

*** Requirements

The Chesapeake TTCP requires the Java 1.0.2 or 1.1.1 run-time system.  We
have provided the run-time systems for Windows95/NT and Sun Solaris.  Your
computer system must also have a network connection for TTCP to be useful.
If you have a Windows95/NT system that uses dialup networking, TTCP will
require that your dialup connection be operating before TTCP will run.

*** Installing Java 1.0.2 runtime

Download the Java run-time system appropriate for your system.  If you have
a computer system other than Windows95/NT or Sun Solaris, you may need to
search the web for an implementation for your system.  Please let us know of
any other systems you find and we'll add links to them from our site.

Select a directory for the installation of the Java run-time software.  We
recommend \java (/usr/local/java for Unix).  The self-extracting zip file
defaults to \java.  There will be two subdirectories installed: \java\bin
and \java\lib (/usr/local/java/bin and /usr/local/java/lib for Unix).  A set
of files will be installed in each of these directories.

If you extract from the zip or tar file, make a note of the installation
directory for configuring your environment (see below.)  We expect that you
know how to extract either the zip or tar file if you select one of these
formats.

*** Installing Chesapeake TTCP

You may install the Chesapeake TTCP in any directory, but we recommend
installing it in /usr/local/java/tools/ttcp (or \java\tools\ttcp).  The
self-extracting zip file defaults to \java\tools\ttcp.  Several files will
be installed in this directory.

*** Setting Your Search Path

Next, you will need to configure your executable search PATH to include the
'bin' directory where you installed java.

To include the java 'bin' directory in your executable path on
Windows95/NT, add the following command to your autoexec.bat or execute it
within a DOS window:

set PATH=%PATH%;c:\java\jdk1.0.2\bin

On Unix (Sun Solaris), modify your executable search path by adding the following
command to your '.profile' (or equivalent startup file):

PATH=$PATH:/usr/local/java/jdk1.0.2/bin

If you installed the Java run-time in a different location, then you will
need to specify the java bin directory from the location where you installed
it.

*** Setting The CLASSPATH

Java uses the CLASSPATH environment variable to seach for library files and
components of Chesapeake's TTCP.  On Windows95/NT, add the following command
to your autoexec.bat or exeute it in the same DOS window where you set the
PATH variable:

set CLASSPATH=c:\java\jdk1.0.2\lib;.

Note that the last character of this command is a period (.), which tells
Java to search the current directory.

On Unix, use the following command:

CLASSPATH=/usr/local/java/jdk1.0.2/bin:.

Again, note the trailing period, which means 'current directory".  If you
wish to run the Chesapeake TTCP from another directory, you will need to
specify the exact directory where TTCP is installed:

CLASSPATH=c:\java\jdk1.0.2\lib;c:\java\tools\ttcp
or
CLASSPATH=/usr/local/java/jdk1.0.2/bin:/usr/local/java/tools/ttcp


*** GUI operation

To execute the Chesapeake TTCP on Windows95/NT, you need to start a DOS window.
Within the window, change to the Chesapeake TTCP directory and start the
Graphical User Interface with the commands:

c:>cd \java\tools\ttcp
c:>java ttcp

The GUI will appear on the screen with default values set.  Modify the
variables (it is often good to start off your testing with 'Num Buffers' set
to 100) as your test requires, then press the 'Start' button.  When the
Chesapeake TTCP has started, only the 'Stop' and 'Quit' buttons will be
active.  You must stop a running TTCP before you can modify any parameters.

Operation on Unix is very similar.  Use the command 'java ttcp' from within
a shell window to start the GUI.

Note: If you include any arguments to the Chesapeake TTCP on the command
line, the GUI will not start.  See below, "Command-line Operation" for how
to run Chesapeake TTCP from the command line.

*** Command-line operation

In network testing, you often only have remote (e.g. telnet) access to some
of the systems.  To perform testing in this environment, you need to use the
Chesapeake TTCP in command-line mode.  Make sure you have set your
environment variables correctly (the PATH and CLASSPATH variables.)

The command line version is started by including arguments which specify the
direction of the transfer and the parameters to be used for the transfer.
The possible arguments are:

-r	Receive mode
-t	Transmit mode
-n	Number of buffers (default 8192)
-l	Buffer size (default 1024)
-p	TCP Port number (default 5001)

An example of a receiver command that uses the default values is as follows:

java ttcp -r

To start the corresponding transmitter, we need to know the hostname or IP
address of the receiver.  For this example, we'll use the IP Loopback
address of 127.0.0.1:

java ttcp -t 127.0.0.1

Modifying the other variables is done by specifying the parameter to modify
and the value to use.  For example, to modify a receiver to use 4096 byte
bufers and 100 buffers, we would issue the following command:

java ttcp -r -l 4096 -n 100

*** Other reading

To find out more about TTCP, check out the TTCP web pages at the Chesapeake
web site (www.ccci.com).  There you will find two articles about TTCP, one
for the implementation in Cisco routers and the other describing the
Chesapeake TTCP, including both the GUI and command-line interface.
