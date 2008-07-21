From: David Miller <davem@davemloft.net>
Date: Mon, 21 Jul 2008 23:50:09 +0000
Subject: Re: [PATCH 1/4] ide: <asm-sparc64/ide.h>: use %r0 for outw_be()
Message-Id: <20080721.165009.168239842.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
In-Reply-To: <20080714153825.9085.98433.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Jul 2008 17:38:25 +0200

> Use %r0 for outw_be() to make it match __raw_writew().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> against ide tree
> 
> I'm a bit confused by this optimization but since __raw_write* use it...

This allows the compiler to use the "zero" register %g0
when storing a zero value.

Applied, thanks Bart.
