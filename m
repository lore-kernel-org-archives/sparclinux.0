From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 23:25:31 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150422.192531.91010482219929120.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Wed, 22 Apr 2015 17:19:23 -0600

> Only thing left in my queue is optimized versions of the ffs / fls
> families, but that patch is v9b specific, not M7.

Something faster than the popc thing in arch/sparc/lib/ffs.S?

Are you thinking of using "lzcnt"?  I wasn't impressed with the
performance of that instruction last time I played around with it.

> I'd like to put some attention on precise mode for perf counters; it
> just has not bubbled to the top.

That plus the backtrace deadlock thing we're discussing in another
thread, that bug is irritating because your pagefault_disable() change
should "just work".
