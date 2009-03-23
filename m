From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Mon, 23 Mar 2009 13:00:23 +0000
Subject: Strange network promiscuous mode...
Message-Id: <49C787E7.9060700@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have build a 2.6.28.7 kernel on sparc64 (libc6 2.9). On all my 
sparc64 (U60 with 3Com and HME NIC's, U1, U420 with HME), tcpdump 
doesn't return any information (but it can count packets !) :

Root rayleigh:[~] > tcpdump -i eth1
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
^C
0 packets captured
635 packets received by filter
0 packets dropped by kernel

Root rayleigh:[/proc/net] > cat dev
Inter-|   Receive                                                |  Transmit
  face |bytes    packets errs drop fifo frame compressed multicast|bytes 
    packets errs drop fifo colls carrier compressed
     lo:759580471  897007    0    0    0     0          0         0 
759580471  897007    0    0    0     0       0          0
   eth0:2081060383 3955569    0    0    0     0          0         0 
4222746354 4419280    0    0    0     0       0          0
   eth1:6655662953 5877440    0    0    0     0          0         0 
1002520280 3856332    0    0    0     0       0          0
   eth2:27035148  352686    0    0    1     0          0         0 
658938822  545289    0    0    0     0       0          0
Root rayleigh:[/proc/net] >

	With the same configuration (kernel and libc), I cannot reproduce this 
bug on i386 or amd64. With 2.6.27/sparc64, tcpdump and others worked fine.

	Problem : all programs that try to catch packets in promiscuous mode do 
not work anymore. Is there any issue ?

	Regards,

	JKB
