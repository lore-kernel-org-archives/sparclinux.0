From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2016 20:12:40 +0000
Subject: E3500 crash on boot in 4.9-rc6+git
Message-Id: <alpine.LRH.2.20.1611232341280.21093@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I (sort of) revived my E3500. TODC batteries are empty but I programmed 
new nvram contents and started it up. Last it ran probably 4.1, 4.2 had 
some blk-mq trouble. Updated to 4.9-rc6+git and got a boot crash.

Will try to narrow it but here is the full dmesg if it rings any bells:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
PROMLIB: Root node compatible: 
Linux version 4.9.0-rc6-00124-gded9b5d (mroos@korvits) (gcc version 4.9.2 (Debian 4.9.2-1) ) #71 SMP Wed Nov 23 20:54:50 EET 2016
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:b6:ee:e2
MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
PROM: Built device tree with 186014 bytes of memory.
Top of RAM: 0xffcf4000, Total RAM: 0xff8c2000
Memory hole size: 4MB
Allocated 16384 bytes for kernel page tables.
Zone ranges:
  Normal   [mem 0x0000000000000000-0x00000000ffcf3fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x00000000ff7ddfff]
  node   0: [mem 0x00000000ffc00000-0x00000000ffcd1fff]
  node   0: [mem 0x00000000ffce2000-0x00000000ffcf3fff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffcf3fff]
On node 0 totalpages: 523361
  Normal zone: 4093 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 523361 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
percpu: Embedded 10 pages/cpu @fffff800ff000000 s38208 r8192 d35520 u1048576
pcpu-alloc: s38208 r8192 d35520 u1048576 alloc=1*4194304
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 519268
Kernel command line: root=/dev/sda2 ro ignore_loglevel
PID hash table entries: 4096 (order: 2, 32768 bytes)
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Sorting __ex_table...
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff80000402000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
CPU: 6 PID: 0 Comm: swapper Not tainted 4.9.0-rc6-00124-gded9b5d #71
task: 0000000000a1ddc0 task.stack: 0000000000a0c000
TSTATE: 0000009980e01600 TPC: 00000000006c1f24 TNPC: 00000000006c1f28 Y: 00000016    Not tainted
TPC: <__list_add+0x4/0xe0>
g0: 000000000129e650 g1: 0000000000aa9f58 g2: 0000000000a574e0 g3: 000000000007e09f
g4: 0000000000a1ddc0 g5: 0000000000000000 g6: 0000000000a0c000 g7: 000000000007e09e
o0: 0000000000515f84 o1: fffff800ff3de000 o2: 000000000001e1c0 o3: 0000000000a0f968
o4: 0000000000000100 o5: 0000000000000200 sp: 0000000000a0f171 ret_pc: 00000000004a7d04
RPC: <trace_hardirqs_off+0x4/0x20>
l0: 000000000129ddb8 l1: 00000000009ad178 l2: 0000000000a32400 l3: 0000000000000001
l4: 0000000000a18338 l5: 0000000000000006 l6: 000000000129e000 l7: 000000000129e1d8
i0: 0000060001fe7ba0 i1: 0000000000aa9b70 i2: 0000000000000000 i3: 0000000000a1ddc0
i4: fffff800ff3de000 i5: 0000000000000000 i6: 0000000000a0f221 i7: 0000000000515ff0
I7: <free_hot_cold_page+0x130/0x1e0>
Call Trace:
 [0000000000515ff0] free_hot_cold_page+0x130/0x1e0
 [0000000000517f04] __free_pages+0x24/0x60
 [0000000000a6ece0] __free_pages_bootmem+0xb0/0xc0
 [0000000000a728f8] free_all_bootmem+0x11c/0x17c
 [0000000000a68794] mem_init+0x20/0xb0
 [0000000000a62818] start_kernel+0x208/0x41c
 [0000000000a640fc] start_early_boot+0x274/0x284
 [00000000008ca18c] tlb_fixup_done+0x4c/0x60
 [0000000000000000]           (null)
Disabling lock debugging due to kernel taint
Caller[0000000000515ff0]: free_hot_cold_page+0x130/0x1e0
Caller[0000000000517f04]: __free_pages+0x24/0x60
Caller[0000000000a6ece0]: __free_pages_bootmem+0xb0/0xc0
Caller[0000000000a728f8]: free_all_bootmem+0x11c/0x17c
Caller[0000000000a68794]: mem_init+0x20/0xb0
Caller[0000000000a62818]: start_kernel+0x208/0x41c
Caller[0000000000a640fc]: start_early_boot+0x274/0x284
Caller[00000000008ca18c]: tlb_fixup_done+0x4c/0x60
Caller[0000000000000000]:           (null)
Instruction DUMP: 900a20ff 
 01000000  9de3bf50 
<d85ea008> 80a30019 
 2268000b  d85e4000 
 11002751  15002751 

Kernel panic - not syncing: Attempted to kill the idle task!
Press Stop-A (L1-A) to return to the boot prom
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

-- 
Meelis Roos (mroos@linux.ee)
