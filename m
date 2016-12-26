From: David Miller <davem@davemloft.net>
Date: Mon, 26 Dec 2016 17:05:35 +0000
Subject: Re: [PATCH] sparc64: fix mmap fixed and shared on sun4u
Message-Id: <20161226.120535.295301322320474012.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482359149-59788-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482359149-59788-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 14:25:49 -0800

> Older sparc64 must have a VAC because there is concern that mmapping fixed
> and shared with incorrect align would cause cache aliases. This is not an
> issue for sun4v.
> 
> We will enforce the rigid alignment condition only for tlb_type != hypervisor.
> 
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

This is just asking people to write programs that won't work on
pre-Niagara machines.

I'm not applying this, having a SHMLBA (16K) alignment requirement for
shared mmapings is quite reasonable.
