From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 12 Dec 2007 09:22:44 +0000
Subject: BUG in 2.6.23.8 (sun4v)
Message-Id: <475FA864.5070500@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	On a T1000 running debian testing, kernel 2.6.23.8, I have seen this 
morning :

Root gershwin:[/var/log] > ps auwx | grep nfs
root      3760  0.2  0.0      0     0 ?        D    Nov23  79:14 [nfsd]
root     12110  0.0  0.0   2048   800 pts/0    S+   10:19   0:00 grep nfs
nobody   19401  0.0  0.0   3880  1424 ?        SN   06:25   0:00 su 
nobody -s /bin/sh -c /usr/bin/find / -ignore_readdir_race      \( 
-fstype NFS -o -fstype nfs -o -fstype nfs4 -o -fstype afs -o -fstype 
binfmt_misc -o -fstype proc -o -fstype smbfs -o -fstype autofs -o 
-fstype iso9660 -o -fstype ncpfs -o -fstype coda -o -fstype devpts -o 
-fstype ftpfs -o -fstype devfs -o -fstype mfs -o -fstype shfs -o -fstype 
sysfs -o -fstype cifs -o -fstype lustre_lite -o -fstype tmpfs -o -fstype 
usbfs -o -fstype udf -o      -type d -regex 
'\(^/tmp$\)\|\(^/usr/tmp$\)\|\(^/var/tmp$\)\|\(^/afs$\)\|\(^/amd$\)\|\(^/alex$\)\|\(^/var/spool$\)\|\(^/sfs$\)\|\(^/media$\)' 
\) -prune -o -print0
nobody   19402  0.0  0.0   2144  1128 ?        DN   06:25   0:07 
/usr/bin/find / -ignore_readdir_race ( -fstype NFS -o -fstype nfs -o 
-fstype nfs4 -o -fstype afs -o -fstype binfmt_misc -o -fstype proc -o 
-fstype smbfs -o -fstype autofs -o -fstype iso9660 -o -fstype ncpfs -o 
-fstype coda -o -fstype devpts -o -fstype ftpfs -o -fstype devfs -o 
-fstype mfs -o -fstype shfs -o -fstype sysfs -o -fstype cifs -o -fstype 
lustre_lite -o -fstype tmpfs -o -fstype usbfs -o -fstype udf -o -type d 
-regex 
\(^/tmp$\)\|\(^/usr/tmp$\)\|\(^/var/tmp$\)\|\(^/afs$\)\|\(^/amd$\)\|\(^/alex$\)\|\(^/var/spool$\)\|\(^/sfs$\)\|\(^/media$\) 
) -prune -o -print0
Root gershwin:[/var/log] >

and in dmesg:

BUG: soft lockup detected on CPU#6!
Call Trace:
  [000000000046ccc8] update_process_times+0x30/0x80
  [000000000048110c] tick_sched_timer+0x74/0xe0
  [000000000047cf84] hrtimer_interrupt+0x10c/0x1c0
  [0000000000432d04] timer_interrupt+0x8c/0xe0
  [00000000004209d4] tl0_irq14+0x1c/0x20
  [00000000005e6d74] raid1d+0x35c/0x1020
  [00000000005f2f70] md_thread+0x38/0x140
  [0000000000478ce0] kthread+0x48/0x80
  [00000000004273d0] kernel_thread+0x38/0x60
  [0000000000478f80] kthreadd+0x148/0x1c0
BUG: soft lockup detected on CPU#6!
Call Trace:
  [000000000046ccc8] update_process_times+0x30/0x80
  [000000000048110c] tick_sched_timer+0x74/0xe0
  [000000000047cf84] hrtimer_interrupt+0x10c/0x1c0
  [0000000000432d04] timer_interrupt+0x8c/0xe0
  [00000000004209d4] tl0_irq14+0x1c/0x20
  [000000000044313c] dma_4v_map_single+0x64/0x200
  [000000000059b5bc] tg3_alloc_rx_skb+0xc4/0x160
  [00000000005a4fa4] tg3_poll+0x7ec/0xc40
  [00000000006097a0] net_rx_action+0x88/0x160
  [0000000000468218] __do_softirq+0x80/0x100
  [00000000004682fc] do_softirq+0x64/0x80
  [0000000000468468] irq_exit+0x90/0xc0
  [000000000042ed38] handler_irq+0xa0/0xc0
  [00000000004208b4] tl0_irq5+0x1c/0x20
  [00000000005e6d74] raid1d+0x35c/0x1020
  [00000000005f2f70] md_thread+0x38/0x140

	I don't have any other information about this bug (nothing in log 
files). I have seen it since 2.6.23...

	Any idea ?

	JKB
