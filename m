From: David Miller <davem@davemloft.net>
Date: Mon, 26 Dec 2016 17:01:41 +0000
Subject: Re: [PATCH] sparc64: Support reserving memory with memmap=xxx$yyy
Message-Id: <20161226.120141.1393157344805849074.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482359056-59721-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482359056-59721-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 14:24:16 -0800

> The kernel commandline parameter memmap= was supported
> on several other architectures but not on SPARC (it was
> being ignored on SPARC).
> 
> Add support for the memmap=xxx$yyy commandline parameter
> (sparc64 only). The patch is based on the existing
> code for the "tile" architecture.
> 
> There are other types of memmap= commandlines which
> are only supported on x86 that are e820-specific.
> These were not implemented.
> 
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>

Are you adding this purely to achieve feature parity with other
architectures, or do you have an actual use case for this?

Nobody has asked for this for two decades, so I don't see why adding
it now has any real value without an actual user request.

And it's going to eat 1K of unswappable kernel space for something
almost nobody will actually use.

Thanks.
