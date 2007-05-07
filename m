From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 22:34:18 +0000
Subject: Re: XVR-500 support in XVR-2500 driver?
Message-Id: <20070507.153418.111204664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705072317540.4832@math>
In-Reply-To: <Pine.SOC.4.64.0705072317540.4832@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Mon, 07 May 2007 16:23:41 -0500

> Thanks for these drivers, fills a much requested void!
> 
> Do you know if there is a matching xorg driver to go along with the
> kernel implementation?

I reverse engineered the hardware by poking at these chips from the
firmware prompt for nearly a week, so what's there is the best I could
come up with.

Using the 'fbdev' driver, Xorg should just work with the XVR2500 but
there will be an ugly white boarder around the graphics screen just as
the current kernel console will have.  The board comes up in 32bpp
mode so that's what you'll need to use in xorg.conf

I cannot say the same for the XVR500 because of the funny mode the
framebuffer comes up in from the OBP.

So until I make some more progress reverse engineering these cards,
support is still currently half-assed.

At least there is some native kernel text console for this chips now.

Ideally I should be able to get it to the point where dumb framebuffer
Xorg support should work fully for both chips.  However, I doubt I'll
be able to add hw acceleration any time soon as these chips are very
complicated (they use DMA commands to do hardware rendering etc.), are
completely undocumented, and there's zero chance 3dlabs is going to
ever release the specs for these board to help the effort along.
