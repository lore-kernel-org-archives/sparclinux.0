From: David Miller <davem@davemloft.net>
Date: Fri, 29 Dec 2006 23:24:52 +0000
Subject: Re: [PATCH] sparc64: isa.c should cope with OBP nodes with no
Message-Id: <20061229.152452.38711630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1166915246238-git-send-email-richm@oldelvet.org.uk>
In-Reply-To: <1166915246238-git-send-email-richm@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Fri, 29 Dec 2006 22:47:25 +0000

> I didn't get a fix with this mail and cannot see any on your git trees
> on kernel.org (then again I may have been looking at the wrong ones).

I forgot to push last night before going to bed, sorry :-)

I did just push to my sparc-2.6.git tree, so it should show up
on the mirrors soon.

> As far as the fix is concerned I did originally send you two patches.
> The first was the fix for the problem and the second cleaned up the
> pregs issue. Not that it bothers me. I'm happy if the kernel boots :-)

Aha, indeed!

I'll push the fix to the 2.6.x -stable branches as well.
