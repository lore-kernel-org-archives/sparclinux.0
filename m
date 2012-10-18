From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 18 Oct 2012 07:44:29 +0000
Subject: Re: [PATCH] sparc: Add sparc support for platform_get_resource()
Message-Id: <507FB35D.9020103@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1350545996-7823-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1350545996-7823-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2012-10-18 09:39, Andreas Larsson wrote:
> This adds sparc support for platform_get_irq that in the normal case use
> platform_get_resource() to get an irq. This standard approach fails for sparc as
> there are no resources of type IORESOURCE_IRQ for irqs for sparc.

Sorry, subject line incorrect. New version sent.

Cheers,
Andreas

