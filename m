From: David Miller <davem@davemloft.net>
Date: Mon, 31 Jul 2017 21:51:51 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170731.145151.571917275997786929.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <22908.31076.708982.410201@gargle.gargle.HOWL>
        <22911.25997.495345.538443@gargle.gargle.HOWL>
        <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
In-Reply-To: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: mikpelinux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 1 Aug 2017 00:48:07 +0300

> Aug 01 00:35:11 v215 kernel: sched_xetattr(1527): Oops [#1]
> Aug 01 00:35:11 v215 kernel: CPU: 1 PID: 1527 Comm: sched_xetattr Not
> tainted 4.12.0 #365
> Aug 01 00:35:11 v215 kernel: task: fff0001231d41340 task.stack: fff000123dfc4000
> Aug 01 00:35:11 v215 kernel: TSTATE: 0000004411001604 TPC:
> 0000000000a121fc TNPC: 0000000000a12210 Y: 00000000    Not tainted
> Aug 01 00:35:11 v215 kernel: TPC: <__bzero+0x20/0xc0>
> Aug 01 00:35:11 v215 kernel: g0: fff000123dfc7d20 g1: 0000000000000000
> g2: 0000003000000000 g3: 0000000000000000
> Aug 01 00:35:11 v215 kernel: g4: fff0001231d41340 g5: fff000123ed08000
> g6: fff000123dfc4000 g7: 0000000000000030
> Aug 01 00:35:11 v215 kernel: o0: 0000000000000030 o1: fff000123dfc7e70
> o2: 0000000000000000 o3: 0000000000000030
> Aug 01 00:35:11 v215 kernel: o4: fff000123dfc7e70 o5: 000000000000000a
> sp: fff000123dfc75c1 ret_pc: 000000000049b294
> Aug 01 00:35:11 v215 kernel: RPC: <SyS_sched_setattr+0x174/0x1a0>

Please run gdb on this kernel image and tell it:

(gdb) x/20i 0x49b294 - 16

Thanks.

I think perhaps one of Al Viro's changes in the bisected commit causes
a branch to either have an overflowed offset field, or get mispatched
to the wrong destination.
