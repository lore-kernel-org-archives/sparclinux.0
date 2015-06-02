From: Meelis Roos <mroos@linux.ee>
Date: Tue, 02 Jun 2015 16:50:19 +0000
Subject: netboot failure with current kernels?
Message-Id: <alpine.LRH.2.11.1506021937230.9956@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I tried to install Debian on my E280R. Netboot is the most natural way 
for remote install so I tried that. Current Debian installer fails to 
load:

{0} ok boot net
Boot device: /pci@8,700000/network@5,1:  File and args: 
Timeout waiting for ARP/RARP packet
4000 \
     ERROR: /packages/obp-tftp: Last Trap: Fast Data Access MMU Miss


Boot load failed

Is this some known problem with TFTP booting that Debian needs to fix, 
or something new? Size of the boot.img file is 12988928 bytes, OBP 
version 4.16.4 2004/12/18.

-- 
Meelis Roos (mroos@linux.ee)
