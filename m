From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2007 04:24:45 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071027.212445.198836225.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 27 Oct 2007 20:09:47 +0200

> titan:~# [ 2427.313946] BUG: soft lockup - CPU#3 stuck for 11s! [aptitude:13375]
> [ 2427.389128] TSTATE: 0000000011009602 TPC: 000000000042f93c TNPC: 000000000042f7d0 Y: 00000000    Not tainted
> [ 2427.506821] TPC: <__delay+0x1c/0x48>
> [ 2427.549494] g0: 0000000000009000 g1: 000000000042f7d0 g2: 00000000aaaaaaaa g3: 0000000055555555
> [ 2427.653670] g4: fffff8a00793c960 g5: fffff89fff994000 g6: fffff8a007dfc000 g7: 0000000000000000
> [ 2427.757835] o0: 0000000000000020 o1: 0000000000000020 o2: 0000000000000000 o3: 0000000000000000
> [ 2427.862001] o4: 000000000030a0d0 o5: 0000000000000000 sp: fffff8a007dff071 ret_pc: 000000000042f938
> [ 2427.970337] RPC: <__delay+0x18/0x48>
> [ 2428.013031] l0: 00000005a6cab647 l1: 0000000011009601 l2: 00000000004417a8 l3: 0000000000000400
> [ 2428.117206] l4: 0000000000000000 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000000008
> [ 2428.221374] i0: 0000000000000000 i1: fffff8a007dffa88 i2: 0000000000000004 i3: 0000000000000001
> [ 2428.325538] i4: 00000000ffffffff i5: 0000000000000000 i6: fffff8a007dff131 i7: 00000000004417ec
> [ 2428.429710] I7: <cheetah_xcall_deliver+0x1c0/0x23c>
> 
> and an unkillable, cpu-eating aptitude.

One cpu can't send a message successfully to another cpu, likely
because it is stuck somewhere with interrupts off.

I was going to give you a patch like the one at the end of this email
to try and get a register dump from all cpus with Alt-Sysrq-p but that
is guarenteed not to work.  It will just call back into
cheetah_xcall_deliver() and wedge further.  Again, don't use the
patch, trying to get a register dump with it in this state will just
wedge the machine further.

I don't know how to suggest a way to debug this further, sorry.

I'm sick of these bugs and I need to reproduce all of these
UltraSPARC-III issues locally to fix them.  So let's go.

Everyone who sees these UltraSPARC-III problems please send me PRECISE
and FULL description of how to install from scratch a machine and run
something that will trigger these errors.

DO NOT leave out any detail of your installation.  Any minor omission
will mean that I potentially won't be able to reproduce this bug and
therefore I won't be able to fix it either.

If you are using NIS, say so and give the exact configuration.  If you
have any modifications to some core configuration file like
/etc/nsswitch.conf, tell me.  If you are using static IP addresses,
tell me.  If you have netfilter enabled, tell me.  If you have even
installed some extra package, like libnss-db or anything else, tell me
even if you think it's not in use.

In short I want a flawless cook-book style recipe for installing a
machine that I can reproduce this problem on.  Do not omit any detail.

Thanks!

diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index ca7cdfd..e10fdce 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -348,7 +348,7 @@ void show_regs(struct pt_regs *regs)
 	extern long etrap, etraptl1;
 #endif
 	__show_regs(regs);
-#if 0
+#if 1
 #ifdef CONFIG_SMP
 	{
 		extern void smp_report_regs(void);
