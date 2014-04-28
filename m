From: Meelis Roos <mroos@linux.ee>
Date: Mon, 28 Apr 2014 12:41:55 +0000
Subject: Re: [PATCH 0/3] Fix several sparc64 THP bugs.
Message-Id: <alpine.SOC.1.00.1404281526190.1407@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140425.154337.1159533755150765063.davem@davemloft.net> <alpine.SOC.1.00.1404262308350.3958@math.ut.ee> <20140427.233300.1841871634019126565.davem@davemloft.net>
In-Reply-To: <20140427.233300.1841871634019126565.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, aaro.koskinen@iki.fi, hughd@google.com, linux-kernel@vger.kernel.org

> >> Meelis and Aaro, I've found and fixed several THP bugs for sparc64
> >> over the last week or so.
> >> 
> >> I cannot %100 account for the exit_mmap() WARN_ON that you two have
> >> been able to trigger, however I'd like you both to test the changes
> >> nonetheless.
> >> 
> >> They are against 3.15 but they should apply cleanly all the way back
> >> to 3.13
> >> 
> >> Thanks in advance for testing.
> > 
> > Tried it on Netra X1, Ultra 2 and V100 that were online (applied the 
> > patches and enabled THP with defaulting to always).
> > 
> > Ultra 2 did not boot up (will see on Monday).

When I rebooted it, the hang is not reproducible - Debian dist-upgrade 
went well. However, it is still strange.

-- 
Meelis Roos (mroos@linux.ee)
