From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Feb 2004 21:51:16 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040222215116.GK703@holomorphy.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z+pzSjdB7cqptWpS"
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
To: sparclinux@vger.kernel.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 22, 2004 at 01:11:50AM -0800, William Lee Irwin III wrote:
>>> Unfortunately I never saw a test kernel image, so the spamfiltering bit
>>> looks likely.

On Sun, 22 Feb 2004 01:57:55 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Make that "certain":

On Sun, Feb 22, 2004 at 10:03:34AM -0800, David S. Miller wrote:
> I put one up here instead:
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/for_wli/
> It may take a few minutes to propagate, but there'll be this there when it's
> done:
> -rw-r--r--    1 davem    ftpadmin   874502 Feb 22 10:02 System.map-2.6.3
> -rwxr-xr-x    1 davem    ftpadmin  3615392 Feb 22 09:53 vmlinux-263
> Let me know how it goes.

I had to run elftoaout myself to prep the thing for tftpboot; I'm not
sure how likely that is to fail/etc. I did get the following warning:

$ elftoaout vmlinux-263 
PT 0 Entry: Loadable to 0x400000[0x3ba110] from 0x0[0x370d58] align 0x100000
PT 1 Entry: unknown

I'm not sure how to pick apart the a.out stuff to see if it did
something wrong with the STACK bits in the phdr. 2.4 doesn't have
a STACK phdr so I suspect I may be getting hit here, among many
other places.

I ran it on the E3K for this run; I can run it on the U2 too if it's
more interesting.

It hanged early (I can photograph the front LED's and make them
webabble if need be). Bootlog included as a MIME attachment. The
"Button XIR" is me typing in the reset string (less traumatic than
cutting the power via APC MasterSwitch). The way I captured the
output as early as I did before was with this patch:


===== init/main.c 1.122 vs edited =====
--- 1.122/init/main.c	Wed Feb 18 22:54:06 2004
+++ edited/init/main.c	Sat Feb 21 20:26:20 2004
@@ -39,6 +39,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/console.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -389,6 +390,17 @@
  	cpu_idle();
 } 
 
+static void hack_write(struct console *c, const char *s, unsigned n)
+{
+	int k;
+
+	(void)c;
+	for (k = 0; k < n; ++k)
+		prom_putchar(s[k]);
+}
+
+static struct console hack_console = { .write = hack_write };
+
 /*
  *	Activate the first processor.
  */
@@ -403,6 +415,7 @@
  * enable them
  */
 	lock_kernel();
+	register_console(&hack_console);
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();

--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Description: e3k.log.8
Content-Disposition: attachment; filename="e3k.log.8"

Script started on Sun Feb 22 13:01:55 2004
$ screen -x
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing 
<0>Press L1-A to return to the boot prom
Button XIR
Software Power ON
Clock board TOD does not match TOD on any IO board.
serial not found.
serial not found.
Clock board TOD does not match TOD on any IO board.

4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.
{6} ok boot net:dhcp nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
Remapping the kernel... done.
Booting Linux...
Bell in window 10
Button XIR
Software Power ON
[detached]
$ 

Script done on Sun Feb 22 13:04:14 2004

--z+pzSjdB7cqptWpS--
