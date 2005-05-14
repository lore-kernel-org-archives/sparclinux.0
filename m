From: Eugene San <eugenesan@gmail.com>
Date: Sat, 14 May 2005 19:56:46 +0000
Subject: Davicom 9102AF (dmfe) / Alladin V IDE(ali15xx) on sparc64(v100/Netra-x)
Message-Id: <428665D3.4040005@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There is Problem with Davicom91xx Ethernet NIC on 
sparc64(v100/Netra-x).  That problem is VERY old and well known (google 
::dmfe+sparc).
The problem is that specific driver (dmfe)  can be loaded but once used 
coses errors on PCI/sabre and at the end coses Kernel Panic.
Some people advice using (tulip) which loads but fails to work normally: 
it works at ~10Mbps in 10BaseT4 mode while all other modes brings
huge amount of carrier/TX errors and VERY low performance (usually less 
then 50Kbps) and after some time at mid/high load driver fails
with some kind of TX errors.
Another problem is with DMA on Alladin V which used on those machines.
Usually kernel unable to boot if started without ide=nodma. If DMA 
set-on  after boot is often coses data loses.

Both problems well known for a long time but somehow not treated till now.
The problems exists in all 2.4.x and 1.6.x kernels ( all versions in 
that range tested by me :-( )

I wonder if there anything that can be done to make those sparc64 
machines usable with linux.

Thanks ahead.

