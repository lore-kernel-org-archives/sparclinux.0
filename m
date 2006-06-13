From: David Miller <davem@davemloft.net>
Date: Tue, 13 Jun 2006 06:54:44 +0000
Subject: Re: vmalloc can clobber framebuffer on sparc32
Message-Id: <20060612.235444.90823744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448D0D0D.8080606@mc.net>
In-Reply-To: <448D0D0D.8080606@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Mon, 12 Jun 2006 01:43:25 -0500

> after rearrange and fill gaps:
>    start  -  end    (  size  )   type
>   00000000-fe3fffff (fe400000)  free
>   fe400000-fe6fffff (00300000)  free
>     fe600000 = VMALLOC_START
>   fe700000-feefffff (00800000)  unavail (cg14 framebuffer)
>   fef00000-ffcfffff (00e00000)  free
>     ffc00000 = VMALLOC_END
>   ffd00000-ffd25fff (00026000)  free
>   ffd26000-ffe3efff (00119000)  unavail
>   ffe3f000-ffebffff (00081000)  free
>   ffec0000-ffefffff (00040000)  unavail
>   fff00000-ffffffff (00100000)  free
> 
> The framebuffer sitting in the middle of the vmalloc range is what
> causes the problem.

Ok.  Let's take a peek at what NetBSD thinks about the layout
here... They assume the same start and end address for openprom.

What we should probably do is explicitly sbus_ioremap() the
framebuffer on sparc32 even if OBP has a mapping setup already.
And then just clear out the areas outside of the kernel image
and the reserved OBP area.

I wonder if this will break things like promcons :(

