From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jan 2011 19:51:23 +0000
Subject: Re: [PATCH v3] cassini: Use local-mac-address prom property for
Message-Id: <20110106.115123.35031451.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294324455.6193.70.camel@duncow>
In-Reply-To: <1294324455.6193.70.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 14:34:15 +0000

>>From 603b3377a6857448006c886f10c607d07c102b64 Mon Sep 17 00:00:00 2001
> From: Richard Mortimer <richm@oldelvet.org.uk>
> Date: Thu, 6 Jan 2011 00:08:54 +0000
> Subject: [PATCH] cassini: Use local-mac-address prom property for Cassini MAC address
> 
> Fallback on the local-mac-address prom property if the Cassini device
> does not have an address programmed in the VPD ROM. This uses the same
> technique as implemented by the sungem driver.
> 
> The problem was reported by Frans van Berckel using Debian kernel 2.6.34-7
> on Sun Fire V440. udev was assigning a new eth<n> device name on each reboot
> because the cassini driver was using a random MAC address.
> 
> Fix tested on 2.6.34-7 and 2.6.37 Sun Fire V440. Compile tested against
> 2.6.36 davem/sparc-2.6.git
> 
> Reported-by: Frans van Berckel <fberckel@xs4all.nl>
> Tested-by: Frans van Berckel <fberckel@xs4all.nl>
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>

Applied, thanks a lot.
