From: David Miller <davem@davemloft.net>
Date: Fri, 28 Jul 2017 05:10:09 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170727.221009.2117810548718510128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <22906.17109.563338.559874@gargle.gargle.HOWL>
In-Reply-To: <22906.17109.563338.559874@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpelinux@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Thu, 27 Jul 2017 21:45:25 +0200

> Attempting to build strace-4.18 as sparcv9 code and run its test suite
> on a sparc64 machine (Sun Blade 2500 w/ 2 x USIIIi in my case) fails
> reliably in three test cases (sched.gen, sched_xetattr.gen, and poll)
> because two test binaries (sched_xetattr and poll) OOPS the kernel and
> get killed.  Sample dmesg from 4.13-rc2:
> 
> [42912.270398] Unable to handle kernel NULL pointer dereference
> [42912.327717] tsk->{mm,active_mm}->context = 000000000000136a
> [42912.383789] tsk->{mm,active_mm}->pgd = fff0000227db4000
> [42912.435247]               \|/ ____ \|/
>                              "@'/ .. \`@"
>                              /_| \__/ |_\
>                                 \__U_/
> [42912.559982] sched_xetattr(21866): Oops [#1]
> [42912.597773] CPU: 0 PID: 21866 Comm: sched_xetattr Not tainted 4.13.0-rc2 #1
> [42912.672138] task: fff0000229a5c380 task.stack: fff0000227dec000
> [42912.732876] TSTATE: 0000004411001603 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Not tainted
> [42912.845079] TPC: <__bzero+0x20/0xc0>
> [42912.874870] g0: 0000000000000000 g1: 0000000000000000 g2: 0000003000000000 g3: 00000000008ca100
> [42912.972120] g4: fff0000229a5c380 g5: fff000023ef44000 g6: fff0000227dec000 g7: 0000000000000030
> [42913.069446] o0: 0000000000000030 o1: fff0000227defe70 o2: 0000000000000000 o3: 0000000000000030
> [42913.166765] o4: fff0000227defe70 o5: 0000000000000000 sp: fff0000227def5c1 ret_pc: 0000000000474fa4
> [42913.268664] RPC: <SyS_sched_setattr+0xb0/0x150>

This looks really strange.  It is a memset() call with the buffer pointer
and length arguments reversed.

What exact command did you give to configure and build strace-4.18 so that
I can try to reproduce this?

Thanks.
