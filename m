From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 19:49:58 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416194957.GA3282@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

* David Miller <davem@davemloft.net>, [2007-04-16 11:55 -0700]:
>  From: Emanuele Rocca <ema@debian.org>
>  Date: Mon, 16 Apr 2007 11:22:08 +0200
>  > atyfb_init: Invoked
>  > atyfb_init: Registering PCI device
>  > atyfb_pci_probe: Invoked
>  > atyfb: 3D RAGE XL (Mach64 GR, PCI-33) [0x4752 rev 0x27]
>  > atyfb: 8M SGRAM (1:1), 29.498928 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 63 MHz XCLK
>  > Console: switching to colour frame buffer device 80x30
>  > atyfb: fb0: ATY Mach64 frame buffer device on PCI
>  > atyfb_pci_probe: success
>  > /upa@8,480000/SUNW,afb@1,0: AFB at 000007fa00000000, type 35, DAC pnum[36e] rev[0] manuf_rev[1]
>  > ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40584606){00} arg(ff859a4c) on /dev/fb0
>  > ioctl32(Xorg:4213): Unknown cmd fd(6) cmd(40184600){00} arg(ff859a54) on /dev/fb0

>  Well, it came up fine, what's the problem?  Do you get a blank
>  screen or something?

Exactly, blank screen after 'Booting Linux...'.

And the following messages, which didn't come out booting without atyfb:

ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40584606){00} arg(fffd5a4c) on /dev/fb0
ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40184600){00} arg(fffd5a54) on /dev/fb0

ciao,
    ema
