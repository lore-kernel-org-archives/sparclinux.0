From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 20 Apr 2007 11:52:35 +0000
Subject: Build Warning (Linux-2.6.20.7)
Message-Id: <Pine.LNX.4.61.0704201246080.15999@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have a number of build warning. Can any one tell me what issues (if 
any) these may cause?

In the case of the seccond set, is there a gcc patch or flag that is 
needed to get rid of these or are they just depmod making nonsense of the 
cross compiled code.

Regards
 	Mark Fortescue

Build Log Extracts:
------------------------------------------------------------------
....


   /bin/sh /L64/src/linux-2.6/linux-2.6.20.7-p01/scripts/mksysmap  System.map
echo '  /bin/sh /L64/src/linux-2.6/linux-2.6.20.7-p01/scripts/mksysmap  .tmp_System.map' && /bin/sh /L64/src/linux-2.6/linux-2.6.20.7-p01/scripts/mksysmap .tmp_vmlinux3 .tmp_System.map
   /bin/sh /L64/src/linux-2.6/linux-2.6.20.7-p01/scripts/mksysmap  .tmp_System.map
cmp -s System.map .tmp_System.map || (echo Inconsistent kallsyms data; echo Try setting CONFIG_KALLSYMS_EXTRA_PASS; rm .tmp_kallsyms* ; /bin/false )
make -f /L64/src/linux-2.6/linux-2.6.20.7-p01/scripts/Makefile.modpost vmlinux
   scripts/mod/modpost -m -a -o /array/4/build/build-linux/Module.symvers    vmlinux 
WARNING: vmlinux - Section mismatch: reference to .init.text:no_sun4u_here from .text between 'current_pc' (at offset 0x9040) and 'already_mapped'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9280) and 'init_thread_union'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9284) and 'init_thread_union'
WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_ksoftirqd from .text between 'init' (at offset 0xc040) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_softlockup_task from .text between 'init' (at offset 0xc048) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sched_init_smp from .text between 'init' (at offset 0xc050) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:usermodehelper_init from .text between 'init' (at offset 0xc060) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:driver_init from .text between 'init' (at offset 0xc068) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:sysctl_init from .text between 'init' (at offset 0xc070) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc088) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0e8) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc1a8) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.text:prepare_namespace from .text between 'init' (at offset 0xc1e8) and 'rest_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 0x6d690) and 's_start'
WARNING: vmlinux - Section mismatch: reference to .init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 0x6d694) and 's_start'
WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unitable from .text between 'promcon_init_unimap' (at offset 0x10683c) and 'promcon_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unitable from .text between 'promcon_init_unimap' (at offset 0x106844) and 'promcon_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unicount from .text between 'promcon_init_unimap' (at offset 0x10684c) and 'promcon_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unicount from .text between 'promcon_init_unimap' (at offset 0x106854) and 'promcon_init'
WARNING: vmlinux - Section mismatch: reference to .init.data:logo_linux_clut224 from .text between 'fb_find_logo' (at offset 0x10ee88) and 'cfb_fillrect'
WARNING: vmlinux - Section mismatch: reference to .init.data:logo_linux_clut224 from .text between 'fb_find_logo' (at offset 0x10ee90) and 'cfb_fillrect'
WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_regvals from .text between 'cg3_probe' (at offset 0x1107f0) and 'sbusfb_mmap_helper'
WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_regvals from .text between 'cg3_probe' (at offset 0x1107f4) and 'sbusfb_mmap_helper'
WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_dacvals from .text between 'cg3_probe' (at offset 0x11081c) and 'sbusfb_mmap_helper'
WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_dacvals from .text between 'cg3_probe' (at offset 0x110824) and 'sbusfb_mmap_helper'

.....

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map -b /L64/sparc/tree/sparc-linux/sys-root -r 2.6.20.7-p01; fi
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/sparc/snd-sun-amd7930.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/sparc/snd-sun-amd7930.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-timer.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-timer.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-timer.ko needs unknown symbol rem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-pcm.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-pcm.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-pcm.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/snd-page-alloc.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/snd-seq.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/snd-seq.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/snd-seq.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/snd-seq.ko needs unknown symbol rem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/snd-seq.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/oss/snd-seq-oss.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/oss/snd-seq-oss.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/oss/snd-seq-oss.ko needs unknown symbol rem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/seq/oss/snd-seq-oss.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/oss/snd-pcm-oss.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/oss/snd-pcm-oss.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/oss/snd-pcm-oss.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/oss/snd-mixer-oss.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/sound/core/oss/snd-mixer-oss.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/net/packet/af_packet.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/net/packet/af_packet.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/net/packet/af_packet.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/net/ipv4/inet_diag.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/net/ipv4/inet_diag.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/jbd/jbd.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/jbd/jbd.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/ext3/ext3.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/ext3/ext3.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/ext3/ext3.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/ext3/ext3.ko needs unknown symbol rem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/fs/ext3/ext3.ko needs unknown symbol umul
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/scsi/scsi_tgt.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/scsi/scsi_tgt.ko needs unknown symbol urem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/parport/parport.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/char/ppdev.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/char/ppdev.ko needs unknown symbol rem
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/char/lp.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/drivers/char/lp.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/block/deadline-iosched.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/block/cfq-iosched.ko needs unknown symbol udiv
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/block/cfq-iosched.ko needs unknown symbol div
WARNING: /L64/sparc/tree/sparc-linux/sys-root/lib/modules/2.6.20.7-p01/kernel/block/cfq-iosched.ko needs unknown symbol umul
PT 0 Entry: Loadable to 0xf0000000[0x2c2eb4] from 0x0[0x2a0140] align 0x10000
PT 1 Entry: OS specific:- GNU: Indicates stack executability
Linux build complete.

