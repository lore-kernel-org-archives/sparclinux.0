From: "Stephen P. Becker" <geoman@gentoo.org>
Date: Sun, 29 Aug 2004 17:26:36 +0000
Subject: nfsroot w/ smp 2.6.7 on ultra2 bug report
Message-Id: <413211CC.1020207@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have an Ultra 2 with dual 200mhz ultrasparc I processors.  I had been 
trying to run nfsroot with kernel 2.6.7 on the machine, and could not 
get it to work:

IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
       device=eth0, addr2.168.1.7, mask%5.255.255.0, 
gw%5.255.255.255,
      host2.168.1.7, domain=, nis-domain=(none),
      bootserver2.168.1.1, rootserver2.168.1.1, rootpathLooking up port of RPC 100003/2 on 192.168.1.1
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
portmap: server 192.168.1.1 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.1
portmap: server 192.168.1.1 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.1.1 not responding, timed out
Root-NFS: Server returned error -5 while mounting /usr/local/sparc
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "<NULL>" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
  <0>Press Stop-A to return to the boot prom

On a suggestion from Ciaran McCreesh, I recompiled my kernel without SMP 
support, and was able to mount nfsroot with no problems at all.  I also 
successfully compiled and booted a 2.4.27 smp kernel with nfsroot, and 
had no such problems.

Steve Becker
