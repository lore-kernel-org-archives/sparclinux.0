From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 23:29:55 +0000
Subject: Re: [PATCH] sparc32: add init memory poisoning
Message-Id: <20080903.162955.133251929.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48BF1A9F.6080100@earthlink.net>
In-Reply-To: <48BF1A9F.6080100@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Sep 2008 19:15:43 -0400

> This patch adds init memory poisoning.  It looks like
> totalram_pages was not updated properly in free_initrd_mem
> so I fixed that as well.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks a lot Robert.
