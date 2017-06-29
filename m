From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 07:18:40 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <934876c4-ac57-4b1d-e606-bb9ce3a0e753@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 28/06/17 21:37, David Miller wrote:

> From: chase rayfield <cusbrar1@gmail.com>
> Date: Wed, 28 Jun 2017 16:32:06 -0400
> 
>> David, is that an XVR-100 or something newer? Mine doesn't work with
>> my Gentoo installation currently beyond the console... if so what
>> Distro/Release are you on? Maybe I can match to that and get it
>> working.
> 
> It's a built-from-source X server on an old debian install from
> about 5 years ago.

Is that using drm at all? As per my post a while back, I'm still
chipping away at trying to get the bochs_drm framebuffer fired up in
QEMU's sun4u.

So far I've managed to figure out that I need to add Simba support to
QEMU which is taking longer than expected as various OSs make
assumptions about the interrupt-swizzling for Ultra 5 on-board devices.

However outside of the interrupt issues, I now have something that
seemingly boots a kernel built from source and initialises the IOMMU
correctly. Now all I need to do now is figure out why the DRM memory
mapping routines never map the framebuffer to a virtual address and
always fallback to returning the physical address...


ATB,

Mark.

