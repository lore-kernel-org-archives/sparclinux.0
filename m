From: Uli Luckas <luckas@musoft.de>
Date: Wed, 02 Jun 2004 06:18:13 +0000
Subject: sun4c driver/dma problems
Message-Id: <200406020818.13705.luckas@musoft.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, 
there seem to be all sorts of driver problems with the 2.6 Kernels and my 
Sparc Clone "GoldStar SPARC Workstation GWS-20".
The box is a sun4c architecture with integrated SunLANCE networking (external 
tranciver), cg3 framebuffer and 1 ESP SCSI controller.
It is operated as a diskless workstation and works with 2.2 series kernels 
(2.2.26).

As the idprom's battery is empty I boot it with the following commands:

n			 	# new command mode
f idprom@ 1 xor f mkp		# reset idprom
8 0 20 76 4c 78 c0ffee mkpl	# set mac addr/host id
boot net - ip=dhcp		# boot linux

Framebuffer
=====While 2.2 works nicely with the framebuffer console, the first twist was a 
lockup at boot time, worked around by using the prom console.

Sun LANCE
====Now I am stuck at IP auto configuration with "Sending DHCP requests ...... 
timed out!"
While DHCP requests are being sent, neither does my switch show any activity, 
nor does tcpdump on the server report any packets being received.
The card is detected properly though "sunlance.c:v2.02.... eth0: LANCE 
08:00:20:76:4c.78"

When I instead configure a fixed IP:
boot net - ip.0.0.5:10.0.0.3:10.0.0.3:255.255.255.0::: 
nfsroot.0.0.3:/data/export/euler/root
The machine get's stuck mounting the nfs-root:
Looking up port or RPC 100003/2 on 10.0.0.3
portmap: server 10.0.0.3 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port or RPC 100005/1 on 10.0.0.3
NETDEV WATCHDOG: eth0: transmit timed out
eth0 transmit timed out, status ff3c, reset

Again, there is no activity, what so ever, on the wire (switch/tcpdump)

DMA
=All problems (see below) could of course be linked to this boot message?
dma0 unknown dma version 70000000

ESP SCSI
====
Cannot find dvma for ESP0's SCSI
ESP: Total of 1 ESP hosts found, 0 actually in use.

This all happens either with a native, 2.95 compiled kernel, as with a 3.3.2 
cross x86 compiled kernel.

Any help would be appreciated.

Thanks
Uli
