From: David Miller <davem@davemloft.net>
Date: Wed, 12 Apr 2017 02:14:44 +0000
Subject: Re: 4.10 sparc64 regression: BUG: soft lockup - CPU#0 stuck for 23s! [khugepaged:153]
Message-Id: <20170411.221444.2224821262010929669.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1703101935240.21677@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 9 Apr 2017 15:09:07 +0300 (EEST)

>> > I am seeing the following soft lockup on multiple Ultrasparc II era 
>> > sparc machines - Ultra 2, Netra X1, Blade 100 at least. 4.9 was fine. 
>> > Will attempt to bisect some time.
>> 
>> Also seeing both warnings on T2000, so not specific to UltraSparc II.
> 
> Yesterday evening git has fixed that - at first it seems all affected 
> servers are OK.
> 
> I do not know when it was fixed - did not have time to test anything 
> more since I found the problem.

I was probably the THP bug fix:

commit 76811263b3fa6347699a446cddeb63badf3e6095
Author: Nitin Gupta <nitin.m.gupta@oracle.com>
Date:   Fri Mar 31 15:48:53 2017 -0700

    sparc64: Fix memory corruption when THP is enabled
    
    The memory corruption was happening due to incorrect
    TLB/TSB flushing of hugepages.
    
    Reported-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
