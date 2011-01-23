From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Sun, 23 Jan 2011 13:09:25 +0000
Subject: 2.6.37 Kernel unaligned access at TPC[4cc4bc] put_page+0x4/0x160
Message-Id: <4D3C2885.2010303@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Earlier this morning my Sun Fire V120 running 2.6.37 (including Mathieu 
Desnoyers ftrace structure alignment patches) crashed due to a kernel 
unaligned access.

Mathieu, I don't think this is due to your patches but I've copied you 
just in case.

There is obviously some memory corruption in the system so the following 
stack trace is likely just a symptom rather than the cause. After the 
initial oops there were a few additional ones from within kmalloc calls 
all with the same corrupted register value.

If anyone has any suggestions for further investigation let me know 
otherwise I'll just keep an eye out for recurrences.

Regards

Richard


Initial oops.


> Jan 23 08:19:13 localhost kernel: [49561.991374] Kernel unaligned access at TPC[4cc4bc] put_page+0x4/0x160
> Jan 23 08:19:13 localhost kernel: [49561.991531] Unable to handle kernel paging request in mna handler
> Jan 23 08:19:13 localhost kernel: [49562.069610]  at virtual address 3c3b794d56eb864c
> Jan 23 08:19:13 localhost kernel: [49562.132800] current->{active_,}mm->context = 0000000000000029
> Jan 23 08:19:13 localhost kernel: [49562.208514] current->{active_,}mm->pgd = fffff8004fd9a000
> Jan 23 08:19:13 localhost kernel: [49562.279587]               \|/ ____ \|/
> Jan 23 08:19:13 localhost kernel: [49562.279610]               "@'/ .. \`@"
> Jan 23 08:19:13 localhost kernel: [49562.279633]               /_| \__/ |_\
> Jan 23 08:19:13 localhost kernel: [49562.279655]                  \__U_/
> Jan 23 08:19:13 localhost kernel: [49562.279710] sshd(5708): Oops [#1]
> Jan 23 08:19:13 localhost kernel: [49562.279768] TSTATE: 0000009911001605 TPC: 00000000004cc4bc TNPC: 00000000004cc4c0 Y: 00000000    Not tainted
> Jan 23 08:19:13 localhost kernel: [49562.279853] TPC: <put_page+0x4/0x160>
> Jan 23 08:19:13 localhost kernel: [49562.279905] g0: 0000000000000000 g1: fffff800dd0a16f0 g2: fffff800dd0a1000 g3: 000000000000b87c
> Jan 23 08:19:13 localhost kernel: [49562.279979] g4: fffff800dc5a05a0 g5: 0000000000000000 g6: fffff80002924000 g7: 0000000000000030
> Jan 23 08:19:13 localhost kernel: [49562.280054] o0: 00000000000007a8 o1: fffff800dd1e00a0 o2: 0000000000002000 o3: fffff80002927e90
> Jan 23 08:19:13 localhost kernel: [49562.280128] o4: fffff800dcdacc00 o5: 0000000000000008 sp: fffff80002926e81 ret_pc: 0000000000680eec
> Jan 23 08:19:13 localhost kernel: [49562.280211] RPC: <sock_rfree+0x10/0x3c>
> Jan 23 08:19:13 localhost kernel: [49562.280263] l0: fffff800dd1e0000 l1: 0000000000001818 l2: 0000000000000004 l3: 0000000000000008
> Jan 23 08:19:13 localhost kernel: [49562.280336] l4: fffff80002927ca8 l5: 0000000000000000 l6: 0000000000000000 l7: 00000000f7bfb000
> Jan 23 08:19:13 localhost kernel: [49562.280411] i0: 3c3b794d56eb864c i1: fffff800dd0a135c i2: 0000000000000000 i3: 0000000000000062
> Jan 23 08:19:13 localhost kernel: [49562.280484] i4: 00000000ffc6f058 i5: 0000000000000000 i6: fffff80002926f31 i7: 0000000000685ca8
> Jan 23 08:19:13 localhost kernel: [49562.280568] I7: <skb_release_data+0x74/0xe4>
> Jan 23 08:19:13 localhost kernel: [49562.280603] Call Trace:
> Jan 23 08:19:13 localhost kernel: [49562.280663]  [0000000000685ca8] skb_release_data+0x74/0xe4
> Jan 23 08:19:13 localhost kernel: [49562.280734]  [00000000006857e0] __kfree_skb+0x10/0xa4
> Jan 23 08:19:13 localhost kernel: [49562.280797]  [00000000006c75bc] tcp_recvmsg+0x6c0/0x854
> Jan 23 08:19:13 localhost kernel: [49562.280865]  [00000000006e6f54] inet_recvmsg+0x34/0x58
> Jan 23 08:19:13 localhost kernel: [49562.280926]  [000000000067deb4] sock_aio_read+0xf8/0x10c
> Jan 23 08:19:13 localhost kernel: [49562.281005]  [00000000004faacc] do_sync_read+0x6c/0xbc
> Jan 23 08:19:13 localhost kernel: [49562.281065]  [00000000004fb5c8] vfs_read+0x84/0x124
> Jan 23 08:19:13 localhost kernel: [49562.281123]  [00000000004fb700] SyS_read+0x2c/0x5c
> Jan 23 08:19:13 localhost kernel: [49562.281198]  [0000000000405fd4] linux_sparc_syscall32+0x34/0x40
> Jan 23 08:19:13 localhost kernel: [49562.281243] Disabling lock debugging due to kernel taint
> Jan 23 08:19:13 localhost kernel: [49562.281316] Caller[0000000000685ca8]: skb_release_data+0x74/0xe4
> Jan 23 08:19:13 localhost kernel: [49562.281389] Caller[00000000006857e0]: __kfree_skb+0x10/0xa4
> Jan 23 08:19:13 localhost kernel: [49562.281453] Caller[00000000006c75bc]: tcp_recvmsg+0x6c0/0x854
> Jan 23 08:19:13 localhost kernel: [49562.281521] Caller[00000000006e6f54]: inet_recvmsg+0x34/0x58
> Jan 23 08:19:13 localhost kernel: [49562.281584] Caller[000000000067deb4]: sock_aio_read+0xf8/0x10c
> Jan 23 08:19:13 localhost kernel: [49562.281660] Caller[00000000004faacc]: do_sync_read+0x6c/0xbc
> Jan 23 08:19:13 localhost kernel: [49562.281722] Caller[00000000004fb5c8]: vfs_read+0x84/0x124
> Jan 23 08:19:13 localhost kernel: [49562.281783] Caller[00000000004fb700]: SyS_read+0x2c/0x5c
> Jan 23 08:19:13 localhost kernel: [49562.281854] Caller[0000000000405fd4]: linux_sparc_syscall32+0x34/0x40
> Jan 23 08:19:13 localhost kernel: [49562.281955] Caller[00000000700438bc]: 0x700438bc
> Jan 23 08:19:13 localhost kernel: [49562.281991] Instruction DUMP: 81e80000  01000000  9de3bf50 <c25e0000> 05000030  80888001  02480004  a0100018  106ffe36
>
>
>
> 00000000004cc4b8 <put_page>:
>   4cc4b8:       9d e3 bf 50     save  %sp, -176, %sp
>   4cc4bc:       c2 5e 00 00     ldx  [ %i0 ], %g1
>                                 ^^^^^^^^^^^^^^^^^
>                                 has 3c3b794d56eb864c in %i0
>   4cc4c0:       05 00 00 30     sethi  %hi(0xc000), %g2
>   4cc4c4:       80 88 80 01     btst  %g2, %g1
>   4cc4c8:       02 48 00 04     be  %icc, 4cc4d8 <put_page+0x20>
>   4cc4cc:       a0 10 00 18     mov  %i0, %l0
>   4cc4d0:       10 6f fe 36     b  %xcc, 4cbda8 <put_compound_page>
>   4cc4d4:       81 e8 00 00     restore
>
>
> Jan 23 08:19:13 localhost kernel: [49562.280411] i0: 3c3b794d56eb864c i1: fffff800dd0a135c i2: 0000000000000000 i3: 0000000000000062
>
> Jan 23 08:19:13 localhost kernel: [49562.280663]  [0000000000685ca8] skb_release_data+0x74/0xe4
>
>   685c9c:       10 68 00 11     b  %xcc, 685ce0 <skb_release_data+0xac>
>   685ca0:       c2 06 20 cc     ld  [ %i0 + 0xcc ], %g1
>   685ca4:       d0 58 60 08     ldx  [ %g1 + 8 ], %o0
>                                 ^^ %i0 value comes from here.
> 								%g1 is fffff800dd0a16f0
>   685ca8:       7f f9 1a 04     call  4cc4b8 <put_page>
>   685cac:       a0 04 20 01     inc  %l0
>   685cb0:       c2 06 20 cc     ld  [ %i0 + 0xcc ], %g1
>
>
>         ba,pt   %xcc, .LL412    !
>          lduw   [%i0+204], %g1  ! <variable>.end, <variable>.end
> .LL408:
>         ldx     [%g1+8], %o0    ! <variable>.page,
>         call    put_page, 0     !,
>          add    %l0, 1, %l0     ! i,, i
>
> static void skb_release_data(struct sk_buff *skb)
> ...
>    for (i = 0; i < ((struct skb_shared_info *)(skb_end_pointer(skb)))->nr_frags; i++)
>     put_page(((struct skb_shared_info *)(skb_end_pointer(skb)))->frags[i].page);
>   }


The secondary oops had stack traces similar to the following:

> Jan 23 08:19:28 localhost kernel: [49577.286627] Kernel unaligned access at TPC[4f6ee4] __kmalloc+0x114/0x1b4
> Jan 23 08:19:28 localhost kernel: [49577.286757] Unable to handle kernel paging request in mna handler
> Jan 23 08:19:28 localhost kernel: [49577.364694]  at virtual address b2b39624fa7e7fd1
> Jan 23 08:19:28 localhost kernel: [49577.427730] current->{active_,}mm->context = 00000000000000bf
> Jan 23 08:19:28 localhost kernel: [49577.503354] current->{active_,}mm->pgd = fffff80012178000
> Jan 23 08:19:28 localhost kernel: [49577.574393]               \|/ ____ \|/
> Jan 23 08:19:28 localhost kernel: [49577.574416]               "@'/ .. \`@"
> Jan 23 08:19:28 localhost kernel: [49577.574439]               /_| \__/ |_\
> Jan 23 08:19:28 localhost kernel: [49577.574461]                  \__U_/
> Jan 23 08:19:28 localhost kernel: [49577.574516] dpkg(5793): Oops [#4]
> Jan 23 08:19:28 localhost kernel: [49577.574574] TSTATE: 0000000011e01601 TPC: 00000000004f6ee4 TNPC: 00000000004f6ee8 Y: 00000000    Tainted: G      D
> Jan 23 08:19:28 localhost kernel: [49577.574663] TPC: <__kmalloc+0x114/0x1b4>
> Jan 23 08:19:28 localhost kernel: [49577.574715] g0: 0000000000000004 g1: 0000000000000000 g2: 0000000000000000 g3: 8000000000000000
> Jan 23 08:19:28 localhost kernel: [49577.574790] g4: fffff800dcea2760 g5: 0000000000000008 g6: fffff800913b8000 g7: fffff8001a507500
> Jan 23 08:19:28 localhost kernel: [49577.574863] o0: 0000000000000000 o1: 00000000000002d0 o2: 00000000004bef84 o3: fffff80000010120
> Jan 23 08:19:28 localhost kernel: [49577.574937] o4: 0000000000000000 o5: 0000000000000000 sp: fffff800913bb231 ret_pc: 00000000004f6ea8
> Jan 23 08:19:28 localhost kernel: [49577.575016] RPC: <__kmalloc+0xd8/0x1b4>
> Jan 23 08:19:28 localhost kernel: [49577.575069] l0: 0000000000000800 l1: fffff8001f806900 l2: 0000000000000000 l3: 000000000050ef58
> Jan 23 08:19:28 localhost kernel: [49577.575140] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000000008
> Jan 23 08:19:28 localhost kernel: [49577.575215] i0: b2b39624fa7e7fd1 i1: 00000000000002d0 i2: 00000000009717f9 i3: fffff800000103f8
> Jan 23 08:19:28 localhost kernel: [49577.575288] i4: 0000000000000000 i5: 0000000000000000 i6: fffff800913bb2e1 i7: 000000000050ef58
> Jan 23 08:19:28 localhost kernel: [49577.575363] I7: <alloc_fdtable+0x168/0x1f4>
> Jan 23 08:19:28 localhost kernel: [49577.575398] Call Trace:
> Jan 23 08:19:28 localhost kernel: [49577.575447]  [000000000050ef58] alloc_fdtable+0x168/0x1f4
> Jan 23 08:19:28 localhost kernel: [49577.575508]  [000000000050f0ac] dup_fd+0xc8/0x29c
> Jan 23 08:19:28 localhost kernel: [49577.575572]  [000000000045921c] copy_process+0x430/0xc3c
> Jan 23 08:19:28 localhost kernel: [49577.575636]  [0000000000459b7c] do_fork+0x154/0x334
> Jan 23 08:19:28 localhost kernel: [49577.575705]  [000000000042b28c] sparc_do_fork+0x30/0x4c
> Jan 23 08:19:28 localhost kernel: [49577.575780]  [0000000000405fd4] linux_sparc_syscall32+0x34/0x40
> Jan 23 08:19:28 localhost kernel: [49577.575847] Caller[000000000050ef58]: alloc_fdtable+0x168/0x1f4
> Jan 23 08:19:28 localhost kernel: [49577.575909] Caller[000000000050f0ac]: dup_fd+0xc8/0x29c
> Jan 23 08:19:28 localhost kernel: [49577.575973] Caller[000000000045921c]: copy_process+0x430/0xc3c
> Jan 23 08:19:28 localhost kernel: [49577.576039] Caller[0000000000459b7c]: do_fork+0x154/0x334
> Jan 23 08:19:28 localhost kernel: [49577.576107] Caller[000000000042b28c]: sparc_do_fork+0x30/0x4c
> Jan 23 08:19:28 localhost kernel: [49577.576180] Caller[0000000000405fd4]: linux_sparc_syscall32+0x34/0x40
> Jan 23 08:19:28 localhost kernel: [49577.576280] Caller[00000000f7e03e58]: 0xf7e03e58
> Jan 23 08:19:28 localhost kernel: [49577.576316] Instruction DUMP: 92100019  10680004  b0100008 <c25e0001> c272c000  22cc8005  82102000  91948000  10680004

