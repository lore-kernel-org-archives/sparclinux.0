From: Uli Luckas <luckas@musoft.de>
Date: Tue, 08 Jun 2004 07:22:44 +0000
Subject: Re: sun4c driver/dma problems
Message-Id: <200406080922.45479.luckas@musoft.de>
List-Id: <sparclinux.vger.kernel.org>
References: <200406020818.13705.luckas@musoft.de>
In-Reply-To: <200406020818.13705.luckas@musoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Am Mittwoch, 2. Juni 2004 08:18 schrieb Uli Luckas:
> Hi,
> there seem to be all sorts of driver problems with the 2.6 Kernels and my
> Sparc Clone "GoldStar SPARC Workstation GWS-20".
> The box is a sun4c architecture with integrated SunLANCE networking
> (external tranciver), cg3 framebuffer and 1 ESP SCSI controller.
> It is operated as a diskless workstation and works with 2.2 series kernels
> (2.2.26).

> DMA
> => All problems (see below) could of course be linked to this boot message?
> dma0 unknown dma version 70000000
>
Hi,
the above cited DMA message seems to be the root of the driver problems. From 
the 2.2.26 kernel I know it should read:
dma0: Revision 1

So what can I do to help, getting this fixed? Who works on this code?
I already know, it's not only the version detection. Defining a new version 
70000000 "Revision 1 broken" and initialising it just as a "Revision 1" works 
around the above message, but all the device drivers report all kind of DMA 
related problems later on and of course don't work.

Please, if someone would look into this, I could arange for access to this 
machine, running 2.2.26. And would be more than pleased to assist in 
isolating the problem.

Regards
Uli

