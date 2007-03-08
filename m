From: Emanuele Rocca <ema@debian.org>
Date: Thu, 08 Mar 2007 22:12:57 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070308221257.GA22315@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello David,

* David Miller <davem@davemloft.net>, [2007-03-05  1:11 -0800]:
>  Anyone with a SunBlade100 or SunBlade150 trying to use
>  kernels built with gcc-4.1.x or later and seeing hangs
>  should try out this patch.
>  
>  GCC-4.1.x and later optimize away this poorly constructed
>  delay, so there is no delay, and the chip hangs.
>  
>  I'll put a proper version of this fix, using a udelay(),
>  upstream very soon.

My SunBlade2000 seems to hang at "Booting kernel...". However, the
system seems to boot correctly (I'm able to login via ssh).

Is your patch supposed to work only on SB100/150?
I've tried it on a 2.6.20 kernel and the problem persists.

dmesg diff (booting without and with atyfb:off):

-Kernel command line: root=/dev/sda2 ro
+Kernel command line: root=/dev/sda2 ro video=atyfb:off

-atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
-atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
-Console: switching to colour frame buffer device 80x30
-atyfb: fb0: ATY Mach64 frame buffer device on PCI
+Console: switching to colour frame buffer device 144x56

-ioctl32(Xorg:4226): Unknown cmd fd(6) cmd(40584606){00} arg(ff3f7a7c) on /dev/fb0
-ioctl32(Xorg:4226): Unknown cmd fd(6) cmd(40184600){00} arg(ff3f7a84) on /dev/fb0
-ioctl32(Xorg:4290): Unknown cmd fd(6) cmd(40584606){00} arg(ff7c1a7c) on /dev/fb0
-ioctl32(Xorg:4290): Unknown cmd fd(6) cmd(40184600){00} arg(ff7c1a84) on /dev/fb0
-ioctl32(Xorg:4301): Unknown cmd fd(6) cmd(40584606){00} arg(ff9e7a7c) on /dev/fb0
-ioctl32(Xorg:4301): Unknown cmd fd(6) cmd(40184600){00} arg(ff9e7a84) on /dev/fb0

ciao,
    ema
