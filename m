From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 20 Dec 2011 23:00:40 +0000
Subject: "BUG: Bad page map in process Xorg" with 3.1 kernel
Message-Id: <20111220230040.GA4192@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Today I've tried running Xorg on my SunBlade 1000 with a rather old 
ATI Mach64 graphics card. When I launch Xorg, messages like these get 
logged a few times:

[  595.437513] BUG: Bad page map in process Xorg  pte:800007fe027fef8a pmd:000f6904
[  595.437528] addr:00000000f75b6000 vm_flags:000844bb anon_vma:          (null) mapping:fffff8007da94f00 index:3ff013ff
[  595.437543] vma->vm_ops->fault: bin_fault+0x8/0x5c
[  595.437553] vma->vm_file->f_op->mmap: mmap+0x8/0xe0
[  595.437559] Call Trace:
[  595.437571]  [00000000004f0c74] vm_normal_page+0x80/0x90
[  595.437581]  [00000000004f1b3c] unmap_vmas+0x218/0x680
[  595.437592]  [00000000004f5a84] unmap_region+0x6c/0xcc
[  595.437603]  [00000000004f6900] do_munmap+0x268/0x2d4
[  595.437613]  [00000000004f6ad8] SyS_munmap+0x24/0x40
[  595.437625]  [0000000000406194] linux_sparc_syscall32+0x34/0x40
[  596.716253] BUG: Bad page map in process Xorg  pte:800007fe027fef8a pmd:000f6520
[  596.803924] addr:00000000f777a000 vm_flags:000844bb anon_vma:          (null) mapping:fffff8007da94f00 index:3ff013ff
[  596.931006] vma->vm_ops->fault: bin_fault+0x8/0x5c
[  596.931020] vma->vm_file->f_op->mmap: mmap+0x8/0xe0
[  596.931027] Call Trace:
[  596.931041]  [00000000004f0c74] vm_normal_page+0x80/0x90
[  596.931053]  [00000000004f1b3c] unmap_vmas+0x218/0x680
[  596.931065]  [00000000004f5a84] unmap_region+0x6c/0xcc
[  596.931077]  [00000000004f6900] do_munmap+0x268/0x2d4
[  596.931087]  [00000000004f6ad8] SyS_munmap+0x24/0x40
[  596.931103]  [0000000000406194] linux_sparc_syscall32+0x34/0x40

This is with kernel

jurij@debian:~$ uname -a
Linux debian 3.1.0-1-sparc64-smp #1 SMP Sun Dec 11 22:45:09 UTC 2011 sparc64 GNU/Linux

I'm also not getting any output on the monitor, even though Xorg 
appears to start up without any errors in the log, last lines there: 

[    46.160] (II) MACH64: Driver for ATI Mach64 chipsets
[    46.160] (II) SUNFFB: driver for Creator, Creator 3D and Elite 3D
[    46.160] (II) FBDEV: driver for framebuffer: fbdev
[    46.160] (++) using VT number 7

I did confirm that the card is functional by sticking it in a Linux 
PC.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
