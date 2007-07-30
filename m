From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2007 03:41:20 +0000
Subject: Re: ioctl32 warning on framebuffer
Message-Id: <20070729.204120.75192393.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272220560.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 29 Jul 2007 19:32:47 +0300 (EEST)

> The warnings are gone but I do not know whether X actually work since 
> the box is headless in a rack and X runs only by accident (it rised its 
> head again when I enabled atyfb compilation). Trying to run X by hand 
> now gives
> 
> Fatal server error:
> xf86MapPciMem: Could not mmap PCI memory [base=0xe2000000,hostbase=0xe2000000,size 00] (Inappropriate ioctl for device)
> but this could be because OF may have disabled the device (OF thinks 
> there is no monitor since the ID pins in VGA connector have appearantly broken - 
> but no visible brokenness).

There have been several patches posted recently which should
cure X on sparc64, make sure you have them all applied.  It
could cause exactly this error.

In particular, I think you're hitting the fs/proc/inode.c bug
fix I made which got checked into Linus's tree yesterday.

 ...
> so the memory regions are at 1ffe1000000, not e2000000 - but maybe this 
> is remapped automatically?

e20000000 is the PCI bus-centric address of the device, the
larger address is the physical address.

X is using the correct address for the mmap().
