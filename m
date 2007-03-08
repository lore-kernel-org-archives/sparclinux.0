From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2007 23:08:48 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070308.150848.23015147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Thu, 8 Mar 2007 23:36:44 +0100

> * David Miller <davem@davemloft.net>, [2007-03-08 14:19 -0800]:
> >  Does the device show up with "lspci" when the console doesn't come up
> >  like this?  
> 
> Yes, it does.
> 
> 0001:00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
>         Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
>         Memory at 7fe02000000 (32-bit, non-prefetchable) [sizeM]
>         I/O ports at 7ffef000500 [size%6]
>         Memory at 7fe0012c000 (32-bit, non-prefetchable) [size=4K]
>         Expansion ROM at 7fe00140000 [disabled] [size8K]
>         Capabilities: <access denied>

Ok.  Let me think about how to debug this.

Can you build test kernels if I give you a patch?
Otherwise I can build test images for you.

