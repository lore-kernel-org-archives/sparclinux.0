From: Christian Joensson <christian@j-son.org>
Date: Wed, 18 Feb 2004 12:16:54 +0000
Subject: sunhme in 2.4.2{3,4}?
Message-Id: <20040218131654.A25364@fw.j-son.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is on an Ultra1 running 2.4.24 (Aurora SPARC Linux, 1.0 Ansel)

From dmesg we can read:

PROMLIB: Sun IEEE Boot Prom 3.11.1 1997/12/03 15:44
Linux version 2.4.24-0.1sparc (root@u1sparc.j-son.org) (gcc driver version egcs-
2.91.66 19990314/Linux (egcs-1.1.2 release) executing gcc version egcs-2.92.11)
#1 Wed Feb 18 09:30:53 CET 2004 (priority -1)
ARCH: SUN4U-0.9.19, 19 August 2002 on sd(8,2), internal journal

and further on

eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:7c:3b:06
eth0: Auto-Negotiation unsuccessful, trying force link mode
eth0: Link has been forced up using internal transceiver at 10Mb/s, Half Duplex.

Every now and then, the machine hangs due to something with the HAPYY
MEAL failing... 

Is this what's been talked about problems with sunhme, or is this
something unrelated?

TIA,

/ChJ

