From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Tue, 01 Feb 2005 11:17:38 +0000
Subject: No keyboard/networking on ultra2/SMP
Message-Id: <Pine.LNX.4.61.0502011209360.10239@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

Similar problems might have been posted to the list - still I'd like to 
add mine:

The system works fine using 2.4.27/SMP on my 2xUltraSparcI -system. If I 
switch to 2.6.9/2.6.10 w/ SMP no keyboard input is ever accepted and I get

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, restting
eth0: Happy Status 03010000 TX[000003ff:00000101]
eth0: Link is up using internal tranceiver at 100Mb/s, Half Duplex

soon after setting up the network interfaces (using DHCP, thus the card 
works for a few seconds).

If I disable SMP, everything works as expected.

Thanks in advance,
Michael

-- 
------------------------------------------------
Michael Tautschnig

System operator @ Chair Brauer
Technical University of Munich

________________________________________________

