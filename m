From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 02 Jan 2005 18:26:23 +0000
Subject: Boot failures - untrapped exception?
Message-Id: <Pine.LNX.4.61.0501021218460.3200@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

We are occasionally getting reports about boot failures on sparc64. Examples 
are 2.4.26 on Ultra 5 [0] and various kernels on V100 [1]. Typically the 
machine either hangs or returns to OBP prompt after displaying the 
following messages (very early in the boot process):

  Allocated 8 Megs of memory at 0x40000000 for kernel
  Loaded kernel version 2.4.27
  Loading initial ramdisk (896142 bytes at 0xCF808000 phys, 0x40C00000 virt)...
  |
  Remapping the kernel... FP Disabled

AFAICT, the message "Remapping the kernel..." in 2.4.27 kernel comes from 
inherit_prom_mappings() in arch/sparch64/mm/init.c, which is called by 
paging_init(), which in turn is called by setup_arch(). This problem has 
been traditionally blamed on SILO, as sometimes it goes away when SILO is 
downgraded, or even recompiled with older compiler (like gcc-2.95). It 
does not seem to help in all cases though. I was actually unable to find 
any kernel function, which outputs the line "FP Disabled", so I assume 
(for now) that it comes from OBP. This supports a theory that somewhere in 
the execution path of inherit_prom_mappings() a floating-point instruction 
is used, triggering a "Floating Point Disabled" trap. As kernel's own trap 
handling is getting set up later, it gets (mis)handled by OBP instead. 
Major questions are a) where this instruction might be located and b) why 
isn't it triggered every time. I would appreciate any input which would 
help to identify and debug this problem.

[0] http://bugs.debian.org/267428
[1] http://lists.debian.org/debian-sparc/2005/01/msg00000.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
