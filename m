From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 16 Feb 2005 16:27:21 +0000
Subject: Re: PATCH to fix initialisation issue for GC3 (linux-2.5.64 +).
Message-Id: <Pine.LNX.4.10.10502161615530.2233-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <E1D1Pxz-0003sv-C4@rhn.tartu-labor>
In-Reply-To: <E1D1Pxz-0003sv-C4@rhn.tartu-labor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Mellis,

The register masks are set up for an 8bit byte operation. If you use a
32bit read/write (readl/writel) you get very different results on a big
endian system (SPARC) when you apply a byte mask. This is why you need to
use 8bit (readb/writeb) operations.

In addition, using 8bit read/write will prevent corruption of any of the
next three registers if they have different read/write information.

Regards
	Mark Fortescue.

On Wed, 16 Feb 2005, Meelis Roos wrote:

> MF> This patch fixes an error in the blanking code for the GCThree SBUS
> MF> video card. Now I get a logo and black screen, not just a blank (no
> MF> video) screen. It is a trivual fix that has taken too long to identify as
> MF> it is such a small typing error during the rewriting of the code for
> MF> the new frame buffer system introduced in the 2.5 series kernels.
> 
> The "val &= ~CG3_CR_ENABLE_VIDEO;" bit is in main kernel now. But what
> about the readl/writel vs readb/writeb - is this also needed? Why?
> 
> -- 
> Meelis Roos
> 

