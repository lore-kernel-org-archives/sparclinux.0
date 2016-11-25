From: Meelis Roos <mroos@linux.ee>
Date: Fri, 25 Nov 2016 20:42:28 +0000
Subject: Bisected: E3500 crash on boot just befoire v4.8
Message-Id: <alpine.LRH.2.20.1611260012320.9292@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I (sort of) revived my E3500. TODC batteries are empty but I programmed 
> new nvram contents and started it up. Last it ran probably 4.1, 4.2 had 
> some blk-mq trouble. Updated to 4.9-rc6+git and got a boot crash.

Finished bisecting. The bug crept in right before 4.8.0. E3500 has 
sparse CPU numbering, maybe this was not considered in the patch?

commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
Author: Atish Patra <atish.patra@oracle.com>
Date:   Thu Sep 15 14:54:40 2016 -0600

    sparc64: Fix cpu_possible_mask if nr_cpus is set
    
    If kernel boot parameter nr_cpus is set, it should define the number
    of CPUs that can ever be available in the system i.e.
    cpu_possible_mask. setup_nr_cpu_ids() overrides the nr_cpu_ids based
    on the cpu_possible_mask during kernel initialization. If
    cpu_possible_mask is not set based on the nr_cpus value, earlier part
    of the kernel would be initialized using nr_cpus value leading to a
    kernel crash.
    
    Set cpu_possible_mask based on nr_cpus value. Thus setup_nr_cpu_ids()
    becomes redundant and does not corrupt nr_cpu_ids value.
    
    Signed-off-by: Atish Patra <atish.patra@oracle.com>
    Reviewed-by: Bob Picco <bob.picco@oracle.com>
    Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 cd7f09841a45d3187cebeafb48b5fe22c00688a7 5c3d6e50160bd00108ee95f40cdf83264e9f5139 M      arch


> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff80000402000
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(0): Oops [#1]
> CPU: 6 PID: 0 Comm: swapper Not tainted 4.9.0-rc6-00124-gded9b5d #71
> task: 0000000000a1ddc0 task.stack: 0000000000a0c000
> TSTATE: 0000009980e01600 TPC: 00000000006c1f24 TNPC: 00000000006c1f28 Y: 00000016    Not tainted
> TPC: <__list_add+0x4/0xe0>
> g0: 000000000129e650 g1: 0000000000aa9f58 g2: 0000000000a574e0 g3: 000000000007e09f
> g4: 0000000000a1ddc0 g5: 0000000000000000 g6: 0000000000a0c000 g7: 000000000007e09e
> o0: 0000000000515f84 o1: fffff800ff3de000 o2: 000000000001e1c0 o3: 0000000000a0f968
> o4: 0000000000000100 o5: 0000000000000200 sp: 0000000000a0f171 ret_pc: 00000000004a7d04
> RPC: <trace_hardirqs_off+0x4/0x20>
> l0: 000000000129ddb8 l1: 00000000009ad178 l2: 0000000000a32400 l3: 0000000000000001
> l4: 0000000000a18338 l5: 0000000000000006 l6: 000000000129e000 l7: 000000000129e1d8
> i0: 0000060001fe7ba0 i1: 0000000000aa9b70 i2: 0000000000000000 i3: 0000000000a1ddc0
> i4: fffff800ff3de000 i5: 0000000000000000 i6: 0000000000a0f221 i7: 0000000000515ff0
> I7: <free_hot_cold_page+0x130/0x1e0>
> Call Trace:
>  [0000000000515ff0] free_hot_cold_page+0x130/0x1e0
>  [0000000000517f04] __free_pages+0x24/0x60
>  [0000000000a6ece0] __free_pages_bootmem+0xb0/0xc0
>  [0000000000a728f8] free_all_bootmem+0x11c/0x17c
>  [0000000000a68794] mem_init+0x20/0xb0
>  [0000000000a62818] start_kernel+0x208/0x41c
>  [0000000000a640fc] start_early_boot+0x274/0x284
>  [00000000008ca18c] tlb_fixup_done+0x4c/0x60
>  [0000000000000000]           (null)
> Disabling lock debugging due to kernel taint
> Caller[0000000000515ff0]: free_hot_cold_page+0x130/0x1e0
> Caller[0000000000517f04]: __free_pages+0x24/0x60
> Caller[0000000000a6ece0]: __free_pages_bootmem+0xb0/0xc0
> Caller[0000000000a728f8]: free_all_bootmem+0x11c/0x17c
> Caller[0000000000a68794]: mem_init+0x20/0xb0
> Caller[0000000000a62818]: start_kernel+0x208/0x41c
> Caller[0000000000a640fc]: start_early_boot+0x274/0x284
> Caller[00000000008ca18c]: tlb_fixup_done+0x4c/0x60
> Caller[0000000000000000]:           (null)
> Instruction DUMP: 900a20ff 
>  01000000  9de3bf50 
> <d85ea008> 80a30019 
>  2268000b  d85e4000 
>  11002751  15002751 
> 
> Kernel panic - not syncing: Attempted to kill the idle task!
> Press Stop-A (L1-A) to return to the boot prom
> ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> 
> 

-- 
Meelis Roos (mroos@linux.ee)
