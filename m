From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 16:02:09 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <20171129.110209.2104759912169449052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 29 Nov 2017 11:56:49 +0300

> [    0.068851] Initmem setup node 0 [mem 0x0000000040400000-0x00000040bf8b7fff]

We're setting up the free memory areas in early bootup...

> [    0.068940] Kernel unaligned access at TPC[9b75bc] secpath_set+0x3c/0x80
> [    0.069009] Unable to handle kernel NULL pointer dereference in mna handler
> [    0.069011]  at virtual address 0000000000000069
> [    0.069115] current->{active_,}mm->context = 0000000000000000
> [    0.069167] current->{active_,}mm->pgd = fff8004030002000
> [    0.069219]               \|/ ____ \|/
> [    0.069219]               "@'/ .. \`@"
> [    0.069219]               /_| \__/ |_\
> [    0.069219]                  \__U_/
> [    0.069346] swapper(0): Oops [#1]
> [    0.069382] CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1+ #528
> [    0.069441] task: 0000000000c121c0 task.stack: 0000000000bf8000
> [    0.069496] TSTATE: 0000000080e01607 TPC: 00000000009b75bc TNPC:
> 00000000009b75c0 Y: 00000170    Not tainted
> [    0.069582] TPC: <secpath_set+0x3c/0x80>

And we're suddenly crashing in completely unrelated IPSEC networking
code.

Something is seriously wrong here.
