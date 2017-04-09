From: Meelis Roos <mroos@linux.ee>
Date: Sun, 09 Apr 2017 12:09:07 +0000
Subject: Re: 4.10 sparc64 regression: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]
Message-Id: <alpine.LRH.2.20.1704091507590.5383@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > I am seeing the following soft lockup on multiple Ultrasparc II era 
> > sparc machines - Ultra 2, Netra X1, Blade 100 at least. 4.9 was fine. 
> > Will attempt to bisect some time.
> 
> Also seeing both warnings on T2000, so not specific to UltraSparc II.

Yesterday evening git has fixed that - at first it seems all affected 
servers are OK.

I do not know when it was fixed - did not have time to test anything 
more since I found the problem.

-- 
Meelis Roos (mroos@linux.ee)
