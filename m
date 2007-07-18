From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jul 2007 22:25:21 +0000
Subject: Re: [PATCH] Mark sparc and sparc64 as not having virt_to_bus
Message-Id: <20070718.152521.132927068.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070718144140.3b4fd82e.sfr@canb.auug.org.au>
	<Pine.LNX.4.61.0707181458390.2120@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707181458390.2120@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: sfr@canb.auug.org.au, wli@holomorphy.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 18 Jul 2007 15:09:41 +0100 (BST)

> Currently, sun4c (and sun4m) do NOT support the FDC driver as a module.
> I did look at it but decided there were better issues to resolve at the 
> time.

The easiest thing to do is to make it so that the floppy driver
won't be set modular in drivers/block/Kconfig for SPARC.

