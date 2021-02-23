From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 23 Feb 2021 11:14:19 +0000
Subject: Re: [PATCH v2] sparc: make copy_thread honor pid namespaces
Message-Id: <CADxRZqzPn4yT+ZJCjAoqnKqC1MFPeKCYbhmqRAi-aD8-0Y3DQw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210217080000.GA25861@altlinux.org> <m1tuq9nsnf.fsf@fess.ebiederm.org>
 <20210219225030.GA23520@altlinux.org>
In-Reply-To: <20210219225030.GA23520@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Sat, Feb 20, 2021 at 1:51 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On sparc, fork and clone syscalls have an unusual semantics of
> returning the pid of the parent process to the child process.
>
> Apparently, the implementation did not honor pid namespaces at all,
> so the child used to get the pid of its parent in the init namespace.
>
> Fortunately, most users of these syscalls are not affected by this bug
> because they use another register to distinguish the parent process
> from its child, and the pid of the parent process is often discarded.
>
> Reproducer:

tested on my sparc64 ldom:

1. non-patched kernel (kernel 5.11.0-03615-g55f62bc87347), reproducer/test run:

$ gcc -Wall -O2 sparc-fork-namespace2.c
$ ./a.out
current: 72544, parent: 69045, fork returned: 72545
current: 72545, parent: 72544, fork returned: 72544
current: 72544, parent: 69045, fork returned: 72546
current: 1, parent: 0, fork returned: 72544

2. kernel patch applied, test run:

$ uname -a
Linux ttip 5.11.0-09279-g7c70f3a7488d-dirty #185 SMP Tue Feb 23
00:50:11 MSK 2021 sparc64 GNU/Linux

$ ./a.out
current: 939, parent: 918, fork returned: 940
current: 940, parent: 939, fork returned: 939
current: 939, parent: 918, fork returned: 941
a.out: wait: 0x9

and console/kernel logs:

[   72.204212] Kernel unaligned access at TPC[4060c8] ret_from_fork+0x1c/0x2c
[   72.204254] Unsupported unaligned load/store trap for kernel at
<00000000004060c8>.
[   72.204267]               \|/ ____ \|/
[   72.204267]               "@'/ .. \`@"
[   72.204267]               /_| \__/ |_\
[   72.204267]                  \__U_/
[   72.204284] a.out(941): Kernel does fpu/atomic unaligned load/store. [#3]
[   72.204298] CPU: 6 PID: 941 Comm: a.out Tainted: G      D     E
5.11.0-09279-g7c70f3a7488d-dirty #185
[   72.204315] TSTATE: 0000004411001600 TPC: 00000000004060c8 TNPC:
00000000004060cc Y: 000000cf    Tainted: G      D     E
[   72.204330] TPC: <ret_from_fork+0x1c/0x2c>
[   72.204340] g0: 0000000000000000 g1: ffffffffffffffff g2:
0000000000000006 g3: 0000000000000000
[   72.204349] g4: fff8000041482700 g5: fff80021a9890000 g6:
fff8000041038000 g7: 0308000108000004
[   72.204359] o0: 0000000000000000 o1: 000000001fffffff o2:
fff8000041482780 o3: 0000000000000000
[   72.204369] o4: 0000000000000001 o5: 0000000000000000 sp:
fff800004103b6a1 ret_pc: 00000000004060b0
[   72.204378] RPC: <ret_from_fork+0x4/0x2c>
[   72.204387] l0: 0308000108000000 l1: 0000000000000002 l2:
0000000000450cf4 l3: 0000000000000000
[   72.204396] l4: 0000000000000264 l5: 00000100001eb9f0 l6:
fff8000045018000 l7: 00000000006c7840
[   72.204406] i0: 0000000000efcd60 i1: 0000000000450df4 i2:
00000000000003dc i3: 00000000000003dc
[   72.204415] i4: 0000000000eebc78 i5: 0000000000000000 i6:
000007feffa56811 i7: 0000010000000ad8
[   72.204424] I7: <0x10000000ad8>
[   72.204432] Call Trace:
[   72.204439] Caller[0000010000000ad8]: 0x10000000ad8
[   72.204446] Instruction DUMP:
[   72.204449]  0aca0072
[   72.204456]  e059a008
[   72.204461]  e25ba8c7
[   72.204467] <9fc44000>
[   72.204472]  d05ba8cf
[   72.204477]  1068006d
[   72.204483]  90102000
[   72.204488]  0f0011a9
[   72.204493]  10680004
[   72.204499]


So something is actually wrong with the patch.

Thanks.
