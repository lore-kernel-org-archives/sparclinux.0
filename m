From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 21:41:19 +0000
Subject: Re: [PATCH] sparc32: Convert mmu_* interfaces from btfixup to method ops.
Message-Id: <20120513214119.GA11416@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.170134.51396229221676970.davem@davemloft.net>
In-Reply-To: <20120513.170134.51396229221676970.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 13, 2012 at 05:01:34PM -0400, David Miller wrote:
> 
> This set of changes displays one major danger of btfixup, interface
> signatures are not always type checked fully.  As seen here the iounit
> variant of the map_dma_area routine had an incorrect type for one of
> it's arguments.
> 
> It turns out to be harmless in this case, but just imagine trying to
> debug something involving this kind of problem.  No thanks.

I found something similar for switch_mm().
It was an unused extra argument - so harmless too.

I like the _ops variants much better than any run-time patching
also for the readability.
When you see an _ops structure you know what to look for.

Are we going for _ops for everything?

	Sam
