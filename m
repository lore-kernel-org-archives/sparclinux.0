From: Frans van Berckel <fberckel@xs4all.nl>
Date: Wed, 05 Jan 2011 21:37:05 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <1294263425.1562.8.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks for patching. Will build and test, first thing next day.

Frans van Berckel

On Wed, 2011-01-05 at 13:09 -0800, David Miller wrote:
> After commit 25edd6946a1d74e5e77813c2324a0908c68bcf9e ("sparc64: Get
> rid of indirect p1275 PROM call buffer.")  we can't pass virtual
> addresses >4GB to PROM calls.
> 
> Largely this is never necessary in drivers because we have a copy of
> the entire PROM device tree in the kernel and a set of of_*()
> interfaces to access it.
> 
> Unfortunately there were some lingering prom calls in the atyfb
> driver, in particular prom_finddevice() was being called with an
> on-stack address which could be anywhere.
> 
> This code is actually probing for information we already have, the
> PROM choosen console output device is stored in of_console_device so
> all of this nasty code consolidates into a one-line comparison.
> 
> Next we have some prom_getintdefault() calls which are trivially
> transformed into the equivalent of_getintprop_default().
> 
> Special thanks to Fabio, who figured out exactly where the bootup
> was hanging.  That made this bug trivial to fix.
> 
> Reported-by: Fabio M. Di NItto <fabbione@fabbione.net>
> Reported-by: Sam Ravnborg <sam@ravnborg.org>
> Reported-by: Frans van Berckel <fberckel@xs4all.nl>
> Signed-off-by: David S. Miller <davem@davemloft.net>

