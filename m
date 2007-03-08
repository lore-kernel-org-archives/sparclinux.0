From: Emanuele Rocca <ema@debian.org>
Date: Thu, 08 Mar 2007 22:36:44 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070308223644.GA23119@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net>, [2007-03-08 14:19 -0800]:
>  That's weird.  2000's usually ship wit Radeon cards, but your
>  dmesg diff certainly shows that you have an atyfb in there.

I really don't know, I bought it used so maybe the previous owner added
it?
  
>  Does the device show up with "lspci" when the console doesn't come up
>  like this?  

Yes, it does.

0001:00:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
        Memory at 7fe02000000 (32-bit, non-prefetchable) [sizeM]
        I/O ports at 7ffef000500 [size%6]
        Memory at 7fe0012c000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 7fe00140000 [disabled] [size8K]
        Capabilities: <access denied>


>  Also what do the ATYFB kernel config options in your build
>  look like?

CONFIG_FB_ATY128=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y

ciao,
    ema
