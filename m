From: David Miller <davem@davemloft.net>
Date: Mon, 14 Jan 2008 02:02:32 +0000
Subject: Re: gettimeofday not monotonous on sun4m
Message-Id: <20080113.180232.34922150.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080106224013.GA22464@palantir8>
In-Reply-To: <20080106224013.GA22464@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 13 Jan 2008 14:51:20 +0000

> It almost works. Reaching the l10 limit does not indicate a
> second overflow, but rather 10 milliseconds.

I actually checked in a fixed version which properly
divided by "HZ".  Thanks.

> I can still make it fail on SMP, gettimeofday is always off by 10 milliseconds.
> do_gettimeofday() uses read_seqbegin_irqsave(). This blocks the l10 interrupt
> from being taken on the local CPU, but I think it will just get taken on
> the other CPU. In essence xtime and l10_counter are not guaranteed to be
> consistent on all CPUs.

This means the update code isn't taking the seqlock as a writer
as it needs to.  Try adding that.
