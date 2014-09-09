From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 19:22:37 +0000
Subject: Re: [PATCH] sparc64: sun4v TLB error power off events
Message-Id: <20140909.122237.2041350451298101014.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104858-22046-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun,  7 Sep 2014 11:47:38 -0400

> We've witnessed a few TLB events causing the machine to power off because
> of prom_halt. In one case it was some nfs related area during rmmod. Another
> was an mmapper of /dev/mem. A more recent one is an ITLB issue with
> a bad pagesize which could be a hardware bug. Bugs happen but we should
> attempt to not power off the machine and/or hang it when possible.

prom_halt() should not power off the machine, but rather drop us to
the OF command line "ok" prompt.

Why doesn't it do that?

We properly do a >tl1 vs. tl1 etrap call, so we should be at trap
level zero when we call into the prom to "exit".
