From: David Miller <davem@davemloft.net>
Date: Sat, 10 Nov 2012 03:48:29 +0000
Subject: Re: [PATCH v2] sparc: Add sparc support for platform_get_irq()
Message-Id: <20121109.224829.482114751048231920.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350546164-8017-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 18 Oct 2012 09:42:44 +0200

> This adds sparc support for platform_get_irq that in the normal case use
> platform_get_resource() to get an irq. This standard approach fails for sparc as
> there are no resources of type IORESOURCE_IRQ for irqs for sparc.
> 
> Cross platform drivers can then use this standard platform function and work on
> sparc instead of having to have a special case for sparc.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Applied.
