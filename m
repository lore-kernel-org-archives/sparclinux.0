From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 22:09:54 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <200701de-e37a-f9e9-f202-9027c68c3c44@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 29/06/17 21:10, David Miller wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Date: Thu, 29 Jun 2017 20:32:56 +0100
> 
>> On 29/06/17 16:23, David Miller wrote:
>>
>>> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Date: Thu, 29 Jun 2017 08:18:40 +0100
>>>
>>>> Is that using drm at all?
>>>
>>> Using DRM fully.
>>
>> So I guess it must be something that bochs_drm is specifically doing?
> 
> Who knows, it means that DRM hasn't been tested and tracked on sparc64
> since I got the radeon working several years ago.
> 
> When I'm in front of that computer in a few weeks I can try to play
> with things again.

Okay. Peeking at the various other PCI drivers I see a similar pattern
with ioremap() there too, i.e.

    addr = pci_resource_start(pdev, 0);
    size = pci_resource_len(pdev, 0);
    bochs->fb_map = ioremap(addr, size);

Looking at a couple of other driver examples I see in several cases that
accesses to memory returned by ioremap() are done with
readb/readw/readl/readq accessors which seems correct for SPARC64 in
that the accesses would take place with the ASI_PHYS_BYPASS_EC_E_L ASI.

This definitely isn't the case with the blit routines in
drivers/video/fbdev/core/sysimgblt.c as they reference the address
directly via a pointer so could this be the bug? This would seem to
agree with the documentation at
https://01.org/linuxgraphics/gfx-docs/drm/driver-api/device-io.html.

Finally for reference, what was your last known good kernel for radeon?


ATB,

Mark.

