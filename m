From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 08 Oct 2004 03:45:57 +0000
Subject: Re: Linux prom mmu mapping expectations?
Message-Id: <20041007204557.2fce142b.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F40FRaqbC8wSA0001e56f@hotmail.com>
In-Reply-To: <BAY12-F40FRaqbC8wSA0001e56f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 07 Oct 2004 20:22:38 +0200
"Blue Swirl" <blueswir1@hotmail.com> wrote:

> Background: I've been trying to get Qemu run Linux 2.6.8.1 for sparc32, but 
> currently there is a MMU fault at srmmu_early_allocate_ptable_skeleton.  The 
> code in question is as follows:
> 0xf00fdec4:  ldd  [ %o1 + -64 ], %g2
> 0xf00fdec8:  ldd  [ %o1 + -56 ], %g4
> 0xf00fdecc:  st  %g2, [ %o0 + -64 ]
> 0xf00fded0:  st  %g3, [ %o0 + -60 ]
> 0xf00fded4:  st  %g4, [ %o0 + -56 ]
> 0xf00fded8:  st  %g5, [ %o0 + -52 ]
> 0xf00fdedc:  ldd  [ %o1 + -48 ], %g2
> 0xf00fdee0:  ldd  [ %o1 + -40 ], %g4
> 
> This code is in memcpy, but I can't find where it is called from in the 
> function (srmmu_early_allocate_ptable_skeleton, srmmu.c).
> 
> The faulting address is 0xf00fdec4, %o1 is 0xf0000000. There is no MMU 
> mapping at the address. I tried adding some code into Proll to map the area, 
> but that didn't help.

0xf0000000 is KERNBASE, and arch/sparc/kernel/head.S load mappings for the
entire kernel image, starting at KERNBASE, into the MMU.
