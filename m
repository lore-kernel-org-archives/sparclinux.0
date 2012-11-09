From: Hugh Dickins <hughd@google.com>
Date: Fri, 09 Nov 2012 20:06:18 +0000
Subject: Re: [PATCH 03/16] mm: check rb_subtree_gap correctness
Message-Id: <alpine.LNX.2.00.1211091156120.3856@eggly.anvils>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-4-git-send-email-walken@google.com>
 <509D0F86.30607@gmail.com>
In-Reply-To: <509D0F86.30607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 9 Nov 2012, Sasha Levin wrote:
> On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> > When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
> > correctly set for every vma and that mm->highest_vm_end is also correct.
> > 
> > Also add an explicit 'bug' variable to track if browse_rb() detected any
> > invalid condition.
> > 
> > Signed-off-by: Michel Lespinasse <walken@google.com>
> > Reviewed-by: Rik van Riel <riel@redhat.com>
> > 
> > ---
> 
> Hi all,
> 
> While fuzzing with trinity inside a KVM tools (lkvm) guest, using today's -next
> kernel, I'm getting these:
> 
> 
> [  117.007714] free gap 7fba0dd1c000, correct 7fba0dcfb000
> [  117.019773] map_count 750 rb -1
> [  117.028362] ------------[ cut here ]------------
> [  117.029813] kernel BUG at mm/mmap.c:439!
> [  117.031024] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
> [  117.032933] Dumping ftrace buffer:
> [  117.033972]    (ftrace buffer empty)
> [  117.035085] CPU 4
> [  117.035676] Pid: 6859, comm: trinity-child46 Tainted: G        W    3.7.0-rc4-next-20121109-sasha-00013-g9407f3c #124
> [  117.038217] RIP: 0010:[<ffffffff81236687>]  [<ffffffff81236687>] validate_mm+0x297/0x2c0
> [  117.041056] RSP: 0018:ffff880016a4fdf8  EFLAGS: 00010296
> [  117.041056] RAX: 0000000000000013 RBX: 00000000ffffffff RCX: 0000000000000006
> [  117.041056] RDX: 0000000000005270 RSI: ffff880024120910 RDI: 0000000000000286
> [  117.052131] RBP: ffff880016a4fe48 R08: 0000000000000000 R09: 0000000000000000
> [  117.052131] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000000002ee
> [  117.052131] R13: 00007fffea1fc000 R14: ffff88002412c000 R15: 0000000000000000
> [  117.052131] FS:  00007fba129db700(0000) GS:ffff880063600000(0000) knlGS:0000000000000000
> [  117.052131] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  117.052131] CR2: 0000000003323288 CR3: 00000000169b2000 CR4: 00000000000406e0
> [  117.052131] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  117.052131] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  117.052131] Process trinity-child46 (pid: 6859, threadinfo ffff880016a4e000, task ffff880024120000)
> [  117.052131] Stack:
> [  117.052131]  ffffffff8489e201 ffffffff81235aa0 ffff88000885cac8 0000000100000000
> [  117.052131]  ffffffff812361b9 ffff88002412c000 ffff88000885cac8 ffff88000885cdc8
> [  117.052131]  ffff88000885cdd0 ffff88002412c000 ffff880016a4fe98 ffffffff812367b4
> [  117.052131] Call Trace:
> [  117.052131]  [<ffffffff81235aa0>] ? vma_compute_subtree_gap+0x40/0x40
> [  117.052131]  [<ffffffff812361b9>] ? vma_gap_update+0x19/0x30
> [  117.052131]  [<ffffffff812367b4>] vma_link+0x94/0xe0
> [  117.052131]  [<ffffffff812386c4>] do_brk+0x2c4/0x380
> [  117.052131]  [<ffffffff812387bf>] ? sys_brk+0x3f/0x190
> [  117.052131]  [<ffffffff812388ce>] sys_brk+0x14e/0x190
> [  117.052131]  [<ffffffff83be2618>] tracesys+0xe1/0xe6
> [  117.052131] Code: d8 41 8b 76 60 39 de 74 1b 89 da 48 c7 c7 c6 d9 89 84 31 c0 e8 01 76 94 02 eb 10 66 0f 1f 84 00 00 00 00 00
> 8b 45 c8 85 c0 74 18 <0f> 0b 4c 8d 48 e0 48 8b 70 e0 31 db c7 45 cc 00 00 00 00 e9 f4
> [  117.052131] RIP  [<ffffffff81236687>] validate_mm+0x297/0x2c0
> [  117.052131]  RSP <ffff880016a4fdf8>
> [  117.136092] ---[ end trace 5ce250e0bf6d040c ]---
> 
> Note that they are very easy to reproduce.
> 
> Also, I see that lots of the code there has a local variable named 'bug' thats tracking
> whether we should BUG() later on. Why does it work that way and the BUG() isn't immediate?

3.7.0-rc4-mm1 BUGged on mm/mmap.c:439 as soon as I tried to rebuild
that kernel with Alan's tty/vt/fb patch included, no fuzzing required.

free_gap 55551d077000, correct 55551ccd2000 in my case.

It should only be affecting the minority with CONFIG_DEBUG_VM_RB=y.
I've put #if 0 around the rb_subtree_gap checking block in browse_rb(),
and running okay so far with that - but not yet done much with it.

Hugh
