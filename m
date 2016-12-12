From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:14:43 +0000
Subject: Re: [PATCH v3] sparc64: Multi-page size support
Message-Id: <20161211.211443.717285037765542273.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1479852621-44453-1-git-send-email-nitin.m.gupta@oracle.com>
        <20161211.210630.2011252691128570190.davem@davemloft.net>
In-Reply-To: <20161211.210630.2011252691128570190.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: mike.kravetz@oracle.com, akpm@linux-foundation.org, julian.calaby@gmail.com, hughd@google.com, adam.buchbinder@gmail.com, minchan@kernel.org, kirill.shutemov@linux.intel.com, sfr@canb.auug.org.au, paul.gortmaker@windriver.com, thomas.tai@oracle.com, chris.hyser@oracle.com, atish.patra@oracle.com, mhocko@suse.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 11 Dec 2016 21:06:30 -0500 (EST)

> Applied.

Actually, I'm reverting.

Just doing a simply "make -s -j128" kernel build on a T4-2 I'm
getting kernel log warnings:

[2024810.925975] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[2024909.011397] random: crng init done
[2024970.860642] ------------[ cut here ]------------
[2024970.869970] WARNING: CPU: 85 PID: 19335 at arch/sparc/mm/tsb.c:99 __flush_huge_tsb_one_entry.constprop.0+0x30/0x74
[2024970.890947] Modules linked in: ipv6 usb_storage loop ehci_pci sg sr_mod igb ptp pps_core ehci_hcd n2_rng rng_core
[2024970.911785] CPU: 85 PID: 19335 Comm: ld Not tainted 4.9.0+ #9
[2024970.923588] Call Trace:
[2024970.928807]  [0000000000463a2c] __warn+0xb0/0xc8
[2024970.938349]  [000000000044efa4] __flush_huge_tsb_one_entry.constprop.0+0x30/0x74
[2024970.953463]  [000000000044f224] flush_tsb_user_page+0x88/0x9c
[2024970.965268]  [000000000044eabc] tlb_batch_add_one+0x5c/0xd4
[2024970.976722]  [000000000044ed84] set_pmd_at+0x104/0x184
[2024970.987329]  [0000000000552594] zap_huge_pmd+0x30/0x244
[2024970.998097]  [000000000052a7a8] unmap_page_range+0x18c/0x794
[2024971.009721]  [000000000052b05c] unmap_vmas+0x18/0x44
[2024971.019976]  [00000000005315f8] exit_mmap+0x94/0x114
[2024971.030207]  [0000000000461930] mmput+0x50/0xf8
[2024971.039593]  [00000000004674ac] do_exit+0x310/0x904
[2024971.049651]  [0000000000467c10] do_group_exit+0x80/0xbc
[2024971.060415]  [0000000000467c60] SyS_exit_group+0x14/0x20
[2024971.071363]  [0000000000406194] linux_sparc_syscall32+0x34/0x60

which is:

#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
static void __flush_huge_tsb_one_entry(unsigned long tsb, unsigned long v,
                                       unsigned long hash_shift,
                                       unsigned long nentries,
                                       unsigned int hugepage_shift)
{
        unsigned int hpage_entries;
        unsigned int i;

        hpage_entries = 1 << (hugepage_shift - REAL_HPAGE_SHIFT);
        WARN_ON(v & ((1ul << hugepage_shift) - 1));
        ^^^^^^^
