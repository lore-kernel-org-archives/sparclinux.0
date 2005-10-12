From: Dennis Stosberg <dennis@stosberg.net>
Date: Wed, 12 Oct 2005 05:33:51 +0000
Subject: Re: linux-2.6.14-rc does not boot on Ultra 5
Message-Id: <20051012053351.GE2865@leonov.stosberg.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051011210428.GC2865@leonov.stosberg.net>
In-Reply-To: <20051011210428.GC2865@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

> Not aligning the kernel mapping physical address correctly.
> Please try this fix:
> 
> diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
> index f1dcdf8..4c942f7 100644
> +++ b/arch/sparc64/kernel/head.S

That fix makes the kernel boot again for me.

Thanks a lot, 
-Dennis
