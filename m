From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 04:45:05 +0000
Subject: Re: Sparc32 - SS5 - TCX-Framebuffer und RTC
Message-Id: <20041208204505.28d114e5.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41B7752C.90808@triaton-webhosting.com>
In-Reply-To: <41B7752C.90808@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 08 Dec 2004 21:30:18 -0600
Bob Breuer <breuerr@mc.net> wrote:

>  >     drivers/sbus/char/rtc.c:60: warning: initialization makes integer
>  > from pointer without a cast
>  >
> 
> Broken by a recent change in include/asm-sparc/mostek.h, need to include
> <asm/io.h> from there now.

I'll fix this.

> Does anyone know if sbus_readb/sbus_writeb should be used there instead of
> readb/writeb ?

Because it's a byte access, the endianness doesn't matter.  Therefore
the selection between sbus_readb() and readb() is arbitrary so I'll
just leave it alone.
