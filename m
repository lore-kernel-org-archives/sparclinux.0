From: James Clarke <jrtc27@jrtc27.com>
Date: Tue, 25 Oct 2016 13:15:26 +0000
Subject: NMI watchdog: BUG: soft lockup
Message-Id: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hi,
We've been having regular soft lockups on our servers (various different kinds
of hardware); on one in particular which sees heavy load, this can happen every
24h. When it happens, the whole machine grinds to a halt, and it needs to be
hard rebooted. The recurring stack trace given on the console for the stuck
kworker is:

[5717580.933396]  [0000000000498edc] dump_cpu_task+0x3c/0x60
[5717580.933407]  [0000000000567034] rcu_dump_cpu_stacks+0xbc/0xe8
[5717580.933418]  [00000000004d1410] rcu_check_callbacks+0x850/0x9c0
[5717580.933427]  [00000000004d73c4] update_process_times+0x24/0x60
[5717580.933437]  [00000000004e6640] tick_sched_handle.isra.4+0x20/0x80
[5717580.933444]  [00000000004e66d0] tick_sched_timer+0x30/0x80
[5717580.933450]  [00000000004d7fcc] __hrtimer_run_queues+0xcc/0x300
[5717580.933458]  [00000000004d8924] hrtimer_interrupt+0x84/0x1a0
[5717580.933467]  [00000000009935a0] timer_interrupt+0x80/0xe0
[5717580.933475]  [00000000004209d4] tl0_irq14+0x14/0x20
[5717580.933483]  [0000000000456208] flush_tsb_kernel_range+0x68/0xa0
[5717580.933491]  [00000000004587bc] flush_tlb_kernel_range+0x5c/0xc0
[5717580.933499]  [00000000005b0528] __purge_vmap_area_lazy+0x288/0x300
[5717580.933506]  [00000000005b076c] free_vmap_area_noflush+0x6c/0x80
[5717580.933513]  [00000000005b2420] remove_vm_area+0x60/0x80
[5717580.933519]  [00000000005b2464] __vunmap+0x24/0x100

I built a custom kernel with a single extra printk at the start of
flush_tsb_kernel_range which prints its arguments. I then had to wait for it to
be hit, and when it was, I got the following:

[5717559.949396] TSB: DEBUG flush_tsb_kernel_range start=0000000010006000 end=00000000f0000000 PAGE_SIZE=2000
[5717560.062663] TSB: DEBUG flush_tsb_kernel_range start=0000000100000000 end=0005ffffa2000000 PAGE_SIZE=2000

The first call to flush_tsb_kernel_range corresponds to [start,
LOW_OBP_ADDRESS) for kernel modules, and the second one to [HIGH_OBP_ADDRESS,
end), since start and end straddle the OBP region, and thus it took that branch
in flush_tlb_kernel_range. Given the fact that flush_tsb_kernel_range steps
through every possible page address in the range, this is not going to
terminate in a reasonable amount of time (1 million iterations per second would
give just over 2 days of execution time…). Note that end *is* within
[VMALLOC_START, VMALLOC_END), despite the comment in pgtable_64.h suggesting
VMALLOC_END is 0x200000000:

[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0006000000000000]

I made the change given below, which exploits the fact that if start and end
are sufficiently aligned, you can walk through the TSB and check each entry,
since the lower bits in the virtual addresses referenced by the tags don't
matter. Since there are 512 pages to a 2^22-byte block, there can be at most
1023 iterations of __flush_tsb_kernel_range_short's loop during the entire
execution of flush_tsb_kernel_range.

However, that’s only half the problem. flush_tlb_kernel_range still calls
do_flush_tlb_kernel_range, which is now reached and itself loops over every
address (in ultra.S's __(hypervisor_)flush_tlb_kernel_range). Is there a way to
make this fast as well? Here's what I get running with my patch:

[5796396.351352] TSB[insmod:53414]: DEBUG flush_tsb_kernel_range start=0000000010006000 end=00000000f0000000 PAGE_SIZE=2000
[5796396.351369] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_short start=0000000010006000 end=0000000010400000 PAGE_SIZE=2000
[5796396.351386] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_block start=0000000010400000 end=00000000f0000000 PAGE_SIZE=2000
[5796396.351407] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_short start=00000000f0000000 end=00000000f0000000 PAGE_SIZE=2000
[5796396.464227] TSB[insmod:53414]: DEBUG flush_tsb_kernel_range start=0000000100000000 end=0005ffffee000000 PAGE_SIZE=2000
[5796396.464258] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_short start=0000000100000000 end=0000000100000000 PAGE_SIZE=2000
[5796396.464280] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_block start=0000000100000000 end=0005ffffee000000 PAGE_SIZE=2000
[5796396.464311] TSB[insmod:53414]: DEBUG __flush_tsb_kernel_range_short start=0005ffffee000000 end=0005ffffee000000 PAGE_SIZE=2000
[5796396.464328] INIT[insmod:53414]: DEBUG flush_tlb_kernel_range about to call long do_flush_tlb_kernel_range...
[5796421.014160] NMI watchdog: BUG: soft lockup - CPU#110 stuck for 22s! [insmod:53414]
[5796421.014187] Modules linked in: vmap_lazy_nr2(O+) tun xt_tcpudp xt_multiport xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack n2_rng flash camellia_sparc64 des_sparc64 des_generic rng_core md5_sparc64 sha512_sparc64 sha256_sparc64 sha1_sparc64 ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto ecb mbcache btrfs crc32c_generic xor zlib_deflate raid6_pq crc32c_sparc64 aes_sparc64 sunvnet sunvdc [last unloaded: vmap_lazy_nr2]
[5796421.014418] CPU: 110 PID: 53414 Comm: insmod Tainted: G      D    O    4.8.0-rc8-sparc64-smp #1 Debian 4.8~rc8-1~exp1+sparc64.2
[5796421.014447] task: fff800178757a4a0 task.stack: fff80014a58b4000
[5796421.014465] TSTATE: 0000009111001607 TPC: 00000000004553c8 TNPC: 00000000004553cc Y: 00000000    Tainted: G      D    O   
[5796421.014498] TPC: <__flush_tlb_kernel_range+0x28/0x40>
[5796421.014515] g0: 0000000000000000 g1: 0000000100000000 g2: 0005ff40b9c10000 g3: 0000000000002000
[5796421.014540] g4: fff800178757a4a0 g5: fff800207cd86000 g6: fff80014a58b4000 g7: fff8000000000000
[5796421.014566] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000000000003 o3: 0000000000b11838
[5796421.014591] o4: 000000000000006e o5: 000000000000007f sp: fff80014a58b6f31 ret_pc: 000000000043fb50
[5796421.014620] RPC: <smp_flush_tlb_kernel_range+0x50/0x60>
[5796421.014637] l0: 0000000000000000 l1: fff800008042fe28 l2: fff800201b5acf00 l3: 0000000000000000
[5796421.014662] l4: fff800207d9d2d38 l5: 0006000031c068b0 l6: 0000000000000000 l7: fff8000100124000
[5796421.014688] i0: 0000000100000000 i1: 0005ffffee000000 i2: 000000000000d0a6 i3: 0000000100000000
[5796421.014713] i4: 0000000017fffffb i5: 0000000017fffffb i6: fff80014a58b6fe1 i7: 00000000004589a0
[5796421.014741] I7: <flush_tlb_kernel_range+0xc0/0x100>
[5796421.014756] Call Trace:
[5796421.014772]  [00000000004589a0] flush_tlb_kernel_range+0xc0/0x100
[5796421.014792]  [00000000005b06e8] __purge_vmap_area_lazy+0x288/0x300
[5796421.014810]  [00000000005b092c] free_vmap_area_noflush+0x6c/0x80
[5796421.014828]  [00000000005b25e0] remove_vm_area+0x60/0x80
[5796421.014846]  [00000000005b2624] __vunmap+0x24/0x100
[5796421.014863]  [00000000005b27a0] vfree+0x40/0xa0
[5796421.014881]  [00000000004f1d2c] load_module+0x214c/0x2700
[5796421.014898]  [00000000004f2520] SyS_finit_module+0xc0/0x100
[5796421.014918]  [00000000004061f4] linux_sparc_syscall+0x34/0x44

NOTE: vmap_lazy_nr2 is a tiny kernel module I wrote which just printk’s
vmap_lazy_nr and lazy_max_pages(), so while it appears in this particular
backtrace, it is irrelevant, other than the fact that insmod needed to free
some memory and ended up triggering a full flush. This module is also the only
cause of the kernel being tainted.

Of course, presumably the allocations aren’t evenly spread throughout this huge
range and are instead clustered (around HIGH_OBP_ADDRESS and VMALLOC_END)? In
which case, perhaps we could instead issue separate flushes for these two
clusters?

James

Index: b/arch/sparc/mm/init_64.c
===================================================================
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2936,7 +2936,11 @@ void flush_tlb_kernel_range(unsigned lon
 		}
 		if (end > HI_OBP_ADDRESS) {
 			flush_tsb_kernel_range(HI_OBP_ADDRESS, end);
+			printk(KERN_ERR "INIT[%s:%d]: DEBUG flush_tlb_kernel_range about to call long do_flush_tlb_kernel_range...\n",
+			       current->comm, current->pid);
 			do_flush_tlb_kernel_range(HI_OBP_ADDRESS, end);
+			printk(KERN_ERR "INIT[%s:%d]: DEBUG flush_tlb_kernel_range ended call to long do_flush_tlb_kernel_range!\n",
+			       current->comm, current->pid);
 		}
 	} else {
 		flush_tsb_kernel_range(start, end);
Index: b/arch/sparc/mm/tsb.c
===================================================================
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -14,6 +14,9 @@
 #include <asm/tlb.h>
 #include <asm/oplib.h>
 
+#define _ALIGN_UP(addr, size)   __ALIGN_KERNEL(addr, size)
+#define _ALIGN_DOWN(addr, size) ((addr)&(~((typeof(addr))(size)-1)))
+
 extern struct tsb swapper_tsb[KERNEL_TSB_NENTRIES];
 
 static inline unsigned long tsb_hash(unsigned long vaddr, unsigned long hash_shift, unsigned long nentries)
@@ -32,10 +35,13 @@ static inline int tag_compare(unsigned l
  * Only the TLB flush needs that treatment.
  */
 
-void flush_tsb_kernel_range(unsigned long start, unsigned long end)
+static void __flush_tsb_kernel_range_short(unsigned long start, unsigned long end)
 {
 	unsigned long v;
 
+	printk(KERN_ERR "TSB[%s:%d]: DEBUG __flush_tsb_kernel_range_short start=%016lx end=%016lx PAGE_SIZE=%lx\n",
+	       current->comm, current->pid, start, end, (unsigned long) PAGE_SIZE);
+
 	for (v = start; v < end; v += PAGE_SIZE) {
 		unsigned long hash = tsb_hash(v, PAGE_SHIFT,
 					      KERNEL_TSB_NENTRIES);
@@ -46,6 +52,42 @@ void flush_tsb_kernel_range(unsigned lon
 	}
 }
 
+static void __flush_tsb_kernel_range_block(unsigned long start, unsigned long end)
+{
+	unsigned long i;
+
+	printk(KERN_ERR "TSB[%s:%d]: DEBUG __flush_tsb_kernel_range_block start=%016lx end=%016lx PAGE_SIZE=%lx\n",
+	       current->comm, current->pid, start, end, (unsigned long) PAGE_SIZE);
+
+	for (i = 0; i < KERNEL_TSB_NENTRIES; i++) {
+		struct tsb *ent = &swapper_tsb[i];
+		unsigned long vaddr_block = (ent->tag << 22);
+		if (start <= vaddr_block &&
+		    vaddr_block < end &&
+		    tag_compare(ent->tag, vaddr_block))
+			ent->tag = (1UL << TSB_TAG_INVALID_BIT);
+	}
+}
+
+void flush_tsb_kernel_range(unsigned long start, unsigned long end)
+{
+	unsigned long start_block, end_block;
+
+	printk(KERN_ERR "TSB[%s:%d]: DEBUG flush_tsb_kernel_range start=%016lx end=%016lx PAGE_SIZE=%lx\n",
+	       current->comm, current->pid, start, end, (unsigned long) PAGE_SIZE);
+
+	start_block = _ALIGN_UP(start, 1 << 22);
+	end_block = _ALIGN_DOWN(end, 1 << 22);
+
+	if (start_block < end_block) {
+		__flush_tsb_kernel_range_short(start, start_block);
+		__flush_tsb_kernel_range_block(start_block, end_block);
+		__flush_tsb_kernel_range_short(end_block, end);
+	} else {
+		__flush_tsb_kernel_range_short(start, end);
+	}
+}
+
 static void __flush_tsb_one_entry(unsigned long tsb, unsigned long v,
 				  unsigned long hash_shift,
 				  unsigned long nentries)

