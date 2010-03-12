From: Frans van Berckel <fberckel@xs4all.nl>
Date: Fri, 12 Mar 2010 07:54:39 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268380479.1741.12.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2010-03-11 at 09:58 -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 11 Mar 2010 08:16:01 -0800 (PST)
> 
> > From: Frans van Berckel <fberckel@xs4all.nl>
> > Date: Thu, 11 Mar 2010 09:30:31 +0100
> > 
> >> Thanks for asking. Attaching XVR 1000 (SUNW,gfb) prtconf -pv.
> > 
> > We were talking about XVR-1200, and this isn't an XVR-1200, it's not
> > even a PCI card.
> > 
> > It does occupy a PCI slot because it is so huge, but it actually
> > operates out of the UPA slot.
> 
> Anyways, here is a quick attempt at a driver for this card:
> 
> sparc64: Add very basic XVR-1000 framebuffer driver.

Oh that sound rely nice, wanne say thank you! Gonna test this XVR 1000
patch later on and will report the results.



Frans van Berckel

