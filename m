From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Fri, 22 Aug 2008 01:15:37 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <1219367743.26429.66.camel@jdub.homelinux.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.142134.127315039.davem@davemloft.net>
	 <48ADDF86.2040200@freescale.com>
	 <fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
	 <20080821.163216.239892875.davem@davemloft.net>
In-Reply-To: <20080821.163216.239892875.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: grant.likely@secretlab.ca, scottwood@freescale.com, sparclinux@vger.kernel.org, devicetree-discuss@ozlabs.org, paulus@samba.org, linuxppc-dev@ozlabs.org

On Thu, 2008-08-21 at 16:32 -0700, David Miller wrote:
> From: "Grant Likely" <grant.likely@secretlab.ca>
> Date: Thu, 21 Aug 2008 17:14:57 -0600
> 
> > On Thu, Aug 21, 2008 at 3:35 PM, Scott Wood <scottwood@freescale.com> wrote:
> > > David Miller wrote:
> > >>>
> > >>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> > >> If you guys created this format in your compressed openfirmware
> > >> trees, is it possible for you to "fix" it to match what Sparc
> > >> systems following the proper bindings do?
> > >
> > > Possibly, though it'll cause some pain when old trees are used with a kernel
> > > that expects the new binding.
> > 
> > Ugh, more like loads of pain.  There are deployed platforms using the
> > embedded 'invented' bindings.  I don't think it is an option to break
> > compatibility with older trees.  If there is some backwards
> > compatibility code then I'm all for migrating to the same binding as
> > Sparc and PowerMac
> 
> You could even put the detection and reg property fixups in the device
> tree expander.  This way generic code in drivers/of/of_i2c.c doesn't
> need to know about this huge mistake.

Huge?  I'd say mistake, but not necessarily huge.  I mean nobody other
than you (at least in the context of this conversation) had access to
the IEEE1275 proposed binding so it wasn't like there was tons to go on.

Have patience with the embedded people that are both new to OpenFirmware
and trying to make stuff work at the same time.  I think the
devicetree-discuss list will help here as new bindings are proposed.  I
hope you're subscribed.

josh

