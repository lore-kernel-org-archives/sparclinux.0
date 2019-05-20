From: Meelis Roos <mroos@linux.ee>
Date: Mon, 20 May 2019 21:36:22 +0000
Subject: Re: [PATCH v2] vmalloc: Fix issues with flush flag
Message-Id: <90f8a4e1-aa71-0c10-1a91-495ba0cb329b@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190520200703.15997-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Cc: dave.hansen@intel.com, namit@vmware.com, Meelis Roos <mroos@linux.ee>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>

> Switch VM_FLUSH_RESET_PERMS to use a regular TLB flush intead of
> vm_unmap_aliases() and fix calculation of the direct map for the
> CONFIG_ARCH_HAS_SET_DIRECT_MAP case.
>=20
> Meelis Roos reported issues with the new VM_FLUSH_RESET_PERMS flag on a
> sparc machine. On investigation some issues were noticed:
>=20
> 1. The calculation of the direct map address range to flush was wrong.
> This could cause problems on x86 if a RO direct map alias ever got loaded
> into the TLB. This shouldn't normally happen, but it could cause the
> permissions to remain RO on the direct map alias, and then the page
> would return from the page allocator to some other component as RO and
> cause a crash.
>=20
> 2. Calling vm_unmap_alias() on vfree could potentially be a lot of work to
> do on a free operation. Simply flushing the TLB instead of the whole
> vm_unmap_alias() operation makes the frees faster and pushes the heavy
> work to happen on allocation where it would be more expected.
> In addition to the extra work, vm_unmap_alias() takes some locks including
> a long hold of vmap_purge_lock, which will make all other
> VM_FLUSH_RESET_PERMS vfrees wait while the purge operation happens.
>=20
> 3. page_address() can have locking on some configurations, so skip calling
> this when possible to further speed this up.
>=20
> Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsis=
sions")
> Reported-by: Meelis Roos<mroos@linux.ee>
> Cc: Meelis Roos<mroos@linux.ee>
> Cc: Peter Zijlstra<peterz@infradead.org>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: Dave Hansen<dave.hansen@intel.com>
> Cc: Borislav Petkov<bp@alien8.de>
> Cc: Andy Lutomirski<luto@kernel.org>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: Nadav Amit<namit@vmware.com>
> Signed-off-by: Rick Edgecombe<rick.p.edgecombe@intel.com>
> ---
>=20
> Changes since v1:
>   - Update commit message with more detail
>   - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case

It does not work on my V445 where the initial problem happened.

[   46.582633] systemd[1]: Detected architecture sparc64.

Welcome to Debian GNU/Linux 10 (buster)!

[   46.759048] systemd[1]: Set hostname to <v445>.
[   46.831383] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid ar=
gument
[   67.989695] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   68.074706] rcu:     0-...!: (0 ticks this GP) idle\6/1/0x40000000000000=
00 softirq3/33 fqs=3D0
[   68.198443] rcu:     2-...!: (0 ticks this GP) idle=E7e/1/0x400000000000=
0000 softirqg/67 fqs=3D0
[   68.322198]  (detected by 1, tR52 jiffies, g=3D-939, q=108)
[   68.402204]   CPU[  0]: TSTATE[0000000080001603] TPC[000000000043f298] T=
NPC[000000000043f29c] TASK[systemd-debug-g:89]
[   68.556001]              TPC[smp_synchronize_tick_client+0x18/0x1a0] O7[=
0xfff000010000691c] I7[xcall_sync_tick+0x1c/0x2c] RPC[alloc_set_pte+0xf4/0x=
300]
[   68.750973]   CPU[  2]: TSTATE[0000000080001600] TPC[000000000043f298] T=
NPC[000000000043f29c] TASK[systemd-cryptse:88]
[   68.904741]              TPC[smp_synchronize_tick_client+0x18/0x1a0] O7[=
filemap_map_pages+0x3cc/0x3e0] I7[xcall_sync_tick+0x1c/0x2c] RPC[handle_mm_=
fault+0xa0/0x180]
[   69.115991] rcu: rcu_sched kthread starved for 5252 jiffies! g-939 f0x0 =
RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D3
[   69.262239] rcu: RCU grace-period kthread stack dump:
[   69.334741] rcu_sched       I    0    10      2 0x06000000
[   69.413495] Call Trace:
[   69.448501]  [000000000093325c] schedule+0x1c/0xc0
[   69.517253]  [0000000000936c74] schedule_timeout+0x154/0x260
[   69.598514]  [00000000004b65a4] rcu_gp_kthread+0x4e4/0xac0
[   69.677261]  [000000000047ecfc] kthread+0xfc/0x120
[   69.746018]  [00000000004060a4] ret_from_fork+0x1c/0x2c
[   69.821014]  [0000000000000000] 0x0

and hangs here, software watchdog kicks in soon.

--=20
Meelis Roos
