From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 18 May 2020 23:08:40 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200518230840.GN23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[l-k and csky folks trimmed from Cc]
On Mon, May 18, 2020 at 08:58:45PM +0100, Mark Cave-Ayland wrote:

> Well it certainly looks like there's an IRQ going missing somewhere, but glad to hear
> the virtio-blk-pci is working much better for you. Presumably the virtio-net-pci NIC
> also works?

Will check.

> I've had one other report of a cmd646 hang on Linux several years ago and that was on
> some pretty high end hardware; however when tracing was enabled everything worked as
> it should. Despite my best attempts I can't seem to reproduce it here on my normal i7
> laptop which is quite frustrating.

FWIW, googling around turns up at least
	http://mail-index.netbsd.org/port-sparc64/2019/03/03/msg002831.html
and
	http://gnats.netbsd.org/54035

> Before bcf9e2c2f2 the on-board NIC (sunhme) and cmd646 were wired to sabre's PCI IRQ
> lines directly onto a single PCI bus, and after that commit they were rewired via
> simba PCI bridges to legacy OBIO IRQs since some OSs like NetBSD hard-coded the
> legacy IRQ numbers for on-board devices. I'm not sure whether this is relevant to the
> kernel or not, or perhaps there is some magic register somewhere missing from
> emulation that should be helping here.
> 
> One thing to check is whether you see any network hangs using the sunhme NIC since
> that is wired in exactly the same way as cmd646. That should help determine whether
> it's related to the IRQs routing via the simba PCI bridge or just the cmd646 device.

Same test, only this time it happened after downloading just 3 files:

Get: 1 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl-modules-5.30 all 5.30.2-1 [2,806 kB]
Get: 2 http://ftp.ports.debian.org/debian-ports sid/main sparc64 libperl5.30 sparc64 5.30.2-1 [3,388 kB]
Get: 3 http://ftp.ports.debian.org/debian-ports sid/main sparc64 perl sparc64 5.30.2-1 [290 kB]
[  429.539542] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[  429.543010] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[  462.181704] ata1: lost interrupt (Status 0x50)
[  462.183233] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  462.184116] ata1.00: failed command: WRITE DMA EXT
[  462.184886] ata1.00: cmd 35/00:38:0c:1d:0f/00:02:00:00:00/e0 tag 0 dma 290816 out
[  462.184886]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[  462.186223] ata1.00: status: { DRDY }
[  462.186953] ata1: soft resetting link
[  462.347419] ata1.00: configured for UDMA/33
[  462.349154] ata1: EH complete
[  464.228913] ata2: lost interrupt (Status 0x58)
[  469.592953] ata2.00: qc timeout (cmd 0xa0)
[  469.594068] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  474.968914] ata2.00: qc timeout (cmd 0xa0)
[  474.969988] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  474.971523] ata2.00: limiting speed to UDMA/33:PIO3
[  480.344855] ata2.00: qc timeout (cmd 0xa0)
[  480.345249] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  480.345715] ata2.00: disabled

and from that point on - as with e1000+cmd646 setup...  wait, no - after a while there's

[  721.496809] ------------[ cut here ]------------
[  721.497403] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:442 dev_watchdog+0x2b8/0x2e0
[  721.498148] NETDEV WATCHDOG: enp2s1 (hme): transmit queue 0 timed out
[  721.498752] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E) sd_mod(E) t10_pi(E) crc_t10dif(E) sr_mod(E) cdrom(E) crct10dif_generic(E) crct10dif_common(E) virtio_blk(E) ata_generic(E) pata_cmd64x(E) libata(E) scsi_mod(E) virtio_pci(E) virtio_ring(E) virtio(E) sunhme(E)
[  721.501214] CPU: 0 PID: 0 Comm: swapper Tainted: G            E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[  721.501939] Call Trace:
[  721.502346]  [0000000000468028] __warn+0xc8/0xe0
[  721.502746]  [00000000004683e4] warn_slowpath_fmt+0x64/0x80
[  721.503159]  [00000000009a7dd8] dev_watchdog+0x2b8/0x2e0
[  721.503556]  [00000000004c8d58] call_timer_fn+0x18/0x120
[  721.503941]  [00000000004c9550] run_timer_softirq+0x410/0x4e0
[  721.504344]  [0000000000b1605c] __do_softirq+0xdc/0x300
[  721.504725]  [000000000042cd88] do_softirq_own_stack+0x28/0x40
[  721.505151]  [000000000046d020] irq_exit+0xa0/0xc0
[  721.505509]  [0000000000b15f14] timer_interrupt+0x54/0x80
[  721.505887]  [00000000004209d4] tl0_irq14+0x14/0x20
[  721.506297]  [0000000000b145a0] default_idle_call+0x40/0x60
[  721.506728]  [00000000004973e4] do_idle+0xa4/0x140
[  721.507076]  [00000000004976d4] cpu_startup_entry+0x14/0x40
[  721.507476]  [0000000000b0f0a0] rest_init+0x80/0x90
[  721.507833]  [0000000000e046b4] arch_call_rest_init+0xc/0x1c
[  721.508227]  [0000000000e04c74] start_kernel+0x54c/0x55c
[  721.508659] ---[ end trace 4359c4abd98957e4 ]---
[  721.509094] enp2s1: transmit timed out, resetting
[  721.509522] enp2s1: Happy Status 03030000 TX[00000001:00000201]
[  721.510697] kernel BUG at arch/sparc/kernel/iommu-common.c:240!
[  721.511263]               \|/ ____ \|/
[  721.511263]               "@'/ .. \`@"
[  721.511263]               /_| \__/ |_\
[  721.511263]                  \__U_/
[  721.512270] swapper(0): Kernel bad sw trap 5 [#1]
[  721.512705] CPU: 0 PID: 0 Comm: swapper Tainted: G        W   E     5.6.0-1-sparc64 #1 Debian 5.6.7-1
[  721.513396] TSTATE: 0000004480e01603 TPC: 0000000000439674 TNPC: 0000000000439678 Y: 00000000    Tainted: G        W   E    
[  721.514186] TPC: <iommu_tbl_range_free+0x94/0xa0>
[  721.514637] g0: 0000000000d5b1b0 g1: 0000000000d46260 g2: 0000000000d46260 g3: 000000000000000e
[  721.515257] g4: 0000000000d26ea8 g5: fffff80100037aa8 g6: 0000000000d14000 g7: 0720072007200720
[  721.515876] o0: 0000000000c28348 o1: 00000000000000f0 o2: 0000000000000007 o3: 00000000000001db
[  721.516496] o4: 00000000000001db o5: 0000000000000000 sp: fffff8003fe12ff1 ret_pc: 000000000043966c
[  721.517131] RPC: <iommu_tbl_range_free+0x8c/0xa0>
[  721.517543] l0: 0000000000ea8c00 l1: 0000000000000001 l2: 0000000000000000 l3: 0000000000d44a10
[  721.518152] l4: 0000000000de7c00 l5: 0000000000de7c00 l6: 0000000000000001 l7: 0000000000d4cac0
[  721.518839] i0: fffff8003a1fd000 i1: ffffffff40000000 i2: 0000000000000000 i3: 0007fffffffa0000
[  721.519463] i4: 00000000000001da i5: ffffffffffffe000 i6: fffff8003fe130a1 i7: 00000000004388f4
[  721.520105] I7: <dma_4u_unmap_page+0x114/0x1a0>
[  721.520463] Call Trace:
[  721.520675]  [00000000004388f4] dma_4u_unmap_page+0x114/0x1a0
[  721.521122]  [00000000100029d8] happy_meal_clean_rings+0x138/0x1c0 [sunhme]
[  721.521602]  [0000000010002d98] happy_meal_init+0x98/0x920 [sunhme]
[  721.522060]  [0000000010004c64] happy_meal_tx_timeout+0x74/0x90 [sunhme]
[  721.522591]  [00000000009a7d58] dev_watchdog+0x238/0x2e0
[  721.522979]  [00000000004c8d58] call_timer_fn+0x18/0x120
[  721.523368]  [00000000004c9550] run_timer_softirq+0x410/0x4e0
[  721.523765]  [0000000000b1605c] __do_softirq+0xdc/0x300
[  721.524131]  [000000000042cd88] do_softirq_own_stack+0x28/0x40
[  721.524536]  [000000000046d020] irq_exit+0xa0/0xc0
[  721.524886]  [0000000000b15f14] timer_interrupt+0x54/0x80
[  721.525260]  [00000000004209d4] tl0_irq14+0x14/0x20
[  721.525606]  [0000000000b145a0] default_idle_call+0x40/0x60
[  721.525993]  [00000000004973e4] do_idle+0xa4/0x140
[  721.526389]  [00000000004976d4] cpu_startup_entry+0x14/0x40
[  721.526815]  [0000000000b0f0a0] rest_init+0x80/0x90
[  721.527239] Disabling lock debugging due to kernel taint
[  721.527763] Caller[00000000004388f4]: dma_4u_unmap_page+0x114/0x1a0
[  721.528280] Caller[00000000100029d8]: happy_meal_clean_rings+0x138/0x1c0 [sunhme]
[  721.528820] Caller[0000000010002d98]: happy_meal_init+0x98/0x920 [sunhme]
[  721.529312] Caller[0000000010004c64]: happy_meal_tx_timeout+0x74/0x90 [sunhme]
[  721.529822] Caller[00000000009a7d58]: dev_watchdog+0x238/0x2e0
[  721.530225] Caller[00000000004c8d58]: call_timer_fn+0x18/0x120
[  721.530701] Caller[00000000004c9550]: run_timer_softirq+0x410/0x4e0
[  721.531138] Caller[0000000000b1605c]: __do_softirq+0xdc/0x300
[  721.531546] Caller[000000000042cd88]: do_softirq_own_stack+0x28/0x40
[  721.531991] Caller[000000000046d020]: irq_exit+0xa0/0xc0
[  721.532357] Caller[0000000000b15f14]: timer_interrupt+0x54/0x80
[  721.532763] Caller[00000000004209d4]: tl0_irq14+0x14/0x20
[  721.533148] Caller[0000000000b14598]: default_idle_call+0x38/0x60
[  721.533576] Caller[00000000004973e4]: do_idle+0xa4/0x140
[  721.533954] Caller[00000000004976d4]: cpu_startup_entry+0x14/0x40
[  721.534427] Caller[0000000000b0f0a0]: rest_init+0x80/0x90
[  721.534835] Caller[0000000000e046b4]: arch_call_rest_init+0xc/0x1c
[  721.535251] Caller[0000000000e04c74]: start_kernel+0x54c/0x55c
[  721.535665] Caller[0000000000e071e0]: start_early_boot+0x2c4/0x2d4
[  721.536094] Caller[0000000000b0f000]: tlb_fixup_done+0x4c/0x6c
[  721.536495] Caller[0000000000000000]: 0x0
[  721.536807] Instruction DUMP:
[  721.536870]  921020f0 
[  721.537162]  7fffbd8d 
[  721.537354]  90122348 
[  721.537544] <91d02005>
[  721.537727]  01000000 
[  721.537918]  01000000 
[  721.538100]  9de3bf50 
[  721.538348]  01000000 
[  721.538550]  01000000 
[  721.538792] 
[  721.539279] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  721.540430] Press Stop-A (L1-A) from sun keyboard or send break
[  721.540430] twice on console to return to the boot prom
[  721.541191] ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

That's
                unsigned int pool_nr = entry / tbl->poolsize;

                BUG_ON(pool_nr >= tbl->nr_pools);
                p = &tbl->pools[pool_nr];

in get_pool(), so it looks like 'entry' is too large here.  The call chain is
get_pool() <- iommu_tbl_range_free() <- dma_4u_unmap_page() (get_pool() itself got
inlined), so we have
        iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
in the end of dma_4u_unmap_page(), with
        unsigned long shift = iommu->table_shift;
        if (entry = IOMMU_ERROR_CODE) /* use default addr->entry mapping */
                entry = (dma_addr - iommu->table_map_base) >> shift;
        pool = get_pool(iommu, entry);

in iommu_tlb_range_free().  Hmm...  Anyway, that looks like more like fallout from
buggered attempt of recovery in sunhme.  We are definitely losing IRQs here.

> If you able to reproduce the issue consistently and can help figure out what's going
> on then that would be a great help. Perhaps it might make sense to split this into a
> separate thread and drop the non-sparc lists?

Sure, no problem.  As for "able to reproduce" - generally takes under half an hour.
Less in this case, as you can see from printk timestamps...
