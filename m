From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 23:38:41 +0000
Subject: Re: vmalloc can clobber framebuffer on sparc32
Message-Id: <20060707.163841.34582674.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448D0D0D.8080606@mc.net>
In-Reply-To: <448D0D0D.8080606@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 13 Jun 2006 10:23:56 +0100 (BST)

> Why don't you just move the VMALLOC area to say FC000000. I did this on my
> sparc32 system to alow me to debug some PROM Console/CG3 issues. I did not
> observe any failures/anomalies with this and is gets around any problems
> with the PROM memory mapping of frame buffers.

As Bob mentioned, we can't do this because the SRMMU no-cache
area lives there.

I have the foundations of a better solution in the current 2.6.18-rc1
tree.

The cg14 et al. drivers always IO map the framebuffer and registers
explicitly, and do not try to use the "address" property based
existing mapping of the device.

The only part missing is the code in the bootup VM initialization
that needs to ignore all existing mappings outside of the designated
OBP area.

Bob, could you work on and test that?

Thanks a lot.
