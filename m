From: David Miller <davem@davemloft.net>
Date: Fri, 04 Oct 2013 18:00:59 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131004.140059.1128128928574673275.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Fri, 4 Oct 2013 11:45:55 -0400

> We seem to have our first issue with THP.
> 
> I first encountered it with "ld". A THP enabled value of "never" resolved the
> issue.
> 
> Verified no issue on four level page table. Also no issue on x86_64 with
> 3.7.x and 3.11 with unmodified test code.

You may want to see if reverting the last patch in my series makes the
problem go away, as a data point.

It's the trickiest change, as it changes the PMD layout completely.

If the problem persists, the next point to check is where the huge
page size gets adjusted to 8MB from 4MB.  Try reverted to just before
that change and test again.  That's the other major possible source of
errors.

Thanks.
