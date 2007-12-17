From: David Miller <davem@davemloft.net>
Date: Mon, 17 Dec 2007 04:26:11 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071216.202611.226170474.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200712161948.42656.m.kozlowski@tuxland.pl>
	<200712162010.11028.m.kozlowski@tuxland.pl>
	<20071217021149.GC19691@waste.org>
In-Reply-To: <20071217021149.GC19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpm@selenic.com
Cc: m.kozlowski@tuxland.pl, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Sun, 16 Dec 2007 20:11:49 -0600

> But as the function doesn't actually show up in your stack trace,
> something else is probably wrong. So I'd also try commenting out
> pieces of that function until it started working.

Some piece of state is being indirectly corrupted and this
is showing up later in some unrelated operation.

Can someone send me this kpageflags patch under seperate
cover?  I'll try figure out why it farts on sparc64.
