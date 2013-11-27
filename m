From: Meelis Roos <mroos@linux.ee>
Date: Wed, 27 Nov 2013 17:39:15 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1311271933110.10170@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > > First I compared the configurations of working and nonworking machines
> > > > (there were 2 different machines from the same era with problem), then
> > > > did some conf bisecting and found that CONFIG_SUN_OPENPROMFS causes the
> > > > RED problem in 3.12-rc5 when compiled modular and module loaded. It did
> > > > not happen when it was compiled statically, or modular but module was
> > > > not loaded. Reduced minimalistic configuration that causes this on Ultra
> > > > 5 is attached to this mail.
> 
> Is the problem unique to these 2 machines given this configuration, or is
> the problem reproduceable on other machines using this configuration?

Have not had a convenient way to test because it would need remote 
power cycling (most my sparcs are remote).

> > Another strange symptom is that the problem did not happen when
> > openpromfs is compiled in statically, not loaded as module. When loaded
> > as module, its memory is vmalloc()ed... but that's probably too weak
> > connection to conclude anything.
> 
> What happens with the not-even-compile-tested debug patch below?

I am puzzled by this. I applied it to my slightly changed kernel with a 
lot of kernel debugging options turned on, started getting crashes on 
startup from slab.c during __kmem_cache_create. Reworked the patch, 
still the same. Commented it all out (just vmalloc->kmalloc change that 
worked fine before), still getting it.

Sorting __ex_table...
Memory: 493968K/523456K available (3521K kernel code, 343K rwdata, 1176K rodata, 264K init, 9803K bss, 29488K reserved)
kernel BUG at mm/slab.c:2391!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Kernel bad sw trap 5 [#1]
CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-rc2-00058-g20bafb3-dirty #122
task: 00000000008ac468 ti: 000000000089c000 task.ti: 000000000089c000
TSTATE: 0000004480e01606 TPC: 00000000004f57d4 TNPC: 00000000004f57d8 Y: 00000000    Not tainted
TPC: <__kmem_cache_create+0x374/0x480>
g0: 00000000000000f8 g1: 00000000008bb400 g2: 000000000002780b g3: 00000000008b5120
g4: 00000000008ac468 g5: 0000000000000000 g6: 000000000089c000 g7: 0000000000000000
o0: 0000000000845f08 o1: 0000000000000957 o2: ffffffffffffffe0 o3: 0000000000000000
o4: 0000000000002004 o5: 0000000000000000 sp: 000000000089f301 ret_pc: 00000000004f57cc
RPC: <__kmem_cache_create+0x36c/0x480>
l0: fffff8001e812040 l1: fffff8001e819f80 l2: fffff8001e819fb8 l3: fffff8001e819fd8
l4: 0000000000000001 l5: fffff8001e819fc8 l6: 0000000000845f08 l7: fffff8001e8300a0
i0: fffff8001e831fa0 i1: 0000000080002800 i2: 0000000080000000 i3: 0000000000000034
i4: 0000000000000000 i5: 0000000000002000 i6: 000000000089f3b1 i7: 0000000000907464
I7: <create_boot_cache+0x4c/0x84>
Call Trace:
 [0000000000907464] create_boot_cache+0x4c/0x84
 [00000000009074d0] create_kmalloc_cache+0x34/0x60
 [0000000000907540] create_kmalloc_caches+0x44/0x168
 [0000000000908dfc] kmem_cache_init+0x1d0/0x1e0
 [00000000008fc658] start_kernel+0x18c/0x370
 [0000000000761df4] tlb_fixup_done+0x88/0x94
 [0000000000000000]           (null)
Disabling lock debugging due to kernel taint
Caller[0000000000907464]: create_boot_cache+0x4c/0x84
Caller[00000000009074d0]: create_kmalloc_cache+0x34/0x60
Caller[0000000000907540]: create_kmalloc_caches+0x44/0x168
Caller[0000000000908dfc]: kmem_cache_init+0x1d0/0x1e0
Caller[00000000008fc658]: start_kernel+0x18c/0x370
Caller[0000000000761df4]: tlb_fixup_done+0x88/0x94
Caller[0000000000000000]:           (null)
Instruction DUMP: 92102957  7ffccb35  90122308 <91d02005> 90100018  
4009b371  920f20d0  ba922000  02480006 
Kernel panic - not syncing: Attempted to kill the idle task!
Press Stop-A (L1-A) to return to the boot prom


> 
> --->%---
> Subject: [PATCH] Debug instrumentation of exit_openprom_fs()
> 
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  fs/openpromfs/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index 8c0ceb8..9fc4c86 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -12,12 +12,15 @@
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
>  #include <linux/magic.h>
> +#include <linux/printk.h>
> 
>  #include <asm/openprom.h>
>  #include <asm/oplib.h>
>  #include <asm/prom.h>
>  #include <asm/uaccess.h>
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  static DEFINE_MUTEX(op_mutex);
> 
>  #define OPENPROM_ROOT_INO	0
> @@ -456,6 +459,8 @@ static int __init init_openprom_fs(void)
> 
>  static void __exit exit_openprom_fs(void)
>  {
> +	pr_info("exiting\n");
> +
>  	unregister_filesystem(&openprom_fs_type);
>  	/*
>  	 * Make sure all delayed rcu free inodes are flushed before we
> @@ -463,6 +468,8 @@ static void __exit exit_openprom_fs(void)
>  	 */
>  	rcu_barrier();
>  	kmem_cache_destroy(op_inode_cachep);
> +
> +	pr_info("exited\n");
>  }
> 
>  module_init(init_openprom_fs)
> 

-- 
Meelis Roos (mroos@linux.ee)
