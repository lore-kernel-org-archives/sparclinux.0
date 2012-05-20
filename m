From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 20:39:51 +0000
Subject: Re: [PATCH 2/2] sparc32: use flushi when run-time patching in per_cpu_patch
Message-Id: <20120520.163951.1482013956981046721.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120520153334.GB13857@merkur.ravnborg.org>
In-Reply-To: <20120520153334.GB13857@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 17:33:34 +0200

>>From ddbad389ff8ab3b0c3c2a04fb31c3bffdc8e578f Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 20 May 2012 17:27:53 +0200
> Subject: [PATCH 2/2] sparc32: use flushi when run-time patching in per_cpu_patch
> 
> Davis S. Miller wrote:
> "
> The way we do that now is overkill.  We only needed to use the MMU
> cache ops when we had sun4c around because sun4c lacked support for
> the "flush" instruction.
> 
> But all sun4m and later chips have it so we can use it
> unconditionally.
> 
> So in the per_cpu_patch() code, get rid of the cache ops invocation,
> and instead execute a "flush %reg" after each of the instruction patch
> assignments, where %reg is set to the address of the instruction that
> was stored into.
> 
> Perhaps take the flushi() definition from asm/cacheflush_64.h and
> place it into asm/cacheflush.h, then you can simply use that.
> "
> 
> Implemented as per suggestion.
> Moved run-time patching before we call paging_init(),
> so helper methods in paging_init() may utilise run-time patching too.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Looks perfect, applied, thanks.
