From: David Miller <davem@davemloft.net>
Date: Sun, 06 Jul 2008 22:51:11 +0000
Subject: Re: O_DIRECT produces wrong output on sparc
Message-Id: <20080706.155111.13159871.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080706221607.GA14571@palantir8>
In-Reply-To: <20080706221607.GA14571@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 6 Jul 2008 23:16:07 +0100

> Most of the LTP tests on direct IO fail on my sparc32 machines.
> I've testing on ext3 and ext2 filesystems, on SS10 and SS20, on 2.6.26-rc6
> and on 2.6.21. All these use the esp driver.

It's almost certainly cache coherency issues.

A missing flush_dcache_page() somewhere.
