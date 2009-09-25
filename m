From: David Miller <davem@davemloft.net>
Date: Fri, 25 Sep 2009 21:18:25 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925.141825.24732012.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Sep 2009 14:15:38 -0700

> hm, I tried to fix this but my sparc32 cross-compiler broke.
> 
> ARCH=sparc:
> 
> scripts/mod/empty.c:1: error: -m64 is not supported by this configuration
> scripts/mod/empty.c:1: error: -mlong-double-64 not allowed with -m64
> scripts/mod/empty.c:1: error: -mcmodel= is not supported on 32 bit systems
 ...
> How'd that -m64 get in there?

That's really odd.

Sam, any idea?
