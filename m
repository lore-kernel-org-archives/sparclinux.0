From: David Miller <davem@davemloft.net>
Date: Tue, 17 Apr 2007 18:45:30 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <20070417.114530.42774656.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ferris McCormick <fmccor@gentoo.org>
Date: Tue, 17 Apr 2007 14:05:59 +0000

> It's impossible to tell when a bug like this is fixed, of course,

Yes, that's why I hate these kinds of bugs.

> but I've been running U2(2x400)+kernel-2.6.20-r5+<this patch> since 26th
> June, and I have not seen a failure.  Now, I have not subjected the
> system to any particular stress tests, but before, the daily
> updatedb/makewhatis/update-eix cycle plus the daily (gentoo) --sync
> operations were enough to kill this system pretty quickly.
> 
> So right now, at least, I think you've probably killed the bug.

Thanks for the report.
