From: Bob Picco <bpicco@meloft.net>
Date: Tue, 08 Oct 2013 13:42:02 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131008134202.GO29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Mon Oct 07 2013, 12:08:50PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Mon, 7 Oct 2013 12:07:45 -0400
> 
> > David Miller wrote:	[Fri Oct 04 2013, 02:00:59PM EDT]
> >> It's the trickiest change, as it changes the PMD layout completely.
> >> 
> >> If the problem persists, the next point to check is where the huge
> >> page size gets adjusted to 8MB from 4MB.  Try reverted to just before
> >> that change and test again.  That's the other major possible source of
> >> errors.
> > Yes, I suspected this and the reason for bottom up.
> > 
> > It seems to be here. With 9/9 and 8/9 reverted, the issue persists. Virgin
> > 3.11 is solid. Of course there is always the possibility of mistake(s).
> > 
> > I've obviously missed an issue. Looking...
> 
> Please, explicitly test both at the point where huge pages go from
> 4MB to 8MB and exactly right before that change.
I've done this on 3.12-rc4. The point (7/9) where we transition HPAGE_SHIFT
there are the issues already described with THP.
> 
> Testing just a vanilla tree leaves too many variables in between.
I agree.
