From: Brad Roberts <braddr@puremagic.com>
Date: Mon, 10 Apr 2006 05:40:41 +0000
Subject: niagara kernel boot problems
Message-Id: <Pine.LNX.4.64.0604092227300.5795@bellevue.puremagic.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I just got a t2000 from sun as part of their try/buy program partially due 
to the news about the successful linux bootup.  I've got to admit that I'm 
an extreme newbie to sun hardware and rather than learn my way around 
solaris I want to stick in the warm comfy zone of linux and debian-based 
distributions.

In the process of booting, I'm hitting a problem:

Sun Fire T200, No Keyboard
Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
OpenBoot 4.19.0, 8184 MB memory installed, Serial #68096096.
Ethernet address 0:14:4f:f:10:60, Host ID: 840f1060.

Rebooting with command: boot net
Boot device: /pci@780/pci@0/pci@1/network@0  File and args: 
100 Mbps full duplex  Link up
Requesting Internet Address for 0:14:4f:f:10:60
/
Remapping the kernel... done.
Booting Linux...

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.19.0 2005/10/27 17:24'             
[    0.000000] PROMLIB: Root node compatible: sun4v                                  
[    0.000000] Linux version 2.6.15-20-sparc64 (buildd@artigas) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu3)) #1 Tue Apr 4 17:55:03 UTC 2006                                               
[    0.000000] ARCH: SUN4V                                                           
[    0.000000] Ethernet address: 00:14:4f:0f:10:60                                   
[    0.000000] CPU[0]: Caches D[sz(8192):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(3145728):line_sz(64)]                                                                                
[    0.000000] SUN4V: virtual-devices devhandle[100] 
... snip ...
[   11.107562] TCP bic registered
[   11.202201] NET: Registered protocol family 1
[   11.338121] NET: Registered protocol family 17
[   11.648468] Badness in proc_get_inode at fs/proc/inode.c:157
[   11.821338] Call Trace:
[   11.898036]  [00000000004a1ee0] __lookup_hash+0xe0/0x140
[   12.065575]  [00000000004a5128] open_namei+0x128/0x640
[   12.227346]  [00000000004924c0] filp_open+0x20/0x60
[   12.379717]  [0000000000492658] do_sys_open+0x38/0xe0
[   12.543989]  [0000000000406a14] linux_sparc_syscall32+0x34/0x40
[   12.739641]  [000000000003dd58] 0x3dd58
[   12.859043] SUN4V-DTLB: Error at TPC[4ca2bc], tl -268435400
[   13.024855] SUN4V-DTLB: vaddr[ffffffffffff0000] ctx[0] pte[800007ffffff0743] error[2]
Program terminated

full log here: http://www.puremagic.com/~braddr/t2000/boot-failure.txt

Can anyone shine some light or point me at what I failed to find through 
the usually rather trusty google?  Up to now, I've really only ever delt 
with x86 hardware.

Thanks,
Brad
