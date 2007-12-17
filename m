From: Matt Mackall <mpm@selenic.com>
Date: Mon, 17 Dec 2007 02:11:49 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071217021149.GC19691@waste.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071213024050.7d6e5f3e.akpm@linux-foundation.org> <20071216182720.GZ19691@waste.org> <200712161948.42656.m.kozlowski@tuxland.pl> <200712162010.11028.m.kozlowski@tuxland.pl>
In-Reply-To: <200712162010.11028.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Sun, Dec 16, 2007 at 08:10:10PM +0100, Mariusz Kozlowski wrote:
> > > Can you change line 710 of fs/proc/proc_misc.c to:
> > > 
> > > 	ppage = NULL;
> > 
> > Sure.
> > 
> > > ..and see if it still breaks?
> > 
> > Yes it does - the same way as eariler. Box is locked, processes stuck in D state
> > and after a while "BUG: soft lockup - CPU#0 stuck for 11s!".
> 
> My mistake. I run cat /proc/kpageflags in the first place - so how
> could anything change :)
> 
> cat /proc/kpagecount on the other hand - with the change in line 710
> - locks the box. Sysrq works, changing consoles works, but there is
> no "BUG: soft lockup ..." message. After a while the box becomes
> totaly unresponsive - even caps lock doesn't work, no responses to
> ping.

Well I'm baffled. There's basically two things in that function that
do anything interesting: pfn_to_page and put_user. access_ok is
"return 1" on Sparc64. atomic_read is a simple read.

My usual approach at this point would be to litter it with printks and
see where its hanging.

But as the function doesn't actually show up in your stack trace,
something else is probably wrong. So I'd also try commenting out
pieces of that function until it started working.

-- 
Mathematics is the supreme nostalgia of our time.
