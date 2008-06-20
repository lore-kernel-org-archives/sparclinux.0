From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 20:37:21 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080620.133721.95818057.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
	<20080620.102601.06998427.davem@davemloft.net>
	<Pine.LNX.4.64.0806201624280.3668@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806201624280.3668@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 16:34:23 -0400 (EDT)

> And what if network softirq happened here? How much stack does it consume?
> 
> The whole overflowed stack trace has 75 functions, I was able to get rid 
> of 9 by avoiding bio_endio recursion and 10 by turning simple functions 
> into inlines. --- so is it enough or not enough for possible networking 
> calls?

It should be OK, because the minimum stack of a (75 - 19) depth call
chain is under 11K and within safe limits I believe.

> Maybe a good thing would be to add a check for stack size to __do_softirq 
> and handing the softirq to ksoftirqd if there's not enough space.

I'd rather it spit out a WARN_ON() message and a backtrace.

Otherwise it will be considered a feature and people won't fix
these deep call chains.
