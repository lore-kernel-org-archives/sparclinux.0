From: David Miller <davem@davemloft.net>
Date: Thu, 20 Dec 2007 12:53:59 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071220.045359.107684960.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071216.202611.226170474.davem@davemloft.net>
	<20071216223917.873e34bf.akpm@linux-foundation.org>
	<20071217145554.GD19691@waste.org>
In-Reply-To: <20071217145554.GD19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpm@selenic.com
Cc: akpm@linux-foundation.org, m.kozlowski@tuxland.pl, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Mon, 17 Dec 2007 08:55:54 -0600

> On Sun, Dec 16, 2007 at 10:39:17PM -0800, Andrew Morton wrote:
> Actually, you may only need these two:
> 
> > maps4-add-proc-kpagecount-interface.patch
> > maps4-add-proc-kpageflags-interface.patch

Yes these two were enough, and exporting fs/proc/base.c's
mem_lseek().

As hard as I try, I can't reproduce this at all.  I tried
both on my workstation and my niagara boxes.

It must be other needle in the 30MB+ -mm haystack. :-(

