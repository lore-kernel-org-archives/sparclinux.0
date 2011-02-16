From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 16 Feb 2011 23:21:20 +0000
Subject: Re: [PATCH 0/22] Make SVGA oriented FBs work on multi-domain PCI
Message-Id: <1297898480.13315.36.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <20110111.154846.233419170.davem@davemloft.net>
In-Reply-To: <20110111.154846.233419170.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 2011-02-17 at 00:01 +0100, Ondrej Zary wrote:
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Just tested arkfb and s3fb and they seem to still work fine (on x86)
> with these changes. 

Hmm, that's odd. The exact same driver with the updates crashes on sparc
hardware. So far, I've not been able to figure out why it does.
-- 
Tactical Nuclear Kittens
