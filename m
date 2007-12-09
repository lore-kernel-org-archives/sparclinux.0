From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 09 Dec 2007 09:03:11 +0000
Subject: Re: 2.6.24-rc4-mm1: some issues on sparc64
Message-Id: <20071209010311.5bc7318d.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<200712081920.28748.m.kozlowski@tuxland.pl>
	<20071208102239.2457eeaa.akpm@linux-foundation.org>
	<20071209.004517.201813773.davem@davemloft.net>
In-Reply-To: <20071209.004517.201813773.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: m.kozlowski@tuxland.pl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-ext4@vger.kernel.org

On Sun, 09 Dec 2007 00:45:17 -0800 (PST) David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Sat, 8 Dec 2007 10:22:39 -0800
> 
> > That's
> > 
> >         J_ASSERT_BH(bh, !buffer_jbddirty(bh));
> > 
> > at the end of journal_unmap_buffer().
> > 
> > I don't recall seeing that before and I can't think of anything we've
> > done recently which could cause it, sorry.
> 
> If the per-cpu data patches are in the -mm tree that is the first
> place I would start looking at for possible cause.

They aren't.  The dust hadn't settled enough on those when Christoph shot
through on vacation.

