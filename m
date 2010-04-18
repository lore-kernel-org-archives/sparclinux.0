From: David Miller <davem@davemloft.net>
Date: Sun, 18 Apr 2010 21:19:54 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100418.141954.144431406.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sun, 18 Apr 2010 17:31:24 +0200

> That reminds me badly the problems with NMIs, and I saw
> an NMI path in one of the dumps, so I guess you were
> right after all as it looks like more an NMIs related problem
> rather than a recursion.
> 
> I thought if I won't enable the watchdog I wouldn't have NMIs
> but I have some in /proc/interrupts

Maybe this patch helps your case but I still get crashes even with
NMIs disabled, since as I mentioned the other day I've already
tested with them disabled.

To turn them off, simply make arch/sparc/kernel/pcr.c:pcr_arch_init()
immediately return 0 and you'll have no NMIs at all.
