From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2014 01:53:18 +0000
Subject: flush_tlb_kernel_range()
Message-Id: <20141004.215318.642435987638821748.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Bob, just to let you know I'm working on fixing the following problem:

[18655.836592] WARNING: CPU: 76 PID: 33324 at arch/sparc/kernel/nmi.c:80 perfctr_irq+0x290/0x2e0()
[18655.853934] Watchdog detected hard LOCKUP on cpu 76
[18655.863296] Modules linked in: ipv6 loop usb_storage sg ehci_pci sr_mod ehci_hcd igb ptp pps_core n2_rng rng_core
[18655.884140] CPU: 76 PID: 33324 Comm: expect Not tainted 3.17.0-rc4+ #1605
[18655.897676] Call Trace:
[18655.902555]  [0000000000466fb4] warn_slowpath_common+0x54/0x80
[18655.914181]  [000000000046706c] warn_slowpath_fmt+0x2c/0x40
[18655.925298]  [00000000008c53d0] perfctr_irq+0x290/0x2e0
[18655.935724]  [00000000004209f4] tl0_irq15+0x14/0x20
[18655.945428]  [00000000008c4d38] _raw_spin_trylock_bh+0x38/0x100
[18655.957245]  [00000000004aeb98] __run_hrtimer+0x58/0x200
[18655.967842]  [00000000004af4cc] hrtimer_interrupt+0xcc/0x220
[18655.979130]  [000000000042f8e0] timer_interrupt+0x80/0xc0
[18655.989883]  [00000000004209d4] tl0_irq14+0x14/0x20
[18655.999608]  [00000000004521e8] __flush_tlb_kernel_range+0x28/0x40
[18656.011947]  [0000000000530c24] free_vmap_area_noflush+0x64/0x80
[18656.023926]  [0000000000531a7c] remove_vm_area+0x5c/0x80
[18656.034514]  [0000000000531b80] __vunmap+0x20/0x120
[18656.044241]  [000000000071cf18] n_tty_close+0x18/0x40
[18656.054315]  [00000000007222b0] tty_ldisc_close+0x30/0x60
[18656.065078]  [00000000007225a4] tty_ldisc_reinit+0x24/0xa0

We've sort of always had this issue, but it is exacerbated by the
recent massive enlargening of the vmalloc area.

When vmalloc areas are released, the kernel doesn't just immediately
flush the TLB/TSB.  Instead it just avoids allocating vmalloc space
from those areas until a lot of unmaps have accumulated.

Then it issues one huge unmap for all of the pending stuff.

We don't have any smarts in flush_tlb_kernel_range() and just do
everything one page at a time for as large of a region as we are asked
to work on.

Obviously, if we were asked to flush the entire vmalloc range, it
would thus take forever.

So I'm going to add a limit to flush_tlb_kernel_range(), of 128 pages
or so, and have it do __flush_tlb_all() if that limit is exceeded.

I reproduced this by bootstrapping gcc and running the testsuite.
