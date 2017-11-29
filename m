From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 18:48:42 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <20171129.134842.1976498563726280123.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 27 Nov 2017 13:20:12 +0300

> [    0.175161]   node   0: [mem 0x0000000080000000-0x000000077fffffff]
> [    0.175221]   node   0: [mem 0x0000002000000000-0x000000202fffffff]
> [    0.176318]   node   0: [mem 0x0000004030000000-0x00000040bf8b3fff]
> [    0.176400] Initmem setup node 0 [mem 0x0000000040400000-0x00000040bf8b3fff]

For the record, same pattern as your other crash:

> [    0.176522] Kernel unaligned access at TPC[9f8a10]
> minmax_subwin_update+0x30/0x100
> [    0.176608] Unable to handle kernel NULL pointer dereference in mna handler
> [    0.176614]  at virtual address 0000000000000009
> [    0.176728] current->{active_,}mm->context = 0000000000000000
> [    0.176787] current->{active_,}mm->pgd = fff8004030002000
> [    0.176844]               \|/ ____ \|/
> [    0.176844]               "@'/ .. \`@"
> [    0.176844]               /_| \__/ |_\
> [    0.176844]                  \__U_/
> [    0.178015] swapper(0): Oops [#1]
> [    0.178070] CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1 #527
> [    0.178133] task: 0000000000c06c80 task.stack: 0000000000be8000
> [    0.178190] TSTATE: 0000000080e01607 TPC: 00000000009f8a10 TNPC:
> 00000000009f8a14 Y: 0000000f    Not tainted
> [    0.179325] TPC: <minmax_subwin_update+0x30/0x100>

We are initializing free memory, then we end up at a totally unrelated
piece of code.

Something is causing the cpu to call some random address and we need
to figure out why.

I've built the current kernel on a SunBlade-2500 with gcc-4.4.5 and I
couldn't reproduce this crash.
