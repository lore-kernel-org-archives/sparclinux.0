From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 16 Feb 2011 23:37:05 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <1297899425.13315.56.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 2011-02-16 at 15:24 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Wed, 16 Feb 2011 23:21:20 +0000
> 
> > On Thu, 2011-02-17 at 00:01 +0100, Ondrej Zary wrote:
> >> > Signed-off-by: David S. Miller <davem@davemloft.net>
> >> 
> >> Just tested arkfb and s3fb and they seem to still work fine (on x86)
> >> with these changes. 
> > 
> > Hmm, that's odd. The exact same driver with the updates crashes on sparc
> > hardware. So far, I've not been able to figure out why it does.
> 
> We know why it does, because sparc systems do not initialize the VGA
> hardware in the BIOS the way a PC will.
> 
> That's the whole gist of the most recent thread we had where we were
> trying to diagnose your crashes.
> 
> We simply haven't figured out the magic that will get this to work.
> 
> So it's perfectly fine and expected that platforms where these drivers
> worked before, still work fine.

OK, I'd forgotten that the VGA hardware needs initialising. 
-- 
Tactical Nuclear Kittens
