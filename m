From: David Miller <davem@davemloft.net>
Date: Thu, 03 Sep 2009 09:57:26 +0000
Subject: Re: [PATCH] silo: move second to make room for larger kernel
Message-Id: <20090903.025726.51525776.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A325654.3050201@earthlink.net>
In-Reply-To: <4A325654.3050201@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 17 Jun 2009 02:41:34 +0100 (BST)

> Making the relocate size bigger worked for sun4c with the some what
> limited capabilities of the SunOS 4.1 A.OUT loader last time I tried a
> new kernel. It is the only way I found of using a sun4c Linux kernels
> from about 2.6.16 to 2.6.23 (work got in the way so I have not done
> any testing of more recent kernels). I can't think of anything that
> will prevent it from working with more recent kernels.

Ok, if that works, the thing to do is:

1) Calculate "SUN4C_SEGMAP_ROUND_UP(&_end - KERNBASE)"

   Make this calculation a macro.

2) Use that instead of the 3MB constant in the sun4/sun4c remapping
   loops of head_32.S

I'd be happy to apply this if it can get at least a minimal smoke
test by someone.
