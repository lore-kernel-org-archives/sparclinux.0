From: Meelis Roos <mroos@linux.ee>
Date: Wed, 16 Feb 2005 14:15:47 +0000
Subject: Re: PATCH to fix initialisation issue for GC3 (linux-2.5.64 +).
Message-Id: <E1D1Pxz-0003sv-C4@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

MF> This patch fixes an error in the blanking code for the GCThree SBUS
MF> video card. Now I get a logo and black screen, not just a blank (no
MF> video) screen. It is a trivual fix that has taken too long to identify as
MF> it is such a small typing error during the rewriting of the code for
MF> the new frame buffer system introduced in the 2.5 series kernels.

The "val &= ~CG3_CR_ENABLE_VIDEO;" bit is in main kernel now. But what
about the readl/writel vs readb/writeb - is this also needed? Why?

-- 
Meelis Roos
