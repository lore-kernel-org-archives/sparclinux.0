From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 27 Feb 2006 00:50:20 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060226.165020.30001220.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 26 Feb 2006 17:41:19 -0700

> As my previous git bisect attempt had been done via building kernels on
> a different box that contained gcc-3.3.6, I now ran git bisect on a box
> with gcc-3.4.5.  What it appears to have boiled down to after running
> git bisect and making sure I'm not running off into left field with
> something else is the "[SPARC64]: Stop putting -finline-limit=XXX into
> CFLAGS" patch from 20 Dec 2005. [2].  

This change you mention as [2] is specifically needed to "fix" the
build with -Os specified.  Otherwise gcc inlines the schedule()
function in kernel/sched.c into other functions and all hell breaks
loose.

The ESP driver has an incredibly deep function call chain so this may
be playing into it.

So what _exact_ GIT tree did you first test Christophe's ESP spinlock
fix with, the one you refer to as "the same tree on the Ultra 1 as the
original bug was posted against"?  Please always list such details and
do not refer to specific kernel trees in such a vague manner.

If have to admit that I do all of my kernel work with gcc-4.0.x these
days as that has become the default compiler on all the Debian derive
dists.
