From: Bob Picco <bob.picco@oracle.com>
Date: Mon, 29 Sep 2014 21:03:22 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140929210322.GG24131@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Mon Sep 29 2014, 04:15:43PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Sun, 28 Sep 2014 00:35:25 -0400 (EDT)
> 
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Sat, 27 Sep 2014 16:46:51 -0400
> > 
> >>> Anyways, let me know how these work for you.  I'll be running tests
> >>> on my T4-2 all weekend.
> >> I'll commence with T5-2 which is local to me.
> >> 
> >> M7-4 came up with an older kernel of mine but with hardware faults.
> > 
> > Thanks in advance.
> > 
> > I added the following to my tree to deal with the MAX_BANKS issue,
> > I hope it helps the case you talked about, and it's essentially
> > free :-)
> 
> Bob, I know you're probably busy, but any updates wrt. testing
> this series?
Apologies, I've been contexting switching heavily.

My local T4-2 and T5-2 seem solid for THP "always" and large kernel parallel
makes. I've seen no issues.

There is an issue with spec-jbb. I'm hoping to have dedicated time for
this issue during the week.

I've not had time to examine the DEBUG_PAGEALLOC issue.

I'll also test M7, faults permitting.

I'll commit to resolving these issues before the merge window closes.

Obviously it is your final decision that matters.

> 
you're welcome and thanx
> Thanks.
